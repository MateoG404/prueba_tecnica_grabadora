import 'package:flutter/material.dart';
import 'package:grabadora_app/pages/body.dart';
import 'package:grabadora_app/pages/reproduccir_grabacion.dart';
import 'package:grabadora_app/pages/list_grabaciones.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Prueba tecnica Mateo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

          scaffoldBackgroundColor: Colors.black, // Fondo blanco
          useMaterial3: true,
        ),
        home: Scaffold(body: BodyClass() // b ListaGrabaciones(),
            ));
  }
}
