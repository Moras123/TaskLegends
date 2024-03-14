import 'package:flutter/material.dart';
import '../DatabaseHelper.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskWindowState createState() => _AddTaskWindowState();
}

class _AddTaskWindowState extends State<AddTaskScreen> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir tarea'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondoMUIG.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    hintText: 'Inserte tarea',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper.insertTask(_taskController.text);
                    Navigator.pop(context); // Vuelve a la pantalla anterior
                  },
                  child: Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }
}
