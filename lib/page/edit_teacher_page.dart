import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/teacher.dart';
import 'package:hive/hive.dart';

class EditTeacherScreen extends StatefulWidget {
  final int index;
  const EditTeacherScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<EditTeacherScreen> createState() => _EditTeacherScreenState();
}

class _EditTeacherScreenState extends State<EditTeacherScreen> {
  final _key = GlobalKey<FormState>();
  int id = 0; 
  String? name; 
  int age =0; 
  String? subject;
  late Box<Teacher> teacherBox;
  late Teacher teacher;
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _ageController;
  late TextEditingController _subjectController;

  @override
  void initState() {    
    super.initState();
    teacherBox = Hive.box('teachers');

    _idController = TextEditingController();
    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _subjectController = TextEditingController();

    teacher = teacherBox.getAt(widget.index) as Teacher; 
    _idController.text = teacher.id.toString();
    _nameController.text = teacher.name.toString();
    _ageController.text = teacher.age.toString();
    _subjectController.text = teacher.subject.toString();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Teacher'),
        actions: [
          IconButton(onPressed: () {
            deleteTeacher();

          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  controller: _idController,
                  keyboardType: TextInputType.number,
                  enabled: false,
                  decoration: const InputDecoration(
                    labelText: 'Id',
                    helperText: 'Input your id'
                  ),
                  onSaved: (value) {
                    id = int.parse(value.toString());
                  },
                ),                
                TextFormField(
                  controller: _nameController,
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
                  controller: _ageController,
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
                  controller: _subjectController,
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
          saveTeacher();
        }, 
        label: const Text('Save'),
        icon: const Icon(Icons.save),
      ),
    );
  }

  void deleteTeacher() {
    teacherBox.deleteAt(widget.index);
  }

  void saveTeacher() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      teacherBox.putAt(
        widget.index,
        Teacher(
          id: id, 
          name: name.toString(), 
          age: age, 
          subject: subject.toString(),
        )
      );

    }
  }
}