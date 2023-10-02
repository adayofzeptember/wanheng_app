import 'package:flutter/material.dart';

class BgPackage extends StatelessWidget {
  const BgPackage({
    super.key,
    required this.w,
    required this.column,
  });

  final double w;
  final List<Widget> column;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w,
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(217, 189, 190, 190),
            spreadRadius: 1,
            blurRadius: 1.0,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: column,
      ),
    );
  }
}
