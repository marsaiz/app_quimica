import 'package:flutter/material.dart';

// -------------------- Juego: Combina Elementos --------------------

class JuegoCombinacion extends StatelessWidget {
  const JuegoCombinacion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego: Combina Elementos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  Aquí iría el código para mostrar la imagen de dos elementos
            //  y permitir al usuario elegir si reaccionan o no.
            const Text('El juego se está desarrollando...'),
          ],
        ),
      ),
    );
  }
}