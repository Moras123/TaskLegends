import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasklegend/confscreen.dart'; // Asegúrate de que este path sea correcto
import 'package:tasklegend/ventanas/lista_tareas.dart'; // Asegúrate de que este path sea correcto
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasklegend/ventanas/reporte.dart';


String manualDeUsuario = """
¡Bienvenido a Task Legends!
Esta app permitirá a verdaderos guerreros Z administrar su tiempo para ser la mejor versión de sí mismos.
Solo debes presionar en una de las dos opciones, "Lista de tareas" o configuración si deseas realizar algunos ajustes estéticos.
En "Lista de tareas" se maneja completamente la app, permitiendo añadir, quitar o actualizar tareas.  
""";

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Legends',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.black,
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? backgroundImage;

  @override
  void initState() {
    super.initState();
    _loadBackgroundImage();
  }

  Future<void> _loadBackgroundImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      backgroundImage = prefs.getString('background_image') ?? "assets/images/fondogokumain.jpg";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConfiguracionesScreen()),
              ).then((_) => _loadBackgroundImage()); // Recargar fondo al volver de Configuraciones
            },
          ),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Manual de Usuario'),
                    content: Text(manualDeUsuario),
                    backgroundColor: Colors.orange,
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            // Verifica si backgroundImage es nulo antes de usarlo
            image: backgroundImage != null
                ? backgroundImage!.startsWith('assets/')
                ? AssetImage(backgroundImage!) as ImageProvider
                : FileImage(File(backgroundImage!))
                : AssetImage("assets/images/fondogokumain.jpg"), // Imagen predeterminada
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 200.0,
                child: Image.asset('assets/images/tasklegends.jpg', fit: BoxFit.contain),
              ),
              SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskListScreen()),
                  );
                },
                child: Text('Lista de Tareas'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskReportPage()),
                  );
                },
                child: Text('Reporte de Tareas'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
