import 'package:bd_ejemplo/screen/carga_screen.dart';
import 'package:bd_ejemplo/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const CargaScreen(),
        'dashboard':(context) => const DashboardScreen(),
      },
    );
  }
}
