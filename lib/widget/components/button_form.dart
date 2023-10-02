import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

// ignore: must_be_immutable
class ButtonForm extends StatelessWidget {
  ButtonForm({
    super.key,
    required this.title,
    required this.onPressed,
    required this.background,
    required this.fontColor,
  });
  String title;
  Function()? onPressed;
  Color background, fontColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(110, 43),
        backgroundColor: background,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              width: 2.0,
              color: AppColor.mainColor,
            )),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal,
          color: fontColor,
        ),
      ),
    );
  }
}
