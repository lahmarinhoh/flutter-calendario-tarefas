import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ToDoListPage extends StatefulWidget {
  final DateTime selectedDate;

  const ToDoListPage({super.key, required this.selectedDate});

  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoListPage> {
  final database = FirebaseDatabase.instance.ref();
  List<Task> tasks = [];
  StreamSubscription<DatabaseEvent>? _taskSubscription;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  @override
  void dispose() {
    _taskSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = '${widget.selectedDate.day}/${widget.selectedDate.month}/${widget.selectedDate.year}';

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Tarefas $dateFormatted'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.checklist_rounded, size: 60, color: Colors.pinkAccent),
            SizedBox(height: 8),
            Text(
              'Gerencie suas tarefas do dia',
              style: TextStyle(fontSize: 18, color: Colors.pink),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Expanded(
              child: tasks.isEmpty
                  ? Center(
                child: Text('Nenhuma tarefa adicionada.', style: TextStyle(color: Colors.grey)),
              )
                  : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      title: Text(
                        task.name,
                        style: TextStyle(
                          decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      leading: Icon(
                        task.isCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
                        color: task.isCompleted ? Colors.green : Colors.redAccent,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.check, color: Colors.green),
                            onPressed: () => _toggleTaskCompletion(index),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _removeTask(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
                  icon: Icon(Icons.add),
                  label: Text('Adicionar'),
                  onPressed: () => _showAddTaskDialog(context),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                  ),
                  icon: Icon(Icons.delete_sweep),
                  label: Text('Limpar'),
                  onPressed: () => _showRemoveAllTasksDialog(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    String newTaskName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Adicionar tarefa'),
          content: TextField(
            onChanged: (value) => newTaskName = value,
            decoration: InputDecoration(hintText: 'Nome da tarefa'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (newTaskName.isNotEmpty) {
                  final dateKey = '${widget.selectedDate.day}${widget.selectedDate.month}${widget.selectedDate.year}';
                  final newRef = database.child('calendar/$dateKey/').push();
                  final newTask = Task(name: newTaskName, id: newRef.key);
                  newRef.set(newTask.toJson());
                  Navigator.pop(context);
                }
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _showRemoveAllTasksDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Limpar todas as tarefas'),
          content: Text('Você tem certeza que deseja limpar todas as tarefas?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                final dateKey = '${widget.selectedDate.day}${widget.selectedDate.month}${widget.selectedDate.year}';
                database.child('calendar/$dateKey').remove();
                setState(() => tasks.clear());
                Navigator.pop(context);
              },
              child: Text('Limpar'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTaskCompletion(int index) {
    final task = tasks[index];
    task.isCompleted = !task.isCompleted;

    final dateKey = '${widget.selectedDate.day}${widget.selectedDate.month}${widget.selectedDate.year}';
    if (task.id != null) {
      database.child('calendar/$dateKey/${task.id}').set(task.toJson());
    }
  }

  void _removeTask(int index) {
    final task = tasks[index];
    final dateKey = '${widget.selectedDate.day}${widget.selectedDate.month}${widget.selectedDate.year}';

    if (task.id != null) {
      database.child('calendar/$dateKey/${task.id}').remove();
    }

    setState(() => tasks.removeAt(index));
  }

  void _loadTasks() {
    final dateKey = '${widget.selectedDate.day}${widget.selectedDate.month}${widget.selectedDate.year}';
    final ref = database.child('calendar/$dateKey');

    _taskSubscription = ref.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        final map = Map<String, dynamic>.from(data as Map);
        final updatedTasks = map.entries.map((entry) {
          final taskData = Map<String, dynamic>.from(entry.value);
          return Task.fromJson({...taskData, 'id': entry.key});
        }).toList();

        updatedTasks.sort((a, b) {
          if (a.isCompleted == b.isCompleted) return 0;
          return a.isCompleted ? 1 : -1;
        });

        setState(() => tasks = updatedTasks);
      } else {
        setState(() => tasks = []);
      }
    });
  }
}

class Task {
  String name;
  bool isCompleted;
  String? id;

  Task({required this.name, this.isCompleted = false, this.id});

  Map<String, dynamic> toJson() => {
    'name': name,
    'isCompleted': isCompleted,
    'id': id,
  };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    name: json['name'],
    isCompleted: json['isCompleted'],
    id: json['id'],
  );
}
