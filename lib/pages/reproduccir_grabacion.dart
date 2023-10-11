// Importar las bibliotecas necesarias
import 'dart:async';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:grabadora_app/pages/boton_reproduccion.dart';
import 'package:grabadora_app/pages/eliminar_boton.dart';

// Definición de la clase ReproduccirGrabacion como un StatefulWidget
class ReproduccirGrabacion extends StatefulWidget {
  final String titulo_grabacion;
  final String pathGrabacion;
  final void Function() onDelete;

  // Constructor para inicializar las variables
  ReproduccirGrabacion({
    Key? key,
    required this.titulo_grabacion,
    required this.pathGrabacion,
    required this.onDelete,
  }) : super(key: key);

  // Crear el estado inicial
  @override
  _ReproducirGrabacionState createState() => _ReproducirGrabacionState();
}

// Definición del estado de ReproduccirGrabacion
class _ReproducirGrabacionState extends State<ReproduccirGrabacion> {
  late final PlayerController playerController;
  String audioDuration = "Calculando el tiempo ";

  // Inicializar el estado
  @override
  void initState() {
    super.initState();
    playerController = PlayerController();
    // TODO: Agregar lógica para obtener la duración del audio y actualizar `audioDuration`
  }

  // Construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Contenedor para el nombre de la grabación
    final nombreGrabacion = Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        widget.titulo_grabacion,
        style: const TextStyle(
            fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        overflow: TextOverflow.ellipsis,
      ),
    );

    // Contenedor para la descripción (duración del audio)
    final descripcion = Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        audioDuration,
        style: const TextStyle(
            fontSize: 16, color: Colors.white38, fontWeight: FontWeight.normal),
        overflow: TextOverflow.ellipsis,
      ),
    );

    // Contenedor para el nombre y la descripción
    final nombreDescirpionGrabacion = Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [nombreGrabacion, descripcion],
      ),
    );

    // Divisor para separar elementos en la lista
    const divider = Divider(
      color: Colors.white30,
      height: 8,
    );

    // Contenedor principal
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // Fila que contiene el botón de reproducción, nombre y descripción, y botón de eliminación
          Container(
            margin: const EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BotonReproduccion(pathGrabacion: widget.pathGrabacion),
                Expanded(child: nombreDescirpionGrabacion),
                EliminarBoton(
                  path: widget.pathGrabacion,
                  onDelete: widget.onDelete,
                )
              ],
            ),
          ),
          // Divisor
          Container(
            margin: const EdgeInsets.only(top: 10, left: 4, right: 4),
            child: divider,
          )
        ],
      ),
    );
  }
}
