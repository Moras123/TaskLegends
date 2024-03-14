import 'package:flutter/material.dart';
import 'package:tasklegend/ventanas/addtaskscreen.dart';
import 'package:tasklegend/ventanas/edittaskscreen.dart';
import 'package:tasklegend/task.dart';

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
                SizedBox(width: 16), // Espacio entre los botones
                FloatingActionButton(
                  onPressed: () {
                    // Navega a AddTaskScreen para agregar tarea
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTaskScreen()),
                    );
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
