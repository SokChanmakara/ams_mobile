import 'package:ams_mobile/core/service/http_service.dart';
import 'package:ams_mobile/core/service/storage_service.dart';
import 'package:ams_mobile/global.dart';
import 'package:ams_mobile/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() async {
  Global.baseURL = "https//ams-mobile/dev/";
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize storage service
  await StorageService.init();

  // Initialize HTTP service
  HttpService.init(
    baseUrl: dotenv.env['API_BASE_URL'] ?? '',
    timeout: const Duration(seconds: 30),
    interceptors: [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
      ),
    ],
  );

  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true, // Set to true to enable DevicePreview
        builder: (context) => const MyApp(),
      ),
    ),
  );
}
