import 'package:flutter/material.dart';

// -------------------- Juego: Balancea la Ecuación --------------------

class JuegoBalanceo extends StatelessWidget {
  const JuegoBalanceo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego: Balancea la Ecuación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Aquí iría el código para mostrar la ecuación desequilibrada
            //  y permitir al usuario balancearla.
            const Text('El juego se está desarrollando...'),
          ],
        ),
      ),
    );
  }
}
