import 'package:flutter/material.dart';
// ¡IMPORTANTE! Importar la clase del juego desde su nuevo archivo
import 'screens/juego_identificacion.dart';
void main() {
  /// Punto de entrada de la aplicación - inicia la app
  runApp(const MiJuegoTablaPeriodica());
}

/// Clase principal de la aplicación
class MiJuegoTablaPeriodica extends StatelessWidget {
  const MiJuegoTablaPeriodica({super.key});

  @override
  Widget build(BuildContext context) {
    /// Configuración básica de la aplicación
    return MaterialApp(
      title: 'Juego Tabla Periodica',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // Definición de las rutas
      routes: {
        '/': (context) => const MenuPrincipal(),
        // Usamos la clase importada JuegoIdentificacion
        'juego_identificacion': (context) => const JuegoIdentificacion(), 
        'juego_combinacion': (context) => const Placeholder(), // Mantener placeholders
        'juego_balanceo': (context) => const Placeholder(), // Mantener placeholders
      },
      initialRoute: '/',
    );
  }
}

// -------------------- Menu Principal --------------------

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    /// Pantalla del menú principal con opciones de juegos
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Navega usando el nombre de la ruta
                Navigator.pushNamed(
                  context,
                  'juego_identificacion',
                );
              },
              child: const Text('Juego: Identifica el Elemento'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'juego_combinacion',
                );
              },
              child: const Text('Juego: Combina Elementos'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  'juego_balanceo',
                );
              },
              child: const Text('Juego: Balancea la Ecuación'),
            ),
          ],
        ),
      ),
    );
  }
}