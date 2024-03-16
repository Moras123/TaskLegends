import 'package:flutter/material.dart';
import 'package:tasklegend/DatabaseHelper.dart';


class AddTaskScreen2 extends StatefulWidget {
  @override
  _AddTaskWindowState2 createState() => _AddTaskWindowState2();
}

class _AddTaskWindowState2 extends State<AddTaskScreen2> {
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add task'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondoAdd.jpg'),
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
                    hintText: 'Insert task',
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    await DatabaseHelper.insertTask(_taskController.text);
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
