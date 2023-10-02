import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Btn extends StatelessWidget {
  Btn({
    Key? key,
    this.height,
    this.bgColor,
    this.padding,
    this.imgOrIcon,
    required this.title,
    required this.onClick,
    this.textColor,
    this.fontWeight,
  }) : super(key: key);
  double? height, padding;
  Color? bgColor, textColor;
  var imgOrIcon, onClick;
  FontWeight? fontWeight;
  String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.of(context).size.width, height ?? 43),
        backgroundColor: bgColor ?? Colors.white,
        padding: EdgeInsets.all(padding ?? 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onClick,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(child: imgOrIcon),
          const SizedBox(width: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontStyle: FontStyle.normal,
              color: textColor ?? Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
