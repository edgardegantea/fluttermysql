import 'dart:convert';
import 'package:flutter/material.dart';

class ShowPage extends StatelessWidget {
  final Map<String, dynamic> newsData;

  const ShowPage({Key? key, required this.newsData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de la noticia'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                newsData['titulo'] ?? 'Sin título',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 16),
              _buildImageWidget(newsData['imagen_base64']),
              SizedBox(height: 32),

              Container(
                color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(newsData['tipo'].toString().toUpperCase(), style: TextStyle(color: Colors.white, backgroundColor: Colors.red),),
                    Text('${newsData['contador']} vistas', style: TextStyle(color: Colors.white, backgroundColor: Colors.red),),
                  ],
                ),
              ),
              SizedBox(height: 10,),

              Container(child: Text(newsData['resumen'].toString(), textAlign: TextAlign.justify, style: TextStyle(color: Colors.black87),),

              ),

              SizedBox(height: 16),
              _buildTextWidget(newsData['contenido'].toString()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageWidget(String? base64String) {
    if (base64String == null) {
      // Si la cadena base64 es nula, se muestra un icono de imagen predeterminado o un texto alternativo
      return Icon(Icons.image_not_supported, size: 100);
    } else {
      // Si la cadena base64 no es nula, la decodificamos y mostramos la imagen
      try {
        final bytes = base64Decode(base64String);
        return Image.memory(bytes);

      } catch (e) {
        // Si hay algún error al decodificar la imagen, se muestra un mensaje de error
        print('Error decoding image: $e');
        return Text('Error al cargar la imagen');
      }
    }
  }


  Widget _buildTextWidget(String? content) {
    if (content == null) {
      return Text('Sin contenido');
    } else {
      // Remover etiquetas HTML del contenido y reemplazar etiquetas <p> y </p>
      final strippedContent = content.replaceAll(RegExp(r'<p>'), '');
      final formattedContent = strippedContent.replaceAll('<p>', '').replaceAll('</p>', '\n');
      return Text(formattedContent, style: TextStyle(fontSize: 16), textAlign: TextAlign.justify,);
    }
  }




}
