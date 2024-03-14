import 'package:flutter/material.dart';
import 'package:tasklegend/confscreen.dart';

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
              // Acción para ayuda
            },
          ),
        ],
      ),
      body: Container(
        // Color de fondo que aparecerá donde la imagen no llegue a cubrir
        color: Color(0xFF003366),
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/fondolegends.jpg"),
              fit: BoxFit.contain, // Cambia a BoxFit.cover si deseas que la imagen cubra todo, pero se recorte
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
              SizedBox(height: 48), // Espacio entre el logo y los botones
              ElevatedButton(
                onPressed: () {
                  // Acción para la Lista de Tareas
                },
                child: Text('Lista de Tareas'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
              SizedBox(height: 24), // Espacio entre botones
              ElevatedButton(
                onPressed: () {
                  // Acción para el Reporte de Tareas
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
      ),
    );

  }
}
