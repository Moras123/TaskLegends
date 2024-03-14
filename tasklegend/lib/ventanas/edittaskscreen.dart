import 'package:flutter/material.dart';
import '../DatabaseHelper.dart';
import '../task.dart'; // Importa la clase Task desde su archivo correspondiente

class EditTaskScreen extends StatefulWidget {
  final Task task;

  EditTaskScreen({required this.task});

  @override
  _EditTaskScreenState createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _taskController;

  @override
  void initState() {
    super.initState();
    _taskController = TextEditingController(text: widget.task.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar tarea'),
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
                    // Actualiza la tarea en la base de datos
                    await DatabaseHelper.updateTask(widget.task.id, _taskController.text);
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
