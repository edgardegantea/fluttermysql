import 'package:flutter/material.dart';

class AddRecordView extends StatefulWidget {
  @override
  _AddRecordViewState createState() => _AddRecordViewState();
}

class _AddRecordViewState extends State<AddRecordView> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Nuevo Registro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Lógica para guardar el nuevo registro
              },
              child: Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}
