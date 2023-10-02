import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

class PackageWidget extends StatelessWidget {
  const PackageWidget({
    super.key,
    required this.w,
    required this.ontap,
    required this.type,
    required this.price,
    required this.detail,
    required this.selected,
  });

  final double w;
  final Function() ontap;
  final String type, price, detail;
  final Color selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: w,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
          color: selected.withOpacity(0.2), // Colors.grey.shade200,
          border: Border.all(
            color: selected, // const Color.fromARGB(255, 240, 190, 9),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 215, 190, 138),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                type,
                style: TextStyle(color: AppColor.mainColor, fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              detail,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
