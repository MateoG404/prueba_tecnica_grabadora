import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:grabadora_app/pages/reproduccir_grabacion.dart';

// Definición de la clase ListaGrabaciones como un StatefulWidget
class ListaGrabaciones extends StatefulWidget {
  @override
  _ListaGrabacionesState createState() => _ListaGrabacionesState();
}

// Definición del estado de ListaGrabaciones
class _ListaGrabacionesState extends State<ListaGrabaciones> {
  // Declaración de una variable para almacenar los archivos de audio futuros
  late Future<List<FileSystemEntity>> futureFiles;
  AudioPlayer audioPlayer = AudioPlayer();
  void refreshList() {
    setState(() {
      futureFiles = _getAudioFiles();
    });
  }

  @override
  void initState() {
    super.initState();
    // Inicializar futureFiles con la función _getAudioFiles
    futureFiles = _getAudioFiles();
  }

  // Función para obtener la lista de archivos de audio
  Future<List<FileSystemEntity>> _getAudioFiles() async {
    // Obtener el directorio de documentos de la aplicación
    final directory = await getApplicationDocumentsDirectory();

    // Definir la ruta de la carpeta "grabaciones"
    final folderPath = '${directory.path}/grabaciones';
    final folder = Directory(folderPath);
    // Comprobar si la carpeta "grabaciones" existe
    if (await folder.exists()) {
      // Devolver la lista de archivos en la carpeta
      return folder.listSync();
    } else {
      // Devolver una lista vacía si la carpeta no existe
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: FutureBuilder<List<FileSystemEntity>>(
        // Usar futureFiles como el Future para FutureBuilder
        future: futureFiles,
        builder: (context, snapshot) {
          // Mostrar un indicador de carga si los datos aún no están disponibles
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          // Mostrar un mensaje de error si algo sale mal
          else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          // Construir la lista de widgets ReproducirGrabacion si los datos están disponibles
          else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map((file) => ReproduccirGrabacion(
                          pathGrabacion: file.path,
                          titulo_grabacion: file.uri.pathSegments.last,
                          onDelete: refreshList,
                        ))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
