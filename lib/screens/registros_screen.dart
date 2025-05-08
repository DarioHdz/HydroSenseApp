import 'package:flutter/material.dart';

class RegistrosScreen extends StatelessWidget {
  const RegistrosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          children: [
            // Fila superior: Botón de documentos, título y botón de guardar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Botón de documentos (abrir archivos desde el ESP)
                IconButton(
                  icon: const Icon(Icons.folder_open, size: 30, color: Colors.cyanAccent),
                  onPressed: () {
                    // Aquí se conectará con el ESP32 para abrir archivos
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Abrir archivos desde el ESP')),
                    );
                  },
                ),

                // Título del documento actual
                const Text(
                  'Doc_01.txt', // Temporal, luego será dinámico
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),

                // Botón de guardar archivo
                IconButton(
                  icon: const Icon(Icons.save_alt, size: 30, color: Colors.cyanAccent),
                  onPressed: () {
                    // Lógica para guardar archivo en el teléfono
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Guardar en el dispositivo')),
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Contenedor para el contenido del archivo
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const SingleChildScrollView(
                  child: Text(
                    'Contenido del archivo aquí...', // Temporal
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Fila inferior con botones de navegación entre documentos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Mostrar documento anterior
                  },
                  child: const Text('Anterior'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Mostrar siguiente documento
                  },
                  child: const Text('Siguiente'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
