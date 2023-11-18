import 'package:flutter/material.dart';

import 'c_text.dart';

class Cbutton extends StatelessWidget {
  String title;
  VoidCallback ontap;
  Icon icon;
  Color bgcolor;
  Color fontColor;
  bool isDialog;
  Cbutton(
      {required this.title,
      this.isDialog = false,
      required this.icon,
      this.fontColor = Colors.white,
      required this.ontap,
      required this.bgcolor});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor, // Button color
        foregroundColor: Colors.white, // Text color
        elevation: 5, // Button shadow
        // shape: RoundedRectangleBorder(
        //   borderRadius: BorderRadius.circular(30.0), // Button border radius
        // ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10), // Button padding
      ),
      child: isDialog
          ? Ctext(
              text: title,
              color: fontColor,
              fontWeight: FontWeight.w600,
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(
                  width: 10,
                ),
                Ctext(
                  text: title,
                  color: fontColor,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
    );
  }
}
