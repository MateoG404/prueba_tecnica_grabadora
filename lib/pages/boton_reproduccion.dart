// Importar las bibliotecas necesarias
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';

// Definición de la clase BotonReproduccion como un StatefulWidget
class BotonReproduccion extends StatefulWidget {
  final String pathGrabacion; // Ruta del archivo de audio a reproducir

  // Constructor que inicializa la ruta del archivo de audio
  BotonReproduccion({required this.pathGrabacion, Key? key}) : super(key: key);

  // Crear el estado inicial del widget
  @override
  State<StatefulWidget> createState() {
    return _BotonReproduccion();
  }
}

// Definición del estado de BotonReproduccion
class _BotonReproduccion extends State<BotonReproduccion> {
  late final PlayerController
      playerController; // Controlador del reproductor de audio
  bool isPlay =
      false; // Variable para rastrear si el audio se está reproduciendo o no

  // Inicializar el estado
  @override
  void initState() {
    super.initState();
    playerController =
        PlayerController(); // Inicializar el controlador del reproductor
  }

  // Función para reproducir el audio
  Future<void> reproducirAudio() async {
    try {
      await playerController.preparePlayer(
          path: widget.pathGrabacion); // Preparar el reproductor
      await playerController.startPlayer(); // Iniciar la reproducción
    } catch (e) {
      print("error para reproducir"); // Imprimir error si algo sale mal
    }
  }

  // Función para detener el audio
  Future<void> stopAudio() async {
    try {
      await playerController.stopPlayer(); // Detener el reproductor
    } catch (e) {
      print("error para pausar"); // Imprimir error si algo sale mal
    }
  }

  // Construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    double buttonSize = 56.0; // Tamaño del botón
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          isPlay = !isPlay; // Cambiar el estado de reproducción
        });
        if (isPlay) {
          reproducirAudio(); // Reproducir audio si isPlay es verdadero
        } else {
          stopAudio(); // Detener audio si isPlay es falso
        }
      },
      backgroundColor: Colors.white, // Color de fondo del botón
      tooltip: "Reproducir", // Texto de ayuda
      child: Icon(
        isPlay == false
            ? Icons.play_circle_outlined
            : Icons.pause_circle_outline_outlined, // Icono del botón
        color: Colors.black,
        size: buttonSize - 16,
      ),
    );
  }
}
