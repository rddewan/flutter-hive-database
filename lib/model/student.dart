
import 'package:hive/hive.dart';

part 'student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int age;
  @HiveField(3)
  final String subject;

  Student({ required this.id, required this.name, required this.age, required this.subject});

  

}