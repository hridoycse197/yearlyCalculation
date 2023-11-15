// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hishabkhataproject/models/data_model.dart';
import 'package:hishabkhataproject/screens/pdf_maker_screen.dart';
import 'package:intl/intl.dart';
import "package:collection/collection.dart";
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../base/base.dart';

class ShowDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Base.controller.dataList.isNotEmpty
            ? Text(Base.controller.dataList.first.monthName == '01'
                ? 'January'
                : Base.controller.dataList.first.monthName == '02'
                    ? 'February'
                    : Base.controller.dataList.first.monthName == '03'
                        ? 'March'
                        : Base.controller.dataList.first.monthName == '04'
                            ? 'April'
                            : Base.controller.dataList.first.monthName == '05'
                                ? 'May'
                                : Base.controller.dataList.first.monthName == '06'
                                    ? 'June'
                                    : Base.controller.dataList.first.monthName == '07'
                                        ? 'July'
                                        : Base.controller.dataList.first.monthName == '08'
                                            ? 'August'
                                            : Base.controller.dataList.first.monthName == '09'
                                                ? 'September'
                                                : Base.controller.dataList.first.monthName == '10'
                                                    ? 'October'
                                                    : Base.controller.dataList.first.monthName == '11'
                                                        ? 'November'
                                                        : 'December')
            : Text(Base.controller.selectedDate.value.month == 01
                ? 'January'
                : Base.controller.selectedDate.value.month == 02
                    ? 'February'
                    : Base.controller.selectedDate.value.month == 03
                        ? 'March'
                        : Base.controller.selectedDate.value.month == 04
                            ? 'April'
                            : Base.controller.selectedDate.value.month == 05
                                ? 'May'
                                : Base.controller.selectedDate.value.month == 06
                                    ? 'June'
                                    : Base.controller.selectedDate.value.month == 07
                                        ? 'July'
                                        : Base.controller.selectedDate.value.month == 08
                                            ? 'August'
                                            : Base.controller.selectedDate.value.month == 09
                                                ? 'September'
                                                : Base.controller.selectedDate.value.month == 10
                                                    ? 'October'
                                                    : Base.controller.selectedDate.value.month == 11
                                                        ? 'November'
                                                        : 'December'),
      ),
      body: Obx(() => Base.controller.dataList.isNotEmpty
          ? Base.controller.yearlySelected.value
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text("Total Income: ${Base.controller.dataList.fold(0.0, (sum, item) => sum + item.incomeamount!)}")
                            ],
                          ),
                          Row(
                            children: [
                              Text("Total Expense: ${Base.controller.dataList.fold(0.0, (sum, item) => sum + item.expenseAmount!)}")
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                  "Difference: ${(Base.controller.dataList.fold(0.0, (sum, item) => sum + item.incomeamount!)) - (Base.controller.dataList.fold(0.0, (sum, item) => sum + item.expenseAmount!))}")
                            ],
                          ),
                          GestureDetector(
                              onTap: () {
                                Get.to(() => CreatePdfWidget());
                              },
                              child: Icon(Icons.print))
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: groupBy(Base.controller.dataList, (p0) => p0.monthName).length,
                          itemBuilder: (context, index) {
                            final item = groupBy(Base.controller.dataList, (p0) => p0.monthName).keys.elementAt(index);
                            return Column(
                              children: [
                                Text(item == '01'
                                    ? 'January'
                                    : item == '02'
                                        ? 'February'
                                        : item == '03'
                                            ? 'March'
                                            : item == '04'
                                                ? 'April'
                                                : item == '05'
                                                    ? 'May'
                                                    : item == '06'
                                                        ? 'June'
                                                        : item == '07'
                                                            ? 'July'
                                                            : item == '08'
                                                                ? 'August'
                                                                : item == '09'
                                                                    ? 'September'
                                                                    : item == '10'
                                                                        ? 'October'
                                                                        : item == '11'
                                                                            ? 'November'
                                                                            : 'December'),
                                SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  physics: const BouncingScrollPhysics(),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        // Obx(
                                        //   () => GestureDetector(
                                        //       onTap: () {
                                        //         Base.controller.changeDate();
                                        //       },
                                        //       child: Text(DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value))),
                                        // ),
                                        DataTable(
                                          columnSpacing: 20,
                                          columns: const [
                                            DataColumn(label: Text('SL')),
                                            DataColumn(label: Text('Date')),
                                            DataColumn(label: Text('Description')),
                                            DataColumn(label: Text('Income')),
                                            DataColumn(label: Text('Expense')),
                                          ],
                                          rows: groupBy(Base.controller.dataList, (p0) => p0.monthName)[item]!.map((expense) {
                                            return DataRow(cells: [
                                              DataCell(Text(
                                                  (groupBy(Base.controller.dataList, (p0) => p0.monthName)[item]!.indexOf(expense) + 1)
                                                      .toString())),
                                              DataCell(Text(expense.date!)),
                                              DataCell(Text(expense.description!)),
                                              DataCell(Text(expense.incomeamount.toString())),
                                              DataCell(Text(expense.expenseAmount.toString())),
                                            ]);
                                          }).toList(),
                                        ),
                                        const SizedBox(height: 12),
                                        Row(
                                          children: [
                                            Text(
                                                "Total Income: ${groupBy(Base.controller.dataList, (p0) => p0.monthName)[item]!.fold(0.0, (sum, item) => sum + item.incomeamount!)}")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "Total Expense: ${groupBy(Base.controller.dataList, (p0) => p0.monthName)[item]!.fold(0.0, (sum, item) => sum + item.expenseAmount!)}")
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                                "Difference: ${(groupBy(Base.controller.dataList, (p0) => p0.monthName)[item]!.fold(0.0, (sum, item) => sum + item.incomeamount!)) - (groupBy(Base.controller.dataList, (p0) => p0.monthName)[item]!.fold(0.0, (sum, item) => sum + item.expenseAmount!))}")
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: Colors.blueAccent,
                                  thickness: 15,
                                ),
                              ],
                            );
                          }),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => GestureDetector(
                              onTap: () {
                                Base.controller.changeDate();
                              },
                              child: Text(DateFormat('dd-MMM-yyyy').format(Base.controller.selectedDate.value))),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Total Income: ${Base.controller.totalIncomeAmount.value}")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Total Expense: ${Base.controller.totalExpenseAmount.value}")],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Difference: ${Base.controller.totaloutFlow.value}")],
                        ),
                        GestureDetector(
                            onTap: () {
                              generatePdf(Base.controller.dataList);
                            },
                            child: Icon(Icons.print)),
                        DataTable(
                          columnSpacing: 20,
                          columns: const [
                            DataColumn(label: Text('SL')),
                            DataColumn(label: Text('Date')),
                            DataColumn(label: Text('Description')),
                            DataColumn(label: Text('Income')),
                            DataColumn(label: Text('Expense')),
                          ],
                          rows: Base.controller.dataList.map((expense) {
                            return DataRow(cells: [
                              DataCell(Text((Base.controller.dataList.indexOf(expense) + 1).toString())),
                              DataCell(Text(expense.date!)),
                              DataCell(Text(expense.description!)),
                              DataCell(Text(expense.incomeamount.toString())),
                              DataCell(Text(expense.expenseAmount.toString())),
                            ]);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //   crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () {
                      Base.controller.changeDate();
                    },
                    child: const Icon(Icons.date_range)),
                const Center(child: Text('No Data Available')),
              ],
            )),
    );
  }

  generatePdf(List<DataModel> datas) async {
    final pdf = pw.Document();
    final font = await rootBundle.load("assets/OpenSans-Light.ttf");
    final ttf = pw.Font.ttf(font);
    pdf.addPage(pw.Page(
      build: (context) => pw.Column(
        children: [
          pw.SizedBox(
            height: 10,
          ),
          pw.Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Total Income: ${Base.controller.totalIncomeAmount.value}",
                style: pw.TextStyle(font: ttf),
              ),
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Total Expense: ${Base.controller.totalExpenseAmount.value}",
                style: pw.TextStyle(font: ttf),
              )
            ],
          ),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                "Difference: ${Base.controller.totaloutFlow.value}",
                style: pw.TextStyle(font: ttf),
              )
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
            pw.Text(
              'SL',
              style: pw.TextStyle(font: ttf),
            ),
            pw.Text(
              'Date',
              style: pw.TextStyle(font: ttf),
            ),
            pw.Text(
              'Description',
              style: pw.TextStyle(font: ttf),
            ),
            pw.Text(
              'Income',
              style: pw.TextStyle(font: ttf),
            ),
            pw.Text(
              'Expense',
              style: pw.TextStyle(font: ttf),
            ),
          ]),
          pw.ListView(
            children: datas
                .map((e) => pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                      pw.Text(
                        (datas.indexOf(e) + 1).toString(),
                        style: pw.TextStyle(font: ttf),
                      ),
                      pw.Text(
                        e.date!,
                        style: pw.TextStyle(font: ttf),
                      ),
                      pw.Text(
                        e.description!,
                        style: pw.TextStyle(font: ttf),
                      ),
                      pw.Text(
                        e.incomeamount.toString(),
                        style: pw.TextStyle(font: ttf),
                      ),
                      pw.Text(
                        e.expenseAmount.toString(),
                        style: pw.TextStyle(font: ttf),
                      ),
                    ]))
                .toList(),
          ),
        ],
      ),
    ));
    final directory = await getDownloadsDirectory();

    final xx = Uri.parse('${directory!.path}/XXXXXXXXXXXXX');
    final createdDir = await Directory.fromUri(xx).create();

    final file = await File("${createdDir.path}/x.pdf").create();
    // print(await file.readAsBytes());

    final x = await file.writeAsBytes(await pdf.save());
    print(x.path);
  }
}
