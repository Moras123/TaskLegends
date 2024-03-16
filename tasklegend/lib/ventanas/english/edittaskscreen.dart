import 'package:flutter/material.dart';
import 'package:tasklegend/DatabaseHelper.dart';
import 'package:tasklegend/task.dart';

 // Importa la clase Task desde su archivo correspondiente

class EditTaskScreen2 extends StatefulWidget {
  final Task task;

  EditTaskScreen2({required this.task});

  @override
  _EditTaskScreenState2 createState() => _EditTaskScreenState2();
}

class _EditTaskScreenState2 extends State<EditTaskScreen2> {
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
        title: Text('Edit task'),
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
                  child: Text('Save'),
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
