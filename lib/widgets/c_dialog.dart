import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabkhataproject/widgets/c_text.dart';
import 'package:intl/intl.dart';

import '../base/base.dart';
import '../models/data_model.dart';
import '../services/isar_services.dart';
import 'c_button.dart';

void globalDialog(String title, bool isIncome, Color buttonColor) {
  final IsarService service = IsarService();
  Get.defaultDialog(
      barrierDismissible: false,
      onWillPop: () {
        return Future.value(false);
      },
      backgroundColor: Colors.white,
      title: '',
      content: Container(
        alignment: Alignment.center,
        width: Get.width,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Ctext(text: title, fontWeight: FontWeight.w700),
              const SizedBox(
                height: 10,
              ),
              Obx(
                () => GestureDetector(
                  onTap: () {
                    Base.controller.selectDateHome();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Ctext(fontWeight: FontWeight.bold, text: DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value)),
                      const Icon(Icons.calendar_month)
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Card(
                elevation: 5,
                child: TextFormField(
                  onChanged: Base.controller.descriptionText,
                  controller: Base.controller.descriptionController,
                  decoration: const InputDecoration(hintText: ' Description'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Card(
                elevation: 5,
                child: TextField(
                    onChanged: Base.controller.amountText,
                    controller: Base.controller.amountController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: ' Amount',
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: Get.width / 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Cbutton(
                        isDialog: true,
                        title: '  OK  ',
                        icon: const Icon(Icons.add),
                        ontap: Base.controller.descriptionText.value != '' && Base.controller.amountText.value != ''
                            ? () {
                                service.saveData(DataModel()
                                  ..incomeamount = !isIncome ? 0 : double.parse(Base.controller.amountController.value.text)
                                  ..date = DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value)
                                  ..expenseAmount = isIncome ? 0 : double.parse(Base.controller.amountController.value!.text)
                                  ..description = Base.controller.descriptionController.value.text
                                  ..monthName = Base.controller.selectedDate.value.month.toString());
                                Get.back();
                              }
                            : () {
                                ScaffoldMessenger.of(Get.context!)
                                    .showSnackBar(const SnackBar(content: Text('Description or amount Can\'t be Empty')));
                              },
                        bgcolor: buttonColor),
                    Cbutton(
                        isDialog: true,
                        title: 'Cancel',
                        icon: const Icon(Icons.add),
                        ontap: () {
                          Get.back();
                        },
                        bgcolor: Colors.grey),
                  ],
                ),
              )
            ],
          ),
        ),
      ));
}
