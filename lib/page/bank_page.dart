import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/bank.dart';
import 'package:flutter_hive_demo/page/add_bank_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

class BankScreen extends StatefulWidget {
  const BankScreen({Key? key}) : super(key: key);

  @override
  State<BankScreen> createState() => _BankScreenState();
}

class _BankScreenState extends State<BankScreen> {
  late Box<Bank> bankBox;

  @override
  void initState() {   
    super.initState();
    bankBox = Hive.box('banks');
  }

  @override
  void dispose() {
    //bankBox.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: bankBox.listenable(), 
        builder: (context,box,child) {
          final filterBox = bankBox.values.where((element) => element.amount > 100).toList();

        return ListView.builder(
          itemCount: filterBox.length,
          itemBuilder: ((context, index) {
            final student = filterBox[index];

            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.id.toString()),
                    Text(student.name.toString()),
                    Text(student.accountNumber.toString()),
                    Text(student.amount.toString()),
                  ],

                ),
              ),
            );

        }
        ),);     

        },
      ),       
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (_) => const AddBankScreen(),));
        }, 
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
    );
  
  }
}