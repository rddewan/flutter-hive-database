import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/student.dart';
import 'package:hive/hive.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _key = GlobalKey<FormState>();
  int id = 0; 
  String? name; 
  int age =0; 
  String? subject;
  late Box<Student> studentBox;

  @override
  void initState() {    
    super.initState();
    //studentBox = Hive.box('students');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Student')),
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
                    labelText: 'Age',
                    helperText: 'Input your age'
                  ),
                  onSaved: (value) {
                    age = int.parse(value.toString());
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Subject',
                    helperText: 'Input your subject'
                  ),
                  onSaved: (value) {
                    subject = value.toString();
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
      studentBox.add(
        Student(
          id: id, 
          name: name.toString(), 
          age: age, 
          subject: subject.toString(),
        )
      );

    }
  }
}