import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:wifi_iot/wifi_iot.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HydroSense',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.cyanAccent,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            // Subtítulo
            const Text(
              'Sistema de sensores para monitoreo ambiental',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 60),

            // Botones de conexion
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                ElevatedButton.icon(
                  icon: const Icon(Icons.wifi),
                  label: const Text('Conectar por WiFi'),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  icon: const Icon(Icons.bluetooth),
                  label: const Text('Conectar por Bluetooth'),
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyan,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }

}
