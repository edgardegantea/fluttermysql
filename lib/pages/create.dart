import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';

class CreatePage extends StatelessWidget {
  final TextEditingController idnotaController = TextEditingController();
  final TextEditingController fechahoraController = TextEditingController();
  final TextEditingController autorController = TextEditingController();
  final TextEditingController municipioController = TextEditingController();
  final TextEditingController estadoController = TextEditingController();
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController subtituloController = TextEditingController();
  final TextEditingController resumenController = TextEditingController();
  final TextEditingController contenidoController = TextEditingController();
  final TextEditingController imagen1Controller = TextEditingController();
  final TextEditingController imagen2Controller = TextEditingController();
  final TextEditingController imagen3Controller = TextEditingController();
  final TextEditingController tipoController = TextEditingController();
  final TextEditingController contadorController = TextEditingController();
  final TextEditingController videourl1Controller = TextEditingController();
  final TextEditingController videourl2Controller = TextEditingController();

  CreatePage({Key? key}) : super(key: key);

  Future<void> _saveDataToDatabase() async {
    final conn = await MySqlConnection.connect(
      ConnectionSettings(
        host: '204.93.216.11',
        port: 3306,
        user: 'chipset_jared',
        db: 'chipset_notas_test',
        password: 'Temp123\$',
      ),
    );

    await conn.query(
      'INSERT INTO noticias (idnota, fechahora, autor, municipio, estado, titulo, subtitulo, resumen, contenido, imagen1, imagen2, imagen3, tipo, contador, videourl1, videourl2) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
      [
        idnotaController.text,
        fechahoraController.text,
        autorController.text,
        municipioController.text,
        estadoController.text,
        tituloController.text,
        subtituloController.text,
        resumenController.text,
        contenidoController.text,
        imagen1Controller.text,
        imagen2Controller.text,
        imagen3Controller.text,
        tipoController.text,
        contadorController.text,
        videourl1Controller.text,
        videourl2Controller.text,
      ],
    );

    await conn.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar nota (en desarrollo)', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: idnotaController,
                decoration: InputDecoration(labelText: 'ID Nota'),
              ),
              TextField(
                controller: fechahoraController,
                decoration: InputDecoration(labelText: 'Fecha y Hora'),
              ),
              TextField(
                controller: autorController,
                decoration: InputDecoration(labelText: 'Autor'),
              ),
              TextField(
                controller: municipioController,
                decoration: InputDecoration(labelText: 'Municipio'),
              ),
              TextField(
                controller: estadoController,
                decoration: InputDecoration(labelText: 'Estado'),
              ),
              TextField(
                controller: tituloController,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                controller: subtituloController,
                decoration: InputDecoration(labelText: 'Subtítulo'),
              ),
              TextField(
                controller: resumenController,
                decoration: InputDecoration(labelText: 'Resumen'),
              ),
              TextField(
                controller: contenidoController,
                decoration: InputDecoration(labelText: 'Contenido'),
                maxLines: null,
              ),
              SizedBox(height: 20.0),
              // Aquí puedes agregar widgets para seleccionar fotos
              // (puede ser un botón que abre el selector de fotos del dispositivo)

              ElevatedButton(
                onPressed: () {
                  // Implementa la lógica para seleccionar fotos
                },
                child: Text('Seleccionar Foto'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Implementa la lógica para seleccionar fotos
                },
                child: Text('Seleccionar Foto'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  // Implementa la lógica para seleccionar fotos
                },
                child: Text('Seleccionar Foto'),
              ),
              TextField(
                controller: tipoController,
                decoration: InputDecoration(labelText: 'Tipo'),
              ),
              TextField(
                controller: contadorController,
                decoration: InputDecoration(labelText: 'Contador'),
              ),
              TextField(
                controller: videourl1Controller,
                decoration: InputDecoration(labelText: 'URL de Video 1'),
              ),
              TextField(
                controller: videourl2Controller,
                decoration: InputDecoration(labelText: 'URL de Video 2'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Guardar la nueva noticia en la base de datos
                  _saveDataToDatabase();
                  // Mostrar un mensaje de éxito
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('La noticia se ha agregado correctamente.'),
                    ),
                  );
                  // Limpiar los controladores de texto después de guardar
                  idnotaController.clear();
                  fechahoraController.clear();
                  autorController.clear();
                  municipioController.clear();
                  estadoController.clear();
                  tituloController.clear();
                  subtituloController.clear();
                  resumenController.clear();
                  contenidoController.clear();
                  imagen1Controller.clear();
                  imagen2Controller.clear();
                  imagen3Controller.clear();
                  tipoController.clear();
                  contadorController.clear();
                  videourl1Controller.clear();
                  videourl2Controller.clear();
                },
                child: Text('Guardar nota'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}


