import 'package:flutter/material.dart';
import 'package:tasklegend/confscreen.dart';
import 'package:tasklegend/ventanas/lista_tareas.dart';

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
        // Personalizando colores del AppBar y los iconos aquí
        appBarTheme: AppBarTheme(
          color: Colors.black, // Color de fondo del AppBar
          iconTheme: IconThemeData(color: Colors.orange), // Color de los iconos
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
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
              );
              // Acción para la configuración
            },
          ),
          //espacio entre iconos
          SizedBox(width: 12),
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              // Muestra el AlertDialog con el manual de usuario
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Manual de Usuario'),
                    content: Text(manualDeUsuario),
                    backgroundColor: Colors.orange, // Color de fondo del AlertDialog
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
        color: Color(0xFF090E21),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fondogokumain.jpg"),
              fit: BoxFit.contain,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 200.0, // Establece un ancho para tu logo si es necesario
                  child: Image.asset('assets/images/tasklegends.jpg', fit: BoxFit.contain),
                ),
                SizedBox(height: 48), // Espacio entre el logo y el botón
                ElevatedButton(
                  onPressed: () {
                    // Acción para la Lista de Tarea
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
