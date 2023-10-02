//* คำนวณ
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';

// ignore: must_be_immutable
class Predict extends StatelessWidget {
  Predict({Key? key, required this.handing}) : super(key: key);
  double handing;

  @override
  Widget build(BuildContext context) {
    return Text(
      (handing <= 15)
          ? 'ชวด น้ำ+'
          : (handing <= 45)
              ? 'ฉลู ดิน-'
              : (handing <= 75)
                  ? 'ขาล ไม้+'
                  : (handing <= 105)
                      ? 'เถาะ ไม้-'
                      : (handing <= 135)
                          ? 'มะโรง ดิน'
                          : (handing <= 165)
                              ? 'มะเส็ง ไฟ-'
                              : (handing <= 195)
                                  ? 'มะเมีย ไฟ+'
                                  : (handing <= 225)
                                      ? 'มะแม ดิน'
                                      : (handing <= 255)
                                          ? 'วอก ทอง-'
                                          : (handing <= 285)
                                              ? 'ระกา ทอง+'
                                              : (handing <= 315)
                                                  ? 'จอ ดิน+'
                                                  : (handing <= 345)
                                                      ? 'กุน น้ำ-'
                                                      : "ชวด น้ำ+",
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: (handing <= 15)
            ? AppColor.water0
            : (handing <= 45)
                ? AppColor.soli0
                : (handing <= 75)
                    ? AppColor.wood0
                    : (handing <= 105)
                        ? AppColor.wood1
                        : (handing <= 135)
                            ? const Color.fromARGB(255, 244, 190, 53)
                            : (handing <= 165)
                                ? AppColor.fire1
                                : (handing <= 195)
                                    ? AppColor.fire0
                                    : (handing <= 225)
                                        ? const Color.fromARGB(255, 248, 148, 33)
                                        : (handing <= 255)
                                            ? const Color.fromARGB(255, 150, 150, 150)
                                            : (handing <= 285)
                                                ? AppColor.gold0
                                                : (handing <= 315)
                                                    ? const Color.fromARGB(255, 191, 120, 55)
                                                    : (handing <= 345)
                                                        ? const Color.fromARGB(255, 135, 193, 229)
                                                        : AppColor.water0,
      ),
    );
  }
}
