import 'package:flutter/material.dart';
import 'package:tasklegend/DatabaseHelper.dart';
import 'package:tasklegend/task.dart';

class TaskReportPage extends StatefulWidget {
  @override
  _TaskReportPageState createState() => _TaskReportPageState();
}

class _TaskReportPageState extends State<TaskReportPage> {
  List<Task> tasks = []; // Tareas actuales
  List<Task> deletedTasks = []; // Tareas eliminadas

  @override
  void initState() {
    super.initState();
    loadTasks();
    loadDeletedTasks();
  }

  void loadTasks() {
    // Aquí deberías cargar las tareas desde tu base de datos o fuente de datos
    // Esto es solo un ejemplo de cómo podrías hacerlo
    tasks = [
      Task(id: 1, name: 'Task 1', date: '2024-03-15', status: 'Completed'),
      Task(id: 2, name: 'Task 2', date: '2024-03-16', status: 'Pending'),
    ];
  }

  Future<void> loadDeletedTasks() async {
    // Suponiendo que readDeletedTasks es tu método para obtener tareas eliminadas
    final deletedTasksData = await DatabaseHelper.readDeletedTasks();
    setState(() {
      deletedTasks = deletedTasksData.map((taskMap) => Task.fromMap(taskMap)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Report'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Current Tasks', style: Theme.of(context).textTheme.headline6),
            DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: tasks.map((task) => DataRow(cells: [
                DataCell(Text(task.id.toString())),
                DataCell(Text(task.name)),
                DataCell(Text(task.date)),
                DataCell(Text(task.status)),
              ])).toList(),
            ),
            SizedBox(height: 20), // Espaciado entre tablas
            Text('Deleted Tasks', style: Theme.of(context).textTheme.headline6),
            DataTable(
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Date')),
                DataColumn(label: Text('Status')),
              ],
              rows: deletedTasks.map((task) => DataRow(cells: [
                DataCell(Text(task.id.toString())),
                DataCell(Text(task.name)),
                DataCell(Text(task.date)),
                DataCell(Text(task.status)),
              ])).toList(),
            ),
          ],
        ),
      ),
    );
  }
}