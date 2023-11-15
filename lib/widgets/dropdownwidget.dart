import 'package:flutter/material.dart';

import '../base/base.dart';

class ChooseDropDown extends StatefulWidget {
  @override
  _ChooseDropDownState createState() => _ChooseDropDownState();
}

class _ChooseDropDownState extends State<ChooseDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: Base.controller.selectedValue.value,
      onChanged: (String? newValue) {
        Base.controller.selectedValue.value = newValue!;
      },
      items: <String>['Income', 'Expense'].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
