import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Gastos"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(),
          Expanded(
            child: TableCalendar(
                currentDay: DateTime.now(),
                focusedDay: DateTime.now(),
                firstDay: DateTime.now().subtract(Duration(days: 365 * 2)),
                lastDay: DateTime.now().add(Duration(days: 365 * 4))),
          ),
        ],
      ),
    );
  }
}
