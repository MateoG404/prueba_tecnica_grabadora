import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:grabadora_app/pages/audio_visual_ondas.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:async';

class RecordClass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RecordClass();
  }
}

class _RecordClass extends State<RecordClass> {
  late final RecorderController recorderController;
  bool isRecording = false;
  late Record audioRecord;
  late PlayerController playerController;
  late AudioPlayer audioPlayer;
  String audioPath = '';
  late Timer _timer;
  Duration _duracion = Duration();

  @override
  void initState() {
    // Inicializar audioplayer
    audioPlayer = AudioPlayer();

    // Inicializar grabacion
    audioRecord = Record();

    // Iniciar recorder

    playerController = PlayerController();
    recorderController = RecorderController();

    super.initState();
  }

  @override
  void dispose() {
    //audioRecord.dispose();
    //audioPlayer.dispose();
    recorderController.dispose();
    super.dispose();
  }

  // Comenzar grabacion
  Future<void> record() async {
    try {
      // Check si hay permisos de grabacion
      if (await audioRecord.hasPermission()) {
        //await audioRecord.start();
        await recorderController.record();
        setState(() {
          isRecording = true;
        });
      }
      _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
        setState(() {
          _duracion += Duration(seconds: 1);
        });
      });
    } catch (e) {
      print("No se pudo iniciar la grabacion");
    }
  }

  Future<void> cancelarAudio() async {
    _duracion = Duration.zero;
    await recorderController.stop();
    setState(() {
      isRecording = false;
    });
    _timer.cancel();

    // Mostrar un Snackbar para notificar al usuario
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
            child: Text('El audio fue eliminado. Puede grabar de nuevo.')),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> guardarAudio() async {
    final path = await recorderController.stop();

    // Mostrar un cuadro de diálogo para capturar el nombre del archivo
    String? fileName;
    // ignore: use_build_context_synchronously
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Ingrese el nombre del archivo'),
          content: TextField(
            onChanged: (value) {
              fileName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    // Obtener el directorio de documentos
    final directory = await getApplicationDocumentsDirectory();

    // Crear una carpeta llamada "grabaciones" si no existe
    final folderPath = '${directory.path}/grabaciones';
    final folder = Directory(folderPath);
    if (!await folder.exists()) {
      await folder.create();
    }

    // Mover el archivo de audio a la carpeta "grabaciones"
    final newPath = '$folderPath/$fileName.aac';
    await File(path!).rename(newPath);

    // Reiniciar la duración a cero
    _duracion = Duration.zero;

    setState(() {
      isRecording = false;
      audioPath = newPath;
    });
    _timer.cancel();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text('El audio fue guardado con exito')),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> stop() async {
    try {
      await recorderController.pause();
      _timer.cancel();
      setState(() {
        isRecording = false;
      });
    } catch (e) {
      print("NO se pudo parar la grabacion");
    }
  }

  Future<void> playRecording() async {
    try {
      // Detener y guardar la grabación actual, si es necesario
      final path = await recorderController.stop();
      setState(() {
        audioPath = path!;
      });

      // Preparar el reproductor con el path del archivo de audio
      await playerController.preparePlayer(path: audioPath);

      // Iniciar la reproducción
      await playerController.startPlayer();
    } catch (e) {
      print("error para reproducir");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Boton para grabar o pausar grabacion

        Positioned(
          top: 150,
          child: SizedBox(
            width: 120,
            height: 120,
            child: FloatingActionButton(
              onPressed: () {
                isRecording ? stop() : record();
              },
              shape: const CircleBorder(),
              elevation: 10,
              child: Icon(
                isRecording == false ? Icons.mic : Icons.stop,
                size: 40,
              ),
            ),
          ),
        ),

        // Boton de guardar

        Positioned(
            top: 250,
            right: 100,
            child: SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: guardarAudio,
                shape: const CircleBorder(),
                child: const Icon(Icons.save),
              ),
            )),

// Boton eliminar

        Positioned(
            top: 250,
            left: 100,
            child: SizedBox(
              width: 40,
              height: 40,
              child: FloatingActionButton(
                onPressed: cancelarAudio,
                shape: const CircleBorder(),
                child: const Icon(Icons.delete),
              ),
            )),
/*
        Positioned(
            top: 450,
            child: ElevatedButton(
                onPressed: playRecording, child: const Text("Poner"))),
*/
        // Duracion de grabacion

        Positioned(
            top: 340,
            child: Container(
              child: Text(
                '${(_duracion.inMinutes % 60).toString().padLeft(2, '0')}:${(_duracion.inSeconds % 60).toString().padLeft(2, '0')}',
                style: const TextStyle(color: Colors.white60, fontSize: 30),
              ),
            )),

        // Visualizador de audio
        Positioned(
            top: 380,
            child: Container(
              width: 500,
              height: 50,
              child: AudioVisualOndas(recorderController: recorderController),
            )),
      ],
    );
  }
}
