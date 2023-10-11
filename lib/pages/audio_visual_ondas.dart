// Importar las bibliotecas necesarias
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui
    show Gradient; // Importar solo Gradient de la biblioteca 'dart:ui'

// Definición de la clase AudioVisualOndas como un StatefulWidget
class AudioVisualOndas extends StatefulWidget {
  final RecorderController recorderController;

  // Constructor para inicializar las variables
  AudioVisualOndas({required this.recorderController});

  // Crear el estado inicial
  @override
  State<StatefulWidget> createState() {
    return _AudioVisualOndas();
  }
}

// Definición del estado de AudioVisualOndas
class _AudioVisualOndas extends State<AudioVisualOndas> {
  // Construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Usar el widget AudioWaveforms para mostrar las ondas de audio
    return AudioWaveforms(
      enableGesture: false, // Deshabilitar gestos en las ondas de audio
      shouldCalculateScrolledPosition: true, // Calcular la posición desplazada
      size: Size(MediaQuery.of(context).size.width,
          20.0), // Definir el tamaño del widget
      recorderController:
          widget.recorderController, // Controlador para la grabación
      waveStyle: WaveStyle(
        waveColor: Colors.white, // Color de la onda
        spacing: 8.0, // Espaciado entre las ondas
        showBottom: true, // Mostrar la parte inferior de la onda
        extendWaveform: true, // Extender la forma de onda
        showMiddleLine: false, // No mostrar la línea del medio
        gradient: ui.Gradient.linear(
          const Offset(70, 50), // Inicio del gradiente
          Offset(MediaQuery.of(context).size.width / 2, 0), // Fin del gradiente
          [Colors.white54, Colors.purple], // Colores del gradiente
        ),
      ),
    );
  }
}
