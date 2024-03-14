class Task {
  int id;
  String name;
  String date;
  String status;

  Task({required this.id, required this.name, required this.date, required this.status});

  // Método factory para crear una tarea desde un mapa
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['task'],
      date: map['date'],
      status: map['status'],
    );
  }

  // Método para convertir una tarea a un mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task': name,
      'date': date,
      'status': status,
    };
  }
}
