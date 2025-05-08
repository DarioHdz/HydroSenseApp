import 'package:flutter/material.dart';

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
            // Título principal
            const Text(
              'HiTemp',
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
              'Sensor Hidrológico',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 60),

            // Botón para conectar Bluetooth
            ElevatedButton.icon(
              icon: const Icon(Icons.bluetooth, size: 28),
              label: const Text(
                'Conectar por Bluetooth',
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyan,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Aquí se implementará la lógica para mostrar dispositivos emparejados
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Dispositivos emparejados'),
                    content: const Text('Aquí se listarán los dispositivos Bluetooth vinculados.'),
                    actions: [
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () => Navigator.of(context).pop(),
                      )
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
