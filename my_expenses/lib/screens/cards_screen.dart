import 'package:flutter/material.dart';
import 'package:my_expenses/models/credit_card.dart';
import 'package:my_expenses/providers/cards_provider.dart';
import 'package:provider/provider.dart';

import '../components/outline_text_field.dart';
import '../functions/functions.dart';

class CardsScreen extends StatelessWidget {
  CardsScreen({Key? key}) : super(key: key);



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
                return Container(
                  margin: EdgeInsets.only(top: 8),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      trailing: FittedBox(
                        //TODO implement the date here when date provider is ready
                        child: Text(
                          "-R\$" +
                              cardsProvider.cards[index]
                                  .getValueByMonth("05/2022")
                                  .toStringAsFixed(2),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      leading: const Icon(Icons.credit_card),
                      title: Text(cardsProvider.cards[index].name),
                      onTap: () {
                        Functions.cardEditBottomSheet(
                          context,
                          cardsProvider,
                          cardsProvider.cards[index],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          GlobalKey<FormState> formKey = GlobalKey<FormState>();
          Functions.cardEditBottomSheet(context, cardsProvider, null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }


}
