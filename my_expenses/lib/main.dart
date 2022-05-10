import 'package:flutter/material.dart';
import 'package:my_expenses/providers/expensesProvider.dart';
import 'package:my_expenses/screens/home.dart';
import 'package:my_expenses/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ExpensesProvider>(
          create: (ctx) => ExpensesProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Meus Gastos',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        routes: {
          AppRoutes.HOME: (ctx) => HomeScreen(),
        },
      ),
    );
  }
}

