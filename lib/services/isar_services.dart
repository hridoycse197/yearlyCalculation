import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabkhataproject/models/data_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../base/base.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
  }

  Future<void> saveData(DataModel newData) async {
    Base.controller.saveLoading(true);
    final isar = await db;
    isar.writeTxnSync<int>(() => isar.dataModels.putSync(newData));
    ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(content: Text('Saved Successfully')));
    Base.controller.saveLoading(false);
    Base.controller.descriptionController.clear();
    Base.controller.amountController.clear();
    Base.controller.descriptionText('');
    Base.controller.amountText('');
  }

  Future<List<DataModel>> getAllData() async {
    final isar = await db;
    final x = await isar.dataModels.where().findAll();
    //log('id: ${x.first.id}, date: ${x.first.date}, description: ${x.first.description}, amount: ${x.first.amount}, month: ${x.first.monthName}');
    return x;
  }

  Future<void> cleanDb() async {
    final isar = await db;
    await isar.writeTxn(() => isar.clear());
  }

  Future<List<DataModel>> getAllDataFor(DateTime date) async {
    final isar = await db;
    return await isar.dataModels.filter().monthNameEqualTo(date.month.toString()).findAll();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [DataModelSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }
}
