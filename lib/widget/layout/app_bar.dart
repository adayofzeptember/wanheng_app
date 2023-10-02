import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AppMenuBar extends StatelessWidget {
  AppMenuBar({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
    this.onBack,
  }) : super(key: key);
  String title;
  Color color;
  var icon;
  var onBack;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      leading: IconButton(
        onPressed: onBack ?? () async {},
        icon: Icon(
          Icons.arrow_back_ios,
          color: color,
          size: 30,
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(icon, color: color, size: 25),
        ),
      ],
    );
  }
}
