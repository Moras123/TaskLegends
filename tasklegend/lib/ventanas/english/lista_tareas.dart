import 'package:flutter/material.dart';
import 'package:tasklegend/DatabaseHelper.dart';
import 'package:tasklegend/ventanas/english/addtaskscreen.dart';



class TaskListScreen2 extends StatefulWidget {
  @override
  _TaskListScreenState2 createState() => _TaskListScreenState2();
}

class _TaskListScreenState2 extends State<TaskListScreen2> {
  List<Task> tasks = [];

  void initState() {
    super.initState();
    _loadTasks(); // Carga las tareas al iniciar el estado del widget
  }

  void _loadTasks() async {
    final List<Map<String, dynamic>> rows = await DatabaseHelper.readTable();
    setState(() {
      tasks = rows.map((row) => Task(name: row['task'])).toList();
    });
  }
  void _navigateToAddTaskScreen() async {
    final newTask = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddTaskScreen2()),
    );
    if (newTask != null) {
      setState(() {
        tasks.add(newTask);
      });
    }
    else{
      _loadTasks();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      backgroundColor: Colors.orange, // Fondo naranja
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white), // Fondo de la tabla blanco
                columns: [
                  DataColumn(label: Text('Task')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: tasks.map((task) {
                  return DataRow(cells: [
                    DataCell(Text(task.name)),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            _showModifyConfirmationDialog(context, task);
                            // No hay ninguna acción aquí para evitar el error de compilación
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // Lógica para eliminar la tarea
                            _showDeleteConfirmationDialog(context, task);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.details),
                          onPressed: () {
                            print('Task details: ${task.name}');
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: 16), // Espacio entre la tabla y el contenedor del botón de agregar
          Center( // Centro del botón de agregar
            child: FloatingActionButton(
              onPressed: () {
                // Navega a AddTaskScreen para agregar tarea
                _navigateToAddTaskScreen();
              },
              tooltip: 'Add Task',
              child: Icon(Icons.add),
            ),
          ),
          SizedBox(height: 16), // Espacio entre el contenedor del botón de agregar y el borde inferior
        ],
      ),
    );
  }

  void _showModifyConfirmationDialog(BuildContext context, Task task) {
    final TextEditingController _newTaskNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modify Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Enter the new task name:'),
              SizedBox(height: 8),
              TextField(
                controller: _newTaskNameController,
                decoration: InputDecoration(
                  labelText: 'New name',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final newTaskName = _newTaskNameController.text;
                if (newTaskName.isNotEmpty) {
                  await DatabaseHelper.modifyTask(task.name, newTaskName);
                  setState(() {
                    task.name = newTaskName;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully modified task'),
                    ),
                  );
                }
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
  void _showDeleteConfirmationDialog(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete the task "${task.name}"?'),
          actions: [
            TextButton(
              onPressed: () async {
                await DatabaseHelper.deleteTask(task.name);
                setState(() {
                  tasks.remove(task);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Task deleted successfully'),
                  ),
                );
              },
              child: Text('Yes'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}


class Task {
  String name;

  Task({required this.name});
}
