import 'package:ams_mobile/core/interceptors/auth_token_interceptor.dart';
import 'package:ams_mobile/core/service/firebase_messaging_service.dart';
import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/firebase_options_dev.dart';
import 'package:ams_mobile/global.dart';
import 'package:ams_mobile/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() async {
  Global.baseURL = "https//ams-mobile/dev/";
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');
  // Initialize Firebase with dev options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Firebase Messaging (includes Awesome Notifications)
  await FirebaseMessagingService().initialize();

  // Initialize storage service
  await StorageService.init();

  // Initialize HTTP service
  HttpService.init(
    baseUrl: dotenv.env['API_BASE_URL'] ?? '',
    timeout: const Duration(seconds: 30),
  );

  // Add interceptors after initialization
  HttpService.instance.addInterceptor(
    AuthTokenInterceptor(HttpService.instance.dio),
  );
  HttpService.instance.addInterceptor(
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ),
  );

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: false, // Set to true to enable DevicePreview
        builder: (context) => const MyApp(),
      ),
    ),
  );
}
