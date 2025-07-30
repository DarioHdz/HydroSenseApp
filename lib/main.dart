import 'package:flutter/material.dart';
import 'screens/connection_gateway_screen.dart'; // Asegúrate que la ruta sea correcta

void main() {
  runApp(const HiTempApp());
}

class HiTempApp extends StatelessWidget {
  const HiTempApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HiTemp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF001C34),
        primaryColor: Colors.cyan,
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const ConnectionGatewayScreen(), // 👈 Aquí se carga la pantalla de conexión
    );
  }
}
