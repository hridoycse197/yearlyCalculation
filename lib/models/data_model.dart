import 'package:isar/isar.dart';

part 'data_model.g.dart';

@collection
class DataModel {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  String? monthName;
  String? date;
  String? description;

  double? incomeamount;
  double? expenseAmount;
  //DataModel({required this.amount, required this.date, required this.description, required this.monthName});
}
