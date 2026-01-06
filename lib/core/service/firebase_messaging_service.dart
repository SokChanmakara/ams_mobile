import 'dart:async';
import 'package:ams_mobile/core/service/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

class FirebaseMessagingService {
  static final FirebaseMessagingService _instance =
      FirebaseMessagingService._internal();
  factory FirebaseMessagingService() => _instance;
  FirebaseMessagingService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final NotificationService _notificationService = NotificationService();

  // Stream controllers for different message types
  final _messageStreamController = StreamController<RemoteMessage>.broadcast();
  final _tokenStreamController = StreamController<String>.broadcast();

  Stream<RemoteMessage> get onMessage => _messageStreamController.stream;
  Stream<String> get onTokenRefresh => _tokenStreamController.stream;

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  // Topics list
  final List<String> _subscribedTopics = [];

  /// Initialize Firebase Messaging
  Future<void> initialize() async {
    try {
      debugPrint(
        '\n🔥 ========== FIREBASE MESSAGING INITIALIZATION ==========',
      );

      // Initialize Awesome Notifications first
      await _notificationService.initialize();

      // Request permission for iOS
      NotificationSettings settings = await _firebaseMessaging
          .requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );

      debugPrint('\n📱 ========== FCM PERMISSION STATUS ==========');
      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('✅ User granted permission: AUTHORIZED');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('⚠️  User granted permission: PROVISIONAL');
      } else {
        debugPrint('❌ User declined or has not accepted permission');
      }
      debugPrint('📱 ==========================================\n');

      // Get the FCM token
      _fcmToken = await _firebaseMessaging.getToken();

      debugPrint('\n🔑 ========== FCM TOKEN DEBUG ==========');
      debugPrint('🔑 FCM Token: $_fcmToken');
      debugPrint('🔑 Token Length: ${_fcmToken?.length ?? 0} characters');
      debugPrint(
        '🔑 Token Status: ${_fcmToken != null ? "AVAILABLE" : "NOT AVAILABLE"}',
      );
      debugPrint('🔑 ==========================================\n');

      // Listen to token refresh
      _firebaseMessaging.onTokenRefresh.listen((token) {
        _fcmToken = token;
        _tokenStreamController.add(token);

        debugPrint('\n🔄 ========== FCM TOKEN REFRESHED ==========');
        debugPrint('🔄 New FCM Token: $token');
        debugPrint('🔄 Token Length: ${token.length} characters');
        debugPrint('🔄 ==========================================\n');
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('\n📩 ========== FOREGROUND MESSAGE RECEIVED ==========');
        debugPrint('📩 Message ID: ${message.messageId}');
        debugPrint('📩 Message Data: ${message.data}');
        debugPrint('📩 Sent Time: ${message.sentTime}');

        if (message.notification != null) {
          debugPrint('📩 Notification Title: ${message.notification!.title}');
          debugPrint('📩 Notification Body: ${message.notification!.body}');
          debugPrint(
            '📩 Notification Image: ${message.notification!.android?.imageUrl ?? message.notification!.apple?.imageUrl ?? "None"}',
          );

          // Show notification using Awesome Notifications
          _showAwesomeNotification(message);
        }
        debugPrint('📩 ==========================================\n');

        _messageStreamController.add(message);
      });

      // Handle background messages
      FirebaseMessaging.onBackgroundMessage(
        _firebaseMessagingBackgroundHandler,
      );

      // Handle notification taps when app is in background
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint(
          '\n👆 ========== NOTIFICATION OPENED (BACKGROUND) ==========',
        );
        debugPrint('👆 Message ID: ${message.messageId}');
        debugPrint('👆 Message Data: ${message.data}');
        debugPrint('👆 ==========================================\n');

