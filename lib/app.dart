import 'package:flutter/material.dart';

import 'screens/auth/engineer_login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Civil Work Monitor',

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1769AA),
        ),
      ),

      initialRoute: '/login',

      routes: {
        '/login': (context) => const EngineerLoginPage(),
      },
    );
  }
}