import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabkhataproject/base/base.dart';
import 'package:hishabkhataproject/screens/show_details_screen.dart';
import 'package:hishabkhataproject/widgets/c_dialog.dart';
import 'package:hishabkhataproject/widgets/dropdownwidget.dart';
import 'package:intl/intl.dart';
import '../services/isar_services.dart';
import '../widgets/c_button.dart';
import '../widgets/c_text.dart';

class InputScreen extends StatelessWidget {
  final IsarService service = IsarService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber.shade100,
        appBar: AppBar(
            backgroundColor: Colors.purple,
            centerTitle: true,
            title: Ctext(
              text: DateFormat('MMMM').format(
                DateTime.now(),
              ),
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            actions: [
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

                  Base.controller.totalIncomeAmount.value =
                      Base.controller.dataList.fold(0.0, (sum, item) => sum + item.incomeamount!);
                  Base.controller.totalExpenseAmount.value =
                      Base.controller.dataList.fold(0.0, (sum, item) => sum + item.expenseAmount!);

                  Base.controller.totaloutFlow.value =
                      Base.controller.totalIncomeAmount.value - Base.controller.totalExpenseAmount.value;

                  if (x.isNotEmpty) {
                    Get.to(
                      () => ShowDetailsScreen(),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Data ')));
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

                  Base.controller.totalIncomeAmount.value =
                      Base.controller.dataList.fold(0.0, (sum, item) => sum + item.incomeamount!);
                  Base.controller.totalExpenseAmount.value =
                      Base.controller.dataList.fold(0.0, (sum, item) => sum + item.expenseAmount!);

                  Base.controller.totaloutFlow.value =
                      Base.controller.totalIncomeAmount.value - Base.controller.totalExpenseAmount.value;

                  if (x.isNotEmpty) {
                    Get.to(
                      () => ShowDetailsScreen(),
                    );
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
        body: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5,
                            color: Colors.amber.shade50,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Ctext(
                                    fontWeight: FontWeight.bold,
                                    text: 'Earn this Month'.tr,
                                  ),
                                  Ctext(
                                    text: ' Tk ${5000} ',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5,
                            color: Colors.cyan.shade50,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Ctext(
                                    fontWeight: FontWeight.bold,
                                    text: 'Expense this Month'.tr,
                                  ),
                                  Ctext(
                                    text: 'Tk ${5000}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Card(
                      elevation: 5,
                      color: Colors.indigo.shade50,
                      child: Container(
                        margin: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Ctext(
                              fontWeight: FontWeight.bold,
                              text: 'Balance Remain'.tr,
                            ),
                            Ctext(
                              text: ' Tk ${5000} ',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5,
                            color: Colors.limeAccent,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Ctext(
                                    fontWeight: FontWeight.bold,
                                    text: 'Savings'.tr,
                                  ),
                                  Ctext(
                                    text: ' Tk ${5000} ',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5,
                            color: Colors.orange.shade100,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Ctext(
                                    fontWeight: FontWeight.bold,
                                    text: 'Debt'.tr,
                                  ),
                                  Ctext(
                                    text: 'Tk ${5000}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Card(
                            elevation: 5,
                            color: Colors.purple.shade50,
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                children: [
                                  Ctext(
                                    fontWeight: FontWeight.bold,
                                    text: 'Owed'.tr,
                                  ),
                                  Ctext(
                                    text: 'Tk ${5000}',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Cbutton(
                          bgcolor: Colors.teal,
                          icon: const Icon(Icons.money),
                          ontap: () {
                            globalDialog('Add Income', true, Colors.teal);
                          },
                          title: 'Add Income',
                        ),
                        Cbutton(
                          bgcolor: Colors.red,
                          icon: const Icon(Icons.money),
                          ontap: () {
                            globalDialog('Add Expense', false, Colors.red);
                          },
                          title: 'Add Expense',
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          width: 110,
                          alignment: Alignment.centerRight,
                          child: ChooseDropDown()),
                    ),
                    Obx(() => Container(
                          alignment: Alignment.center,
                          height: 40,
                          width: Get.width - 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.purple.withOpacity(0.5),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Stack(
                            children: [
                              Ctext(
                                text: '${Base.controller.selectedItem} History',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              Positioned(
                                  left: 10,
                                  top: 10,
                                  child: Container(
                                    height: 25,
                                    width: 30,
                                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/budgets.png'))),
                                  )),
                            ],
                          ),
                        ))
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Base.controller.descriptionController.text = 'Shikkha Upokornedtfrdsfgdsfsdfgsdfgdfsg';
                        Base.controller.amountController.text = '500.0';
                        globalDialog('Update', false, Colors.green);
                      },
                      child: Container(
                          margin: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 70,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const CircleAvatar(
                                  backgroundColor: Colors.green,
                                  radius: 10,
                                ),
                                SizedBox(
                                  width: 120,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Ctext(text: 'Shikkha Upokornedtfrdsfgdsfsdfgsdfgdfsg', fontWeight: FontWeight.w800),
                                      Ctext(text: '23-10-23'),
                                    ],
                                  ),
                                ),
                                Ctext(text: 'Income', color: Colors.green, fontWeight: FontWeight.w800),
                                Ctext(text: 'Tk 500', color: Colors.green, fontWeight: FontWeight.w800),
                                const Icon(
                                  Icons.delete_outline_sharp,
                                  color: Colors.red,
                                )
                              ])),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(5),
          child: AnimatedFloatingActionButton(
              //Fab list
              fabButtons: <Widget>[float1(), float2(), float3(), float4()],
              key: key,
              colorStartAnimation: Colors.purple,
              colorEndAnimation: Colors.red,
              animatedIconData: AnimatedIcons.menu_close //To principal button
              ),
        ));
  }

  Widget float1() {
    return FloatingActionButton(
        backgroundColor: Colors.pink,
        onPressed: null,
        heroTag: "btn1",
        tooltip: 'Debt / owe',
        child: Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/oweds.png'))),
        ));
  }

  Widget float2() {
    return FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: null,
        heroTag: "btn2",
        tooltip: 'Savings',
        child: Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/savings.png'))),
        ));
  }

  Widget float3() {
    return FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: null,
        heroTag: "btn3",
        tooltip: 'Planning',
        child: Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/budgets.png'))),
        ));
  }

  Widget float4() {
    return FloatingActionButton(
        onPressed: null,
        backgroundColor: Colors.lightBlue,
        heroTag: "btn4",
        tooltip: 'Notes',
        child: Container(
          height: 35,
          width: 35,
          decoration: const BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: AssetImage('assets/notes.png'))),
        ));
  }
}