        _handleNotificationTap(message);
      });

      // Check if app was opened from a terminated state
      RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        debugPrint(
          '\n🚀 ========== APP OPENED FROM NOTIFICATION (TERMINATED) ==========',
        );
        debugPrint('🚀 Message ID: ${initialMessage.messageId}');
        debugPrint('🚀 Message Data: ${initialMessage.data}');
        debugPrint('🚀 ==========================================\n');

        _handleNotificationTap(initialMessage);
      }

      // Subscribe to default topics
      await _subscribeToDefaultTopics();

      debugPrint('🔥 ========== FIREBASE MESSAGING READY ==========\n');
    } catch (e) {
      debugPrint('❌ Error initializing Firebase Messaging: $e');
    }
  }

  /// Show notification using Awesome Notifications
  void _showAwesomeNotification(RemoteMessage message) {
    final notification = message.notification;
    if (notification == null) return;

    // Determine channel based on message data
    String channelKey = NotificationService.generalChannelKey;

    if (message.data.containsKey('channel')) {
      channelKey = message.data['channel'];
    } else if (message.data.containsKey('type')) {
      switch (message.data['type']) {
        case 'alert':
          channelKey = NotificationService.alertChannelKey;
          break;
        case 'message':
          channelKey = NotificationService.messageChannelKey;
          break;
        case 'update':
          channelKey = NotificationService.updateChannelKey;
          break;
        default:
          channelKey = NotificationService.generalChannelKey;
      }
    }

    _notificationService.showNotification(
      id: message.hashCode,
      title: notification.title ?? 'New Notification',
      body: notification.body ?? '',
      channelKey: channelKey,
      payload: message.data.map(
        (key, value) => MapEntry(key, value.toString()),
      ),
      bigPicture:
          notification.android?.imageUrl ?? notification.apple?.imageUrl,
    );
  }

  /// Subscribe to default topics
  Future<void> _subscribeToDefaultTopics() async {
    final defaultTopics = ['all_users', 'general_updates', 'announcements'];

    debugPrint('\n📢 ========== SUBSCRIBING TO TOPICS ==========');
    for (String topic in defaultTopics) {
      await subscribeToTopic(topic);
    }
    debugPrint('📢 ==========================================\n');
  }

  /// Handle notification tap
  void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.data}');
    // Add your custom navigation logic here based on message.data
  }

  /// Subscribe to a topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _firebaseMessaging.subscribeToTopic(topic);
      if (!_subscribedTopics.contains(topic)) {
        _subscribedTopics.add(topic);
      }

      debugPrint('✅ Subscribed to topic: $topic');
      debugPrint('📢 Total subscribed topics: ${_subscribedTopics.length}');
      debugPrint('📢 Topics list: $_subscribedTopics');
    } catch (e) {
      debugPrint('❌ Error subscribing to topic: $e');
    }
  }

  /// Unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _firebaseMessaging.unsubscribeFromTopic(topic);
      _subscribedTopics.remove(topic);

      debugPrint('✅ Unsubscribed from topic: $topic');
      debugPrint('📢 Total subscribed topics: ${_subscribedTopics.length}');
      debugPrint('📢 Topics list: $_subscribedTopics');
    } catch (e) {
      debugPrint('❌ Error unsubscribing from topic: $e');
    }
  }

  /// Get list of subscribed topics
  List<String> get subscribedTopics => List.unmodifiable(_subscribedTopics);

  /// Log current FCM state
  void logFCMState() {
    debugPrint('\n📊 ========== FCM STATE DEBUG ==========');
    debugPrint('📊 FCM Token: $_fcmToken');
    debugPrint('📊 Token Available: ${_fcmToken != null}');
    debugPrint('📊 Subscribed Topics: $_subscribedTopics');
    debugPrint('📊 Topics Count: ${_subscribedTopics.length}');
    debugPrint('📊 ==========================================\n');
  }

  /// Dispose stream controllers
  void dispose() {
    _messageStreamController.close();
    _tokenStreamController.close();
  }
}

/// Background message handler (must be a top-level function)
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('\n🌙 ========== BACKGROUND MESSAGE HANDLER ==========');
  debugPrint('🌙 Handling a background message: ${message.messageId}');
  debugPrint('🌙 Message data: ${message.data}');
  debugPrint('🌙 Sent Time: ${message.sentTime}');

  if (message.notification != null) {
    debugPrint('🌙 Notification Title: ${message.notification!.title}');
    debugPrint('🌙 Notification Body: ${message.notification!.body}');
  }
  debugPrint('🌙 ==========================================\n');
}
