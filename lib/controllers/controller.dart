import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../base/base.dart';
import '../models/data_model.dart';
import '../services/isar_services.dart';

class Controller extends GetxController {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();
  final descriptionText = RxString('');
  final amountText = RxString('');
  final saveLoading = RxBool(false);
  final yearlySelected = RxBool(false);
  final selectedDate = Rx<DateTime>(DateTime.now());
  final dataList = RxList<DataModel>([]);
  final selectedValue = RxString('Income');
  final totalIncomeAmount = RxDouble(0);
  final totalExpenseAmount = RxDouble(0);
  final totaloutFlow = RxDouble(0);
  selectDateHome() async {
    final date = await showDatePicker(
        context: Get.context!, initialDate: selectedDate.value, firstDate: DateTime(1950), lastDate: DateTime.now());

    if (date != null) {
      selectedDate(date);
    }
  }

  changeDate() async {
    dataList.clear();
    final date = await showDatePicker(
        context: Get.context!, initialDate: selectedDate.value, firstDate: DateTime(1950), lastDate: DateTime.now());

    if (date != null) {
      selectedDate(date);

      final IsarService service = IsarService();
      final x = await service.getAllDataFor(selectedDate.value);
      if (x.isNotEmpty) {
        dataList.addAll(x);
        dataList.sort(
          (a, b) => a.date!.compareTo(b.date!),
        );
      } else {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text('No Data at ${DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value)}')));
      }
    }
  }
}
