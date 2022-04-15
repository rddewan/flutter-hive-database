import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hive_demo/model/bank.dart';
import 'package:flutter_hive_demo/model/student.dart';
import 'package:flutter_hive_demo/model/teacher.dart';
import 'package:flutter_hive_demo/page/bank_page.dart';
import 'package:flutter_hive_demo/page/home_page.dart';
import 'package:flutter_hive_demo/page/student_page.dart';
import 'package:flutter_hive_demo/page/teacher_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive_flutter/hive_flutter.dart';

const secureStorage = FlutterSecureStorage();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final encryptionKey = await secureStorage.read(key: 'hiveKey');
  if (encryptionKey == null) {
    final key  = Hive.generateSecureKey();
    await secureStorage.write(key: 'hiveKey', value: base64Url.encode(key));
  }
  
  final key  = base64Url.decode(encryptionKey.toString());

  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.initFlutter('hive_db');

  Hive.registerAdapter<Student>(StudentAdapter());
  Hive.registerAdapter<Teacher>(TeacherAdapter());
  Hive.registerAdapter<Bank>(BankAdapter());

  await Hive.openBox('home');
  await Hive.openBox<Student>('students');
  await Hive.openBox<Teacher>(
    'teachers',
    compactionStrategy: ((entries, deletedEntries) => deletedEntries >= 20));
  await Hive.openBox<Bank>('banks', encryptionCipher: HiveAesCipher(key));


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(     
        primarySwatch: Colors.blue,
      ),
      //home: const MyHomePage(title: 'Flutter Hive'),
      home: const MyHomePage(title: 'Flutter Hive'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int index = 0;
  final pages = [
    const HomeScreen(),
    const StudentScreen(),
    const TeacherScreen(),
    const BankScreen(),
  ];
  

  @override
  void dispose() {
    Hive.box('home').compact();
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(      
        title: Text(widget.title),
      ),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        backgroundColor: Colors.teal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.tealAccent,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Student'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Teacher'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
            label: 'Bank'
          )
        ],
      ),
    );
  }
}
