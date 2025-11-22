# app_quimica

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


¡Claro que sí! Aquí tienes una documentación técnica detallada y estructurada en formato **Markdown**, lista para copiar y pegar en tu archivo `README.md` (o para adjuntar a la documentación del proyecto).

Explica paso a paso cómo funciona el "motor" del juego para que cualquiera que vea el código entienda la lógica rápidamente.

***

# 🧪 Juego 1: Identificación de Elementos

Este módulo (`juego_identificacion.dart`) implementa un juego de preguntas y respuestas tipo *quiz* diseñado para ayudar a los estudiantes a memorizar la simbología y apariencia de los elementos de la tabla periódica.

## ⚙️ Lógica del Juego

El juego funciona bajo un ciclo de **Generación -> Interacción -> Retroalimentación**. A continuación se detalla el flujo técnico:

### 1. Estructura de Datos
Se utiliza una clase modelo simple `ElementoQuimico` para encapsular la información:
- **`nombre`**: String (ej. "Oro", "Sodio").
- **`imagenPath`**: String con la ruta del asset local.

Existe una lista constante `_listaElementos` que actúa como la "base de datos" local. El juego escala automáticamente: para agregar más preguntas, solo es necesario añadir un nuevo objeto a esta lista.

### 2. Algoritmo de Generación de Pregunta
Cada vez que inicia el juego o se pulsa "Siguiente", se ejecuta la función `_generarNuevaPregunta()`, que realiza los siguientes pasos:

1.  **Selección del Objetivo:** Se elige aleatoriamente un elemento de la lista total usando `Random()`. Este será la **Respuesta Correcta**.
2.  **Filtrado de Distractores:**
    - Se crea una copia temporal de la lista completa.
    - Se elimina el elemento objetivo de esta copia (para evitar duplicados).
    - Se mezcla la lista (`shuffle`) y se toman los primeros 2 elementos. Estos serán las **Respuestas Incorrectas**.
3.  **Mezcla Final:** Se combinan el objetivo + los 2 distractores en una lista de `_opciones`. Esta lista se vuelve a mezclar para que la respuesta correcta no aparezca siempre en la misma posición del botón.
4.  **Reinicio de Estado:** Se limpian las variables de selección y se habilita nuevamente la interfaz para responder.

### 3. Validación y Estado (Bloqueo)
Cuando el usuario selecciona una opción (`_verificarRespuesta`):
1.  **Bloqueo de Interacción:** Se consulta la bandera `_yaRespondio`. Si es `true`, se ignora el clic para evitar cambios de respuesta o trampas.
2.  **Comparación:** Se compara el `nombre` del botón presionado con el `nombre` del elemento objetivo actual.
3.  **Actualización de UI:** Se llama a `setState`, lo que dispara la reconstrucción de la pantalla para mostrar los colores y el mensaje de resultado.

### 4. Retroalimentación Visual (Feedback)
El sistema de colores en los botones es dinámico y se evalúa en tiempo de ejecución (`build`):
- **Gris (Default):** El usuario aún no ha respondido.
- **Verde:** Indica el botón que contiene la respuesta correcta (se muestra siempre al finalizar, haya acertado el usuario o no, para refuerzo positivo).
- **Rojo:** Indica el botón seleccionado por el usuario **si** este fue incorrecto.

### 5. Manejo de Errores (Assets)
El widget de imagen incluye un `errorBuilder`. Si por error se define un elemento en la lista pero falta su archivo `.jpeg` en la carpeta de assets, la app no se cierra, sino que muestra un icono de "imagen rota" para alertar al desarrollador sin detener la experiencia de usuario.

---

## 📋 Requisitos para escalar
Para agregar más elementos al juego, editar la lista `_listaElementos` en `lib/juego_identificacion.dart` y asegurarse de colocar la imagen correspondiente en:

```
assets/imagenes/nombre_archivo.jpeg
```

***

### ¿Cómo ponerlo en tu proyecto?

Simplemente crea un archivo llamado `README.md` en la raíz de tu proyecto (o edita el que ya tengas) y pega el contenido de arriba. Esto le dará un toque muy profesional a tu entrega para la profesora.