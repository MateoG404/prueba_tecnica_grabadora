// Importar las bibliotecas necesarias
import 'package:flutter/material.dart';
import 'package:grabadora_app/pages/list_grabaciones.dart';
import 'package:grabadora_app/pages/record.dart';

// Definición de la clase BodyClass como un StatefulWidget
class BodyClass extends StatefulWidget {
  @override
  _BodyClassState createState() => _BodyClassState();
}

// Definición del estado de BodyClass
class _BodyClassState extends State<BodyClass>
    with SingleTickerProviderStateMixin {
  // Declarar variables
  late String titulo = "Grabar"; // Título de la barra de aplicaciones
  late TabController _tabController; // Controlador para las pestañas

  // Inicializar el estado
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Inicializar el controlador de pestañas
  }

  // Limpiar recursos cuando el widget se destruye
  @override
  void dispose() {
    _tabController.dispose(); // Eliminar el controlador de pestañas
    super.dispose();
  }

  // Construir la interfaz de usuario
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra de aplicaciones
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          titulo,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      // Cuerpo de la aplicación
      body: Column(
        children: [
          Expanded(
            // Vista de pestañas
            child: TabBarView(
              controller: _tabController,
              // Páginas para cada pestaña
              children: [
                RecordClass(), // Página de grabación
                ListaGrabaciones(), // Página de lista de grabaciones
              ],
            ),
          ),
        ],
      ),
      // Barra de navegación inferior
      bottomNavigationBar: Material(
        color: Colors.black,
        child: TabBar(
          controller: _tabController,
          // Pestañas en la barra de navegación inferior
          tabs: [
            Tab(
                icon: Icon(Icons.fiber_manual_record, color: Colors.purple),
                text: 'Grabar'),
            Tab(icon: Icon(Icons.list_sharp), text: 'Ver Audios'),
          ],
        ),
      ),
    );
  }
}
