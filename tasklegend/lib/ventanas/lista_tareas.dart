import 'package:flutter/material.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];

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
              scrollDirection: Axis.horizontal,
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
                            // Lógica para editar la tarea
                            print('Editar tarea: ${task.name}');
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
                            // Lógica para ver detalles de la tarea
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
                FloatingActionButton(
                  onPressed: () {
                    _showAddTaskDialog(context);
                  },
                  tooltip: 'Agregar Tarea',
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Agregar Tarea'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
            decoration: InputDecoration(hintText: 'Nombre de la tarea'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (newTask.isNotEmpty) {
                  setState(() {
                    tasks.add(Task(name: newTask));
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Agregar'),
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
              onPressed: () {
                setState(() {
                  tasks.remove(task);
                });
                Navigator.of(context).pop();
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