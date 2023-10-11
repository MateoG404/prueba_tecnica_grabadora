// Importar las bibliotecas necesarias
import 'dart:io';
import 'package:flutter/material.dart';

// Definición de la clase EliminarBoton como un StatelessWidget
class EliminarBoton extends StatelessWidget {
  final String path; // Ruta del archivo de audio a eliminar
  final Function onDelete; // Función a ejecutar después de eliminar el archivo

  // Constructor que inicializa la ruta del archivo y la función onDelete
  EliminarBoton({required this.path, required this.onDelete});

  // Construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    // Función para eliminar el archivo de audio
    Future<void> cancelarAudio() async {
      try {
        final file = File(path); // Crear un objeto de archivo con la ruta dada

        // Comprobar si el archivo existe
        if (await file.exists()) {
          await file.delete(); // Eliminar el archivo
          // Mostrar un mensaje de éxito
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('El audio fue eliminado')),
              duration: Duration(seconds: 3),
            ),
          );
        } else {
          // Mostrar un mensaje si el archivo no existe
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Center(child: Text('El archivo no existe')),
              duration: Duration(seconds: 3),
            ),
          );
        }
      } catch (e) {
        // Mostrar un mensaje de error si algo sale mal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Center(child: Text('Error al eliminar el archivo')),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    // Retornar un botón flotante para eliminar el archivo
    return Container(
      width: 30,
      height: 30,
      child: FloatingActionButton(
        onPressed:
            cancelarAudio, // Llamar a cancelarAudio cuando se presiona el botón
        shape: const CircleBorder(), // Forma del botón
        child: const Icon(Icons.delete), // Icono del botón
      ),
    );
  }
}
