import 'package:flutter/material.dart';
import 'dart:math'; // Importar librería matemática para usar Random

// 1. Modelo de datos simple para un elemento
class ElementoQuimico {
  final String nombre;
  final String imagenPath;

  ElementoQuimico({required this.nombre, required this.imagenPath});
}

// 2. Base de datos de los elementos más importantes
// IMPORTANTE: Debes asegurarte de tener estas imágenes en tu carpeta assets/imagenes/
final List<ElementoQuimico> _listaElementos = [
  ElementoQuimico(nombre: 'Sodio', imagenPath: 'assets/imagenes/sodio.jpeg'),
  ElementoQuimico(nombre: 'Hidrógeno', imagenPath: 'assets/imagenes/hidrogeno.jpeg'),
  ElementoQuimico(nombre: 'Helio', imagenPath: 'assets/imagenes/helio.jpeg'),
  ElementoQuimico(nombre: 'Carbono', imagenPath: 'assets/imagenes/carbono.jpeg'),
  ElementoQuimico(nombre: 'Nitrógeno', imagenPath: 'assets/imagenes/nitrogeno.jpeg'),
  ElementoQuimico(nombre: 'Oxígeno', imagenPath: 'assets/imagenes/oxigeno.jpeg'),
  ElementoQuimico(nombre: 'Hierro', imagenPath: 'assets/imagenes/hierro.jpeg'),
  ElementoQuimico(nombre: 'Oro', imagenPath: 'assets/imagenes/oro.jpeg'),
  ElementoQuimico(nombre: 'Plata', imagenPath: 'assets/imagenes/plata.jpeg'),
  ElementoQuimico(nombre: 'Cobre', imagenPath: 'assets/imagenes/cobre.jpeg'),
  ElementoQuimico(nombre: 'Cloro', imagenPath: 'assets/imagenes/cloro.jpeg'),
  ElementoQuimico(nombre: 'Calcio', imagenPath: 'assets/imagenes/calcio.jpeg'),
];

class JuegoIdentificacion extends StatefulWidget {
  const JuegoIdentificacion({super.key});

  @override
  State<JuegoIdentificacion> createState() => _JuegoIdentificacionState(); // Crear estado mutable
}

class _JuegoIdentificacionState extends State<JuegoIdentificacion> {
  // Variables de estado
  late ElementoQuimico _elementoActual; //Late indica que se inicializará más tarde
  List<String> _opciones = [];
  String _respuestaSeleccionada = '';
  bool _esCorrecto = false;
  bool _yaRespondio = false;

  @override
  void initState() { // Inicialización del estado, construcción de la primera pregunta
    super.initState();
    _generarNuevaPregunta();
  }

  // Función para preparar una nueva ronda
  void _generarNuevaPregunta() {
    setState(() {
      // 1. Elegir un elemento al azar como la respuesta correcta
      _elementoActual = _listaElementos[Random().nextInt(_listaElementos.length)];
      
      // 2. Generar distractores (respuestas incorrectas)
      // Creamos una copia de la lista y removemos el correcto para no duplicarlo
      var listaTemporal = List<ElementoQuimico>.from(_listaElementos);
      listaTemporal.removeWhere((element) => element.nombre == _elementoActual.nombre);
      
      // Mezclamos la lista temporal y tomamos 2 distractores
      listaTemporal.shuffle();
      var distractores = listaTemporal.take(2).map((e) => e.nombre).toList();

      // 3. Crear lista final de opciones (Correcta + Distractores) y mezclarla
      _opciones = [...distractores, _elementoActual.nombre];
      _opciones.shuffle(); // Mezclar para que la correcta no esté siempre en el mismo lugar

      // 4. Resetear estado de respuesta
      _respuestaSeleccionada = '';
      _yaRespondio = false;
    });
  }

  void _verificarRespuesta(String seleccion) {
    if (_yaRespondio) return; // Evitar que cambie la respuesta una vez seleccionada
    /// Actualizar estado con la respuesta seleccionada
    setState(() {
      _respuestaSeleccionada = seleccion;
      _esCorrecto = (seleccion == _elementoActual.nombre);
      _yaRespondio = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Juego: Identifica el Elemento'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView( // Agregado Scroll para pantallas pequeñas
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Text(
              '¿Qué elemento se muestra?',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
        
            // Imagen dinámica
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Image(
                // Usamos la ruta dinámica del objeto actual
                image: AssetImage(_elementoActual.imagenPath), 
                width: 180,
                height: 180,
                fit: BoxFit.contain,
                // Muestra un icono de error si no encuentra la imagen en assets
                errorBuilder: (context, error, stackTrace) {
                  return const Column(
                    children: [
                      Icon(Icons.broken_image, size: 50, color: Colors.grey),
                      Text('Imagen no encontrada'),
                    ],
                  );
                },
              ),
            ),
        
            const SizedBox(height: 30),
        
            // Lista de opciones dinámica
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Wrap(
                alignment: WrapAlignment.center,
                spacing: 15.0,
                runSpacing: 10.0,
                children: _opciones.map((opcion) {
                  // Lógica para cambiar color del botón al responder
                  Color? botonColor;
                  if (_yaRespondio) {
                    if (opcion == _elementoActual.nombre) {
                      botonColor = Colors.green; // Mostrar siempre cuál era la correcta
                    } else if (opcion == _respuestaSeleccionada && !_esCorrecto) {
                      botonColor = Colors.red; // Marcar la incorrecta seleccionada
                    }
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: botonColor, 
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    ),
                    onPressed: () => _verificarRespuesta(opcion),
                    child: Text(
                      opcion,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }).toList(),
              ),
            ),
        
            const SizedBox(height: 20),
        
            // Mostrar resultado
            Visibility(
              visible: _yaRespondio,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _esCorrecto
                          ? '🎉 ¡Correcto! Es ${_elementoActual.nombre}'
                          : '❌ ¡Incorrecto! Era ${_elementoActual.nombre}',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: _esCorrecto ? Colors.green.shade800 : Colors.red.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  const SizedBox(height: 10),
                  
                  // Fila de botones: Siguiente o Salir
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Salir'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton.icon(
                        onPressed: _generarNuevaPregunta,
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Siguiente Pregunta'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}