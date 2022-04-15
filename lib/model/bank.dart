
import 'package:hive/hive.dart';

part 'bank.g.dart';

@HiveType(typeId: 2)
class Bank extends HiveObject{
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final int accountNumber;
  @HiveField(3, defaultValue: 0.0)
  final double amount;

  Bank({ 
    required this.id, 
    required this.name, 
    required this.accountNumber, 
    required this.amount});

  

}