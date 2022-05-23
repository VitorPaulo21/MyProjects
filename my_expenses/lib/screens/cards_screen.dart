import 'package:flutter/material.dart';
import 'package:my_expenses/providers/cards_provider.dart';
import 'package:provider/provider.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CardsProvider cardsProvider = Provider.of<CardsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Cartões"),
        centerTitle: true,
      ),
      body: cardsProvider.cards.isEmpty
          ? const Center(
              child: Text(
                "Sem Cartoes...",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: cardsProvider.cards.length,
              itemBuilder: (ctx, index) {
                return ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: Text(cardsProvider.cards[index].name),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          showModalBottomSheet(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              )),
              context: context,
              isScrollControlled: true,
              builder: (ctx) {
                return DraggableScrollableSheet(
                  initialChildSize: 0.7,
                  minChildSize: 0.7,
                  maxChildSize: 0.7,
                  expand: false,
                  builder: (context, scrollController) {
                    return SingleChildScrollView(
                      child: Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              const Text(
                                "Cadastrar Cartao",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  label: const Text("Nome do Cartao"),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    borderSide: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
