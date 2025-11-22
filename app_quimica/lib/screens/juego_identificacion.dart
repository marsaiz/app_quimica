// lib/juego_identificacion.dart

import 'package:flutter/material.dart';

// La respuesta correcta, para este ejemplo. Podrías mover esto a un archivo de datos.
const String _respuestaCorrecta = 'Sodio';

// 1. La clase principal que extiende StatefulWidget
class JuegoIdentificacion extends StatefulWidget {
  const JuegoIdentificacion({super.key});

  @override
  State<JuegoIdentificacion> createState() => _JuegoIdentificacionState();
}

// 2. La clase de Estado donde se define el estado y se usa setState
class _JuegoIdentificacionState extends State<JuegoIdentificacion> {
  // Variables de estado
  String _respuestaSeleccionada = '';
  bool _esCorrecto = false;

  // Función para manejar la selección de una respuesta
  void _verificarRespuesta(String seleccion) {
    setState(() {
      _respuestaSeleccionada = seleccion;
      // La lógica para determinar si ganó
      _esCorrecto = (seleccion == _respuestaCorrecta); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego: Identifica el Elemento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Regresa a la ruta anterior (Menú Principal)
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '¿Qué elemento se muestra?',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Imagen del elemento
          const Image(
            image: AssetImage('assets/imagenes/sodio.jpeg'), 
            width: 150,
            height: 150,
          ),

          const SizedBox(height: 30),

          // Lista de opciones
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 15.0,
              runSpacing: 10.0,
              children: [
                // Botón Sodio
                ElevatedButton(
                  onPressed: () => _verificarRespuesta('Sodio'),
                  child: const Text('Sodio'),
                ),
                // Botón Hierro
                ElevatedButton(
                  onPressed: () => _verificarRespuesta('Hierro'),
                  child: const Text('Hierro'),
                ),
                // Botón Oxígeno
                ElevatedButton(
                  onPressed: () => _verificarRespuesta('Oxígeno'),
                  child: const Text('Oxígeno'),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // Mostrar el resultado
          Visibility(
            visible: _respuestaSeleccionada.isNotEmpty,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _esCorrecto
                    ? '🎉 ¡Correcto! El elemento es: $_respuestaCorrecta'
                    : '❌ ¡Incorrecto! Seleccionaste: $_respuestaSeleccionada',
                style: TextStyle(
                  fontSize: 24, 
                  fontWeight: FontWeight.bold,
                  color: _esCorrecto ? Colors.green.shade800 : Colors.red.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          const SizedBox(height: 20),

          // Botón para volver al menú
          Visibility(
            visible: _respuestaSeleccionada.isNotEmpty,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Volver al Menú Principal'),
            ),
          ),
        ],
      ),
    );
  }
}