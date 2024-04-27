import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:intl/intl.dart';
import 'pages/show.dart';
import 'pages/create.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Establecer la ruta inicial
      // initialRoute: '/home',
      // Definir las rutas de la aplicación
      /*
      routes: {
        '/home': (context) => InicioPage(),
        '/new': (context) => CreatePage(),
      },
       */
      home: SplashScreen(),
    );
  }
}




class InicioPage extends StatelessWidget {
  const InicioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Image(image: AssetImage('lib/images/diarioenfoque.png')),
            ElevatedButton(
              child: Text('Notas'),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
          ],
        )

      ),
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Iniciar el temporizador para redirigir después de 3 segundos
    Timer(Duration(seconds: 3), () {
      // Navegar a la siguiente pantalla después de 3 segundos
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('lib/images/diarioenfoque.png', width: 200),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          'Diario Enfoque',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: readDataFromTable(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Map<String, dynamic>> data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                    shadowColor: Colors.red,

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage('https://www.diarioenfoque.com/${
                            data[index]['imagen']}' ?? ''),
                      ),
                      title: Text(
                        '${data[index]['titulo']}',
                        style: TextStyle(fontWeight: FontWeight.w500,),
                        textAlign: TextAlign.justify,
                      ),
                      subtitle: Text('${data[index]['contador'].toString().toUpperCase()} vistas\t\t${data[index]['municipio']}, ${data[index]['estado']}'),

                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShowPage(newsData: data[index]),
                          ),
                        );
                      },

                    ),
                  );
                },
              );
            } else {
              return Text('No hay datos');
            }
          },
        ),
      ),


      drawer: Drawer(),


      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, new MaterialPageRoute(builder: (context) => new CreatePage()));
        },
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.red,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50 )),
      ),
    );
  }



  String formatDate(DateTime date) {
    return DateFormat('d-m-y')
        .format(date);
  }

  Future<List<Map<String, dynamic>>> readDataFromTable() async {
    final connection = await _createConnection();

    Results results = await connection
        .query('SELECT * FROM notas order by idnota desc limit 10');
    await connection.close();

    List<Map<String, dynamic>> data = [];
    for (var row in results) {
      data.add({
        'idnota': row[0],
        'fecha': row[1],
        'autor': row[2],
        'municipio': row[3],
        'estado': row[4],
        'titulo': row[5],
        'subtitulo': row[6],
        'resumen': row[7],
        'contenido': row[8],
        'imagen1': row[9],
        'imagen2': row[10],
        'imagen3': row[11],
        'tipo': row[12],
        'contador': row[13],
        'videourl1': row[14],
        'videourl2': row[15]
      });
    }
    return data;
  }

  Future<MySqlConnection> _createConnection() async {
    final settings = ConnectionSettings(
      host: '204.93.216.11',
      port: 3306,
      user: 'chipset_jared',
      db: 'chipset_notas_test',
      password: 'Temp123\$',
    );

    return await MySqlConnection.connect(settings);
  }
}
