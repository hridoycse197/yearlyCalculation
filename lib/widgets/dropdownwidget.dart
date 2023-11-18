import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hishabkhataproject/widgets/c_text.dart';

import '../base/base.dart';

class ChooseDropDown extends StatefulWidget {
  @override
  _ChooseDropDownState createState() => _ChooseDropDownState();
}

class _ChooseDropDownState extends State<ChooseDropDown> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DropdownButton<String>(
        value: Base.controller.selectedItem.value,
        onChanged: (String? newValue) {
          Base.controller.selectedItem.value = newValue!;
        },
        items: <String>['Daily', 'Monthly', 'Yearly'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Ctext(
              text: value,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          );
        }).toList(),
      ),
    );
  }
}
