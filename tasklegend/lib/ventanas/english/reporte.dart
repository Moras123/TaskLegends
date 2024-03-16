import 'package:flutter/material.dart';
import 'package:tasklegend/DatabaseHelper.dart';
import 'package:tasklegend/task.dart';

class TaskReportPage2 extends StatefulWidget {
  @override
  _TaskReportPageState2 createState() => _TaskReportPageState2();
}


class _TaskReportPageState2 extends State<TaskReportPage2> {
  List<Task> tasks = []; // Tareas actuales
  List<Task> deletedTasks = []; // Tareas eliminadas

  @override
  void initState() {
    super.initState();
    _loadTasks();
    _loadDeletedTasks();
  }

  void _loadTasks() async {
    final List<Map<String, dynamic>> rows = await DatabaseHelper.readTable();
    setState(() {
      tasks = rows.map((row) => Task(name: row['task'], id: row['id'], date: row['date'], status: row['status'])).toList();
    });
  }
  void _loadDeletedTasks() async {
    final List<Map<String, dynamic>> rows = await DatabaseHelper.readDeletedTasks();
    setState(() {
      deletedTasks = rows.map((row) =>Task(name: row['task'], id: row['id'], date: row['date'], status: row['status'])).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Report'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
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
class Task {
  int id;
  String name;
  String date;
  String status;
  Task({required this.id,required this.name,required this.date,required this.status});
}