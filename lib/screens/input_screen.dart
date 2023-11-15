// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hishabkhataproject/base/base.dart';
import 'package:hishabkhataproject/models/data_model.dart';
import 'package:hishabkhataproject/screens/show_details_screen.dart';
import 'package:intl/intl.dart';
import '../services/isar_services.dart';
import '../widgets/dropdownwidget.dart';

class InputScreen extends StatelessWidget {
  final IsarService service = IsarService();
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(actions: [
          GestureDetector(
            onTap: () async {
              // final x = await service.getAllData();
              Base.controller.yearlySelected(true);
              final x = await service.getAllData();
              Base.controller.dataList.clear();
              Base.controller.dataList.addAll(x);
              Base.controller.dataList.sort(
                (a, b) => a.date!.compareTo(b.date!),
              );

              Base.controller.totalIncomeAmount.value = Base.controller.dataList.fold(0.0, (sum, item) => sum + item.incomeamount!);
              Base.controller.totalExpenseAmount.value = Base.controller.dataList.fold(0.0, (sum, item) => sum + item.expenseAmount!);

              Base.controller.totaloutFlow.value = Base.controller.totalIncomeAmount.value - Base.controller.totalExpenseAmount.value;

              if (x.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowDetailsScreen(),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No Data ')));
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(Icons.calculate),
            ),
          ),
          GestureDetector(
            onTap: () async {
              // final x = await service.getAllData();
              Base.controller.yearlySelected(false);
              final x = await service.getAllDataFor(Base.controller.selectedDate.value);
              Base.controller.dataList.clear();
              Base.controller.dataList.addAll(x);
              Base.controller.dataList.sort(
                (a, b) => a.date!.compareTo(b.date!),
              );

              Base.controller.totalIncomeAmount.value = Base.controller.dataList.fold(0.0, (sum, item) => sum + item.incomeamount!);
              Base.controller.totalExpenseAmount.value = Base.controller.dataList.fold(0.0, (sum, item) => sum + item.expenseAmount!);

              Base.controller.totaloutFlow.value = Base.controller.totalIncomeAmount.value - Base.controller.totalExpenseAmount.value;

              if (x.isNotEmpty) {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ShowDetailsScreen(),
                ));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No Data at ${DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value)}')));
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(Icons.calendar_view_month),
            ),
          )
        ]),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Obx(
                () => GestureDetector(
                    onTap: () {
                      Base.controller.selectDateHome();
                    },
                    child: Text(DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value))),
              ),
              const SizedBox(
                height: 15,
              ),
              ChooseDropDown(),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                onChanged: Base.controller.descriptionText,
                controller: Base.controller.descriptionController,
                decoration: const InputDecoration(hintText: 'Description'),
              ),
              const SizedBox(
                height: 15,
              ),
              TextField(
                  onChanged: Base.controller.amountText,
                  controller: Base.controller.amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor:
              Base.controller.amountText.value != '' && Base.controller.descriptionText.value != '' ? Colors.blue : Colors.grey,
          onPressed: () {
            // print(Base.controller.amountController.value!.text);
            // print(Base.controller.descriptionController.value!.text);
            Base.controller.descriptionController.value.text != '' && Base.controller.amountController.value.text != ''
                ? service.saveData(DataModel()
                  ..incomeamount =
                      Base.controller.selectedValue.value != 'Income' ? 0 : double.parse(Base.controller.amountController.value!.text)
                  ..date = DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value)
                  ..expenseAmount =
                      Base.controller.selectedValue.value == 'Income' ? 0 : double.parse(Base.controller.amountController.value!.text)
                  ..description = Base.controller.descriptionController.value.text
                  ..monthName = Base.controller.selectedDate.value.month.toString())
                : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Description or amount Can\'t be Empty')));
          },
          tooltip: 'Save',
          child: Base.controller.saveLoading.value ? const CircularProgressIndicator() : const Icon(Icons.save),
          // This trailing comma makes auto-formatting nicer for build methods.
        )));
  }
}
