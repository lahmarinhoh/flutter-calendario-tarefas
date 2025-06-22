import 'package:flutter/material.dart';
import 'package:flutter_app/login.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_app/todoListPage.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text('Calendário de Tarefas'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            tooltip: 'Sair',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(Icons.calendar_today, size: 60, color: Colors.pinkAccent),
            SizedBox(height: 8),
            Text(
              'Selecione um dia para visualizar ou adicionar tarefas',
              style: TextStyle(fontSize: 18, color: Colors.pink),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            TableCalendar(
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.pink.shade300,
                  shape: BoxShape.circle,
                ),
              ),
              calendarFormat: _calendarFormat,
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              focusedDay: _focusedDay,
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ToDoListPage(selectedDate: selectedDay),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}