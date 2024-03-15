import 'package:flutter/material.dart';
import 'package:tasklegend/ventanas/addtaskscreen.dart';

import '../DatabaseHelper.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
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
      MaterialPageRoute(builder: (context) => AddTaskScreen()),
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
        title: Text('Lista de Tareas'),
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
                  DataColumn(label: Text('Tarea')),
                  DataColumn(label: Text('Acciones')),
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
                            print('Detalles de tarea: ${task.name}');
                          },
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16), // Espacio entre los botones
                FloatingActionButton(
                  onPressed: () {
                    // Navega a AddTaskScreen para agregar tarea
                    _navigateToAddTaskScreen();
                  },
                  tooltip: 'Agregar Tarea',
                  child: Icon(Icons.add),
                ),
                SizedBox(width: 16), // Espacio entre los botones
                FloatingActionButton(
                  onPressed: () {
                    // No hay ninguna acción aquí para evitar el error de compilación
                  },
                  tooltip: 'Editar Tarea',
                  child: Icon(Icons.edit),
                ),
                SizedBox(width: 16), // Espacio entre los botones
                FloatingActionButton(
                  onPressed: () {
                    // Acción para el botón de eliminar tarea
                    print('Eliminar tarea');
                  },
                  tooltip: 'Eliminar Tarea',
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ),
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
          title: Text('Modificar Tarea'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Introduce el nuevo nombre de la tarea:'),
              SizedBox(height: 8),
              TextField(
                controller: _newTaskNameController,
                decoration: InputDecoration(
                  labelText: 'Nuevo nombre',
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
                      content: Text('Tarea modificada con éxito'),
                    ),
                  );
                }
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
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
          title: Text('Eliminar Tarea'),
          content: Text('¿Estás seguro de que quieres eliminar la tarea "${task.name}"?'),
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
                    content: Text('Tarea eliminada con éxito'),
                  ),
                );
              },
              child: Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
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
