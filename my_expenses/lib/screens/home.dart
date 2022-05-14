import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/models/expense.dart';
import 'package:my_expenses/models/to_pay.dart';
import 'package:my_expenses/providers/expensesProvider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ExpensesProvider expensesProvider = Provider.of<ExpensesProvider>(context);
    print(expensesProvider.expenses.length);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Meus Gastos"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          AddExpense(context, formKey, expensesProvider);
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        
        children: [
          ListTile(
            leading: Icon(Icons.attach_money),
            title: Text(
                "R\$${expensesProvider.expenses.values.map<List<double>>((e) => e.map((e) => e.value).toList()).fold<double>(0, (previousValue, element) => element.fold<double>(0, (previousValue, element) => element + previousValue) + previousValue)}"),
            trailing: Icon(Icons.edit),
          ),
          Expanded(
            child: TableCalendar<Expense>(
                eventLoader: (date) {
                  return expensesProvider.expenses[formatDate(date)] ?? [];
                },
                calendarBuilders: CalendarBuilders<Expense>(
                  markerBuilder: (context, day, events) {
                    if (expensesProvider.expenses
                        .containsKey(formatDate(day))) {
                      print(day.toIso8601String());
                      return Container(
                        color: Colors.blue,
                      );
                    }
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    return Container(
                      color: Colors.red,
                    );
                  },
                ),
                selectedDayPredicate: (date) =>
                    compareDates(date, DateTime.now()),
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarFormat: CalendarFormat.month,
                currentDay: DateTime.now(),
                focusedDay: DateTime.now(),
                firstDay: DateTime.now().subtract(Duration(days: 365 * 2)),
                lastDay: DateTime.now().add(Duration(days: 365 * 4))),
          ),
        ],
      ),
    );
  }
bool compareDates(DateTime date1, DateTime date2) {
    return DateFormat("dd/MM/yyyy").format(date1) ==
        DateFormat("dd/MM/yyyy").format(date2);
  }

  String formatDate(DateTime date) {
    return DateFormat("dd/MM/yyyy").format(date);
  }
  Future<dynamic> AddExpense(BuildContext context, GlobalKey<FormState> formKey,
      ExpensesProvider expensesProvider) {
    DateTime? closeDate;
    DateTime? dueDate;
    TextEditingController valueText = TextEditingController();
    return showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (ctx) {
          return StatefulBuilder(
            builder: (context, setState) => GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.60,
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Adicionar Gasto",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: valueText,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                label: Text("Valor:"),
                                prefixText: "R\$: ",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                ),
                              ),
                              validator: (txt) {
                                if (txt == null) {
                                  return "O Valor está vazio";
                                } else if (txt.isEmpty) {
                                  return "O Valor está vazio";
                                } else if (double.tryParse(txt) == null) {
                                  return "Valor numérico inválido";
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        "Fechamento:",
                                        textAlign: TextAlign.center,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.grey),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)))),
                                        onPressed: () async {
                                          closeDate = await PickDate();
                                          dueDate = closeDate;
                                          setState(() {});
                                        },
                                        child: Text(closeDate == null
                                            ? "dd/mm/yy"
                                            : DateFormat("dd/MM/yy")
                                                .format(closeDate!)),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        "Vencimentio:",
                                        textAlign: TextAlign.center,
                                      ),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                                color: Colors.grey),
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)))),
                                        onPressed: () async {
                                          if (closeDate == null) {
                                            infoDialog(
                                                "A data de Fechamentio não pode estar vazia");
                                          } else {
                                            DateTime? toAdd = await PickDate(
                                                initialDate: closeDate);
                                            if (toAdd != null) {
                                              if (!toAdd.isBefore(closeDate!)) {
                                                setState(() {
                                                  dueDate = toAdd;
                                                });
                                              } else {
                                                infoDialog(
                                                    "A data de Vencimento não pode ser menor que a data de Fechamento");
                                              }
                                            }
                                          }
                                        },
                                        child: Text(dueDate == null
                                            ? "dd/mm/yy"
                                            : DateFormat("dd/MM/yy")
                                                .format(dueDate!)),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  bool isValid =
                                      formKey.currentState?.validate() ?? false;
                                  if (isValid) {
                                    if (closeDate != null) {
                                      if (dueDate != null) {
                                        expensesProvider.addToPay(
                                          ToPay(
                                            expiryDate: closeDate!,
                                            compensation: dueDate!,
                                            value: double.parse(valueText.text),
                                          ),
                                        );
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      } else {
                                        infoDialog(
                                            "A Data de Vencimento nao pode estar vazia");
                                      }
                                    } else {
                                      infoDialog(
                                          "A Data de Fechamento nao pode estar vazia");
                                    }
                                  }
                                },
                                child: Text("Adicionar"),
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<DateTime?> PickDate({DateTime? initialDate, DateTime? endDate}) async {
    initialDate ??= DateTime.now().subtract(const Duration(days: 365 * 2));
    endDate ??= DateTime.now().add(const Duration(days: 365 * 4));
    DateTime? dateTime;
    await showDatePicker(
            context: context,
            initialDate: DateTime.now().isBefore(initialDate)
                ? initialDate
                : DateTime.now(),
            firstDate: initialDate,
            lastDate: endDate)
        .then((value) => dateTime = value);
    return dateTime;
  }

  void infoDialog(String text) async {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Alerta"),
            content: Text(text),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text("Ok"),
              )
            ],
          );
        });
  }
}
