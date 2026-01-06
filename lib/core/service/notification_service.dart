import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  // Notification channel keys
  static const String generalChannelKey = 'general_channel';
  static const String alertChannelKey = 'alert_channel';
  static const String messageChannelKey = 'message_channel';
  static const String updateChannelKey = 'update_channel';

  // Notification channel groups
  static const String generalChannelGroup = 'general_group';
  static const String communicationChannelGroup = 'communication_group';

  /// Initialize Awesome Notifications
  Future<void> initialize() async {
    try {
      await AwesomeNotifications().initialize(
        null, // Default app icon
        [
          // General notification channel
          NotificationChannel(
            channelKey: generalChannelKey,
            channelName: 'General Notifications',
            channelDescription:
                'General notifications for app updates and info',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white,
            importance: NotificationImportance.Default,
            channelGroupKey: generalChannelGroup,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            criticalAlerts: false,
          ),
          // Alert channel (high priority)
          NotificationChannel(
            channelKey: alertChannelKey,
            channelName: 'Alert Notifications',
            channelDescription:
                'High priority alerts and important notifications',
            defaultColor: const Color(0xFFFF0000),
            ledColor: Colors.red,
            importance: NotificationImportance.Max,
            channelGroupKey: generalChannelGroup,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            criticalAlerts: true,
            defaultRingtoneType: DefaultRingtoneType.Alarm,
          ),
          // Message channel
          NotificationChannel(
            channelKey: messageChannelKey,
            channelName: 'Messages',
            channelDescription: 'Chat and messaging notifications',
            defaultColor: const Color(0xFF0088CC),
            ledColor: Colors.blue,
            importance: NotificationImportance.High,
            channelGroupKey: communicationChannelGroup,
            enableVibration: true,
            enableLights: true,
            playSound: true,
            criticalAlerts: false,
          ),
          // Update channel
          NotificationChannel(
            channelKey: updateChannelKey,
            channelName: 'Updates',
            channelDescription: 'App updates and new content notifications',
            defaultColor: const Color(0xFF4CAF50),
            ledColor: Colors.green,
            importance: NotificationImportance.Low,
            channelGroupKey: generalChannelGroup,
            enableVibration: false,
            enableLights: true,
            playSound: false,
            criticalAlerts: false,
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: generalChannelGroup,
            channelGroupName: 'General',
          ),
          NotificationChannelGroup(
            channelGroupKey: communicationChannelGroup,
            channelGroupName: 'Communication',
          ),
        ],
        debug: true,
      );

      debugPrint('✅ Awesome Notifications initialized successfully');

      // Request permission
      await requestPermission();

      // Setup notification listeners
      _setupListeners();

      // Log all channels
      await _debugLogChannels();
    } catch (e) {
      debugPrint('❌ Error initializing Awesome Notifications: $e');
    }
  }

  /// Request notification permissions
  Future<bool> requestPermission() async {
    try {
      bool isAllowed = await AwesomeNotifications().isNotificationAllowed();

      debugPrint('📱 Notification Permission Status: $isAllowed');

      if (!isAllowed) {
        debugPrint('🔔 Requesting notification permission...');
        isAllowed = await AwesomeNotifications()
            .requestPermissionToSendNotifications();
        debugPrint('📱 Permission ${isAllowed ? "GRANTED" : "DENIED"}');
      }

      return isAllowed;
    } catch (e) {
      debugPrint('❌ Error requesting notification permission: $e');
      return false;
    }
  }

  /// Setup notification listeners
  void _setupListeners() {
    // Listen when a notification is created
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );

    debugPrint('👂 Notification listeners set up');
  }

  /// Called when a notification is created
  @pragma('vm:entry-point')
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    debugPrint('🔔 Notification Created:');
    debugPrint('   ID: ${receivedNotification.id}');
    debugPrint('   Title: ${receivedNotification.title}');
    debugPrint('   Body: ${receivedNotification.body}');
    debugPrint('   Channel: ${receivedNotification.channelKey}');
    debugPrint('   Payload: ${receivedNotification.payload}');
  }

  /// Called when a notification is displayed
  @pragma('vm:entry-point')
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    debugPrint('📱 Notification Displayed:');
    debugPrint('   ID: ${receivedNotification.id}');
    debugPrint('   Title: ${receivedNotification.title}');
  }

  /// Called when a notification is dismissed
  @pragma('vm:entry-point')
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    debugPrint('🗑️ Notification Dismissed:');
    debugPrint('   ID: ${receivedAction.id}');
    debugPrint('   Action: ${receivedAction.actionType}');
  }

  /// Called when user taps on notification
  @pragma('vm:entry-point')
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    debugPrint('👆 Notification Action Received:');
    debugPrint('   ID: ${receivedAction.id}');
    // debugPrint('   Action Key: ${receivedAction.actionKey}');
    debugPrint('   Button Key: ${receivedAction.buttonKeyPressed}');
    debugPrint('   Payload: ${receivedAction.payload}');

    // Handle navigation based on payload
    // You can add your custom navigation logic here
  }

  /// Show a notification
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? channelKey,
    Map<String, String>? payload,
    String? largeIcon,
    String? bigPicture,
    NotificationLayout? notificationLayout,
    List<NotificationActionButton>? actionButtons,
  }) async {
    try {
      await AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: id,
          channelKey: channelKey ?? generalChannelKey,
          title: title,
          body: body,
          payload: payload,
          largeIcon: largeIcon,
          bigPicture: bigPicture,
          notificationLayout: notificationLayout ?? NotificationLayout.Default,
          wakeUpScreen: true,
          category: NotificationCategory.Message,
        ),
        actionButtons: actionButtons,
      );

      debugPrint('✅ Notification created: $title');
    } catch (e) {
      debugPrint('❌ Error creating notification: $e');
    }
  }

  /// Cancel a specific notification
  Future<void> cancelNotification(int id) async {
    await AwesomeNotifications().cancel(id);
    debugPrint('🗑️ Notification $id cancelled');
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await AwesomeNotifications().cancelAll();
    debugPrint('🗑️ All notifications cancelled');
  }

  /// Get all active notification channels
  Future<void> _debugLogChannels() async {
    List<NotificationChannel> channels = await AwesomeNotifications()
        .listScheduledNotifications()
        .then((_) => []);

    debugPrint('\n📋 ========== NOTIFICATION CHANNELS ==========');
    debugPrint('📋 Available Channels:');
    debugPrint('   1. $generalChannelKey - General Notifications');
    debugPrint('   2. $alertChannelKey - Alert Notifications (High Priority)');
    debugPrint('   3. $messageChannelKey - Message Notifications');
    debugPrint('   4. $updateChannelKey - Update Notifications (Low Priority)');
    debugPrint('📋 ==========================================\n');
  }
}
