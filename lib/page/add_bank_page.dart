import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/bank.dart';
import 'package:hive/hive.dart';

class AddBankScreen extends StatefulWidget {
  const AddBankScreen({Key? key}) : super(key: key);

  @override
  State<AddBankScreen> createState() => _AddBankScreenState();
}

class _AddBankScreenState extends State<AddBankScreen> {
  final _key = GlobalKey<FormState>();
  int id = 0; 
  String? name; 
  int accountNumber =0; 
  double amount = 0.0;
  late Box<Bank> bankBox;

  @override
  void initState() {    
    super.initState();
    bankBox = Hive.box('banks');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Bank')),
      body: Column(
        children: [
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Id',
                    helperText: 'Input your id'
                  ),
                  onSaved: (value) {
                    id = int.parse(value.toString());
                  },
                ),                
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    helperText: 'Input your name'
                  ),
                  onSaved: (value) {
                    name = value.toString();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Account Number',
                    helperText: 'Input your account number'
                  ),
                  onSaved: (value) {
                    accountNumber = int.parse(value.toString());
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Amount',
                    helperText: 'Input your amount'
                  ),
                  onSaved: (value) {
                    amount = double.parse(value.toString());
                  },
                ),
              ],

            )),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveStudent();
        }, 
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void saveStudent() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      bankBox.add(
        Bank(
          id: id, 
          name: name.toString(), 
          accountNumber: accountNumber, 
          amount: amount,
        )
      );

    }
  }
}