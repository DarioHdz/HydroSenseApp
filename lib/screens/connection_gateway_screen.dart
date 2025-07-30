import 'package:flutter/material.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ConnectionGatewayScreen extends StatelessWidget {
  const ConnectionGatewayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.sensors, size: 80, color: Colors.tealAccent),
              const SizedBox(height: 20),
              const Text(
                'Conectar con el sensor',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Selecciona un método de conexión para iniciar la comunicación con el sensor.',
                style: TextStyle(fontSize: 16, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              ElevatedButton.icon(
                icon: const Icon(Icons.bluetooth, size: 24),
                label: const Text('Conectar por Bluetooth', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  // TODO: Lógica de conexión por Bluetooth
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                icon: const Icon(Icons.wifi, size: 24),
                label: const Text('Conectar por WiFi', style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => showWiFiOptionsDialog(context),
              )
            ],
          ),
        ),
      ),
    );
  }


  void showWiFiOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conexión WiFi'),
        content: const Text('¿Cómo deseas conectarte al sensor?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el dialog actual
              connectToKnownSensorWiFi(context);
            },
            child: const Text('Usar conexión guardada'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Cierra primero

              Future.microtask(() {
                showDialogNewConnection(context);
                });
              },

              child: const Text('Nueva conexión'),
          ),
        ],
      ),
    );
  }

  void showDialogNewConnection(BuildContext context) async {
    List<WifiNetwork?> redes = await WiFiForIoTPlugin.loadWifiList();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Selecciona una red WiFi'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: ListView.builder(
              itemCount: redes.length,
              itemBuilder: (context, index) {
                final red = redes[index];
                return ListTile(
                  title: Text(red?.ssid ?? "Desconocida"),
                  onTap: () => _showPasswordFormulary(context, red?.ssid ?? ''),
                );
              },
            ),
          ),
        );
      },
    );
  }

  void _showPasswordFormulary(BuildContext context, String ssid) {
    final TextEditingController passController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Conectarse a $ssid'),
        content: TextField(
          controller: passController,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Contraseña'),
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Conectar'),
            onPressed: () async {
              Navigator.pop(context);
              final exito = await WiFiForIoTPlugin.connect(
                ssid,
                password: passController.text,
                security: NetworkSecurity.WPA,
                joinOnce: true,
                withInternet: false,
              );

              if (exito) {
                await _saveNetwork(ssid, passController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Conectado y guardado: $ssid')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error al conectar a $ssid')),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _saveNetwork(String ssid, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final redes = prefs.getStringList('redes_guardadas') ?? [];

    final nuevaRed = jsonEncode({'ssid': ssid, 'password': password});
    redes.add(nuevaRed);

    await prefs.setStringList('redes_guardadas', redes.toSet().toList()); // evita duplicados
  }

  void connectToKnownSensorWiFi(BuildContext context) async {
    const ssid = 'HydroSense_AP';
    const password = '12345678'; // si aplica

    final result = await WiFiForIoTPlugin.connect(
      ssid,
      password: password,
      security: NetworkSecurity.WPA,
      joinOnce: true,
      withInternet: false,
    );

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Conectado exitosamente')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Fallo al conectar')),
      );
    }
  }

  void scanAndConnectToWiFi(BuildContext context) async {
    final networks = await WiFiForIoTPlugin.loadWifiList();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Redes disponibles'),
        content: SizedBox(
          height: 300,
          width: 300,
          child: ListView.builder(
            itemCount: networks.length,
            itemBuilder: (context, index) {
              final ssid = networks[index].ssid ?? 'Sin nombre';
              return ListTile(
                title: Text(ssid),
                onTap: () {
                  Navigator.pop(context);
                  showWiFiPasswordDialog(context, ssid);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void showWiFiPasswordDialog(BuildContext context, String ssid) {
    final controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Conectar a $ssid'),
        content: TextField(
          controller: controller,
          obscureText: true,
          decoration: const InputDecoration(labelText: 'Contraseña'),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await WiFiForIoTPlugin.connect(
                ssid,
                password: controller.text,
                security: NetworkSecurity.WPA,
                joinOnce: true,
                withInternet: false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      success ? 'Conectado a $ssid' : 'Error al conectar a $ssid'),
                ),
              );
            },
            child: const Text('Conectar'),
          ),
        ],
      ),
    );
  }

}
