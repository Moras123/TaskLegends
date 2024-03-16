import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasklegend/main.dart';

class ConfiguracionesScreen extends StatefulWidget {
  @override
  _ConfiguracionesScreenState createState() => _ConfiguracionesScreenState();
}

class _ConfiguracionesScreenState extends State<ConfiguracionesScreen> {
  String _idiomaSeleccionado = 'Español';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _cargarIdiomaSeleccionado(); // Cargar el idioma seleccionado al iniciar la pantalla
  }
  Future<void> _cargarIdiomaSeleccionado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _idiomaSeleccionado = prefs.getString('idioma_seleccionado') ?? 'Español'; // Obtener el valor guardado o usar 'Español' por defecto
    });
  }

  Future<void> _selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('background_image', pickedFile.path);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuraciones'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.orange,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Idioma',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<String>(
                isExpanded: true,
                value: _idiomaSeleccionado,
                onChanged: (String? newValue) async {
                  setState(() {
                    _idiomaSeleccionado = newValue!;
                  });
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  int flag = (newValue == 'Español') ? 1 : (newValue == 'Inglés') ? 2 : 0;
                  await prefs.setInt('idioma_flag', flag);
                  await prefs.setString('idioma_seleccionado', newValue!); // Guardar el idioma seleccionado

                  // Ejecutar MyApp() o MyApp2() según el idioma seleccionado
                  if (newValue == 'Español') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  } else if (newValue == 'Inglés') {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp2()),
                    );
                  }
                },
                items: <String>['Español', 'Inglés']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Imagen de fondo',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: _selectImage, // Llama a la función para seleccionar la imagen
              ),
            ),
            // Añade más widgets de configuración aquí
          ],
        ),
      ),
    );
  }
}