import 'package:dev_nc/features/tiktik_ui.dart';
import 'package:dev_nc/overlay_screen.dart';
import 'package:dev_nc/pagination_repository.dart';
import 'package:dev_nc/pagination_view_model.dart';
import 'package:dev_nc/spotify_ui.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'api_service.dart';

void main() {
  // Create Dio instance for HTTP requests
  final Dio dio = Dio();

  // Create ApiService instance with the Dio instance
  final ApiService apiService = ApiService(dio: dio);

  // Create PaginationRepository instance with the ApiService instance
  final paginationRepository = PaginationRepository(apiService: apiService);

  // Provider
  runApp(
    MultiProvider(
      providers: [
        // Provide the LoginViewModel with LoginViewModel dependency to manage user data and API calls
        ChangeNotifierProvider<PhotoProvider>(
          create: (context) =>
              PhotoProvider(userRepository: paginationRepository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pagination',
      // Meta Title for the App
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const OverlayScreen(),
        'spotify': (context) => const SpotifyUI(),
        'tiktok': (context) => const TikTokHome(),
      },
    );
  }
}
