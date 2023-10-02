import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';

// ignore: must_be_immutable
class CardDetail extends StatelessWidget {
  CardDetail({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.content,
    this.iconTitleElemment,
    required this.isTop,
    required this.person,
    this.zodiac,
  }) : super(key: key);
  String? title, subtitle, content, iconTitleElemment, person;
  String? zodiac;
  bool isTop;
  ScrollController scollBarController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 4, 10),
            height: 280,
            // width: 395,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 242, 217),
              image: const DecorationImage(
                image: AssetImage(AppImage.bgCardDetail),
                fit: BoxFit.scaleDown,
              ),
              border: Border.all(color: const Color.fromARGB(255, 209, 180, 132), width: 2.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: RawScrollbar(
              thumbVisibility: true,
              controller: scollBarController,
              thumbColor: const Color.fromARGB(255, 209, 180, 132),
              radius: Radius.circular(30),
              child: ListView(
                controller: scollBarController,
                shrinkWrap: true,
                children: [
                  Text(
                    title ?? "",
                    style: const TextStyle(
                      color: AppColor.mainColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  if (zodiac != "") const SizedBox(height: 8),
                  Text(
                    zodiac ?? '',
                    style: TextStyle(
                      color: checkElementColorAccount(zodiac!),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (zodiac != "") const SizedBox(height: 8),
                  Text(
                    subtitle ?? "",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(content ?? ""),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "บุคคล",
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(person ?? ""),
                ],
              ),
            ),
          ),
          Positioned(
            right: 40,
            top: 1,
            child: Container(
              width: 90,
              height: 90,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(90),
                  border: Border.all(width: 3.5, color: const Color.fromARGB(255, 209, 180, 132))),
              child: (isTop)
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        checkElementImage(iconTitleElemment!),
                        Text(
                          iconTitleElemment ?? "",
                          style: TextStyle(
                            color: checkElementColorAccount(iconTitleElemment!),
                            fontSize: 10,
                          ),
                        )
                      ],
                    )
                  : checkHoroImage(zodiac!),
            ),
          ),
        ],
      ),
    );
  }
}

Image checkElementImage(String element) {
  return Image.asset(
    (element == "ธาตุไฟหยาง")
        ? AppImage.fire0
        : (element == "ธาตุน้ำหยาง")
            ? AppImage.water0
            : (element == "ธาตุดินหยาง")
                ? AppImage.soli0
                : (element == "ธาตุทองหยาง")
                    ? AppImage.gold0
                    : (element == "ธาตุไม้หยาง")
                        ? AppImage.wood0
                        : (element == "ธาตุไฟหยิน")
                            ? AppImage.fire1
                            : (element == "ธาตุน้ำหยิน")
                                ? AppImage.water1
                                : (element == "ธาตุดินหยิน")
                                    ? AppImage.soli1
                                    : (element == "ธาตุทองหยิน")
                                        ? AppImage.gold1
                                        : AppImage.wood1,
    fit: BoxFit.contain,
    color: checkElementColorAccount(element),
  );
}

checkElementColorAccount(String element) {
  return (element == "ธาตุไฟหยาง")
      ? AppColor.fire0
      : (element == "ธาตุน้ำหยาง")
          ? AppColor.water0
          : (element == "ธาตุดินหยาง")
              ? AppColor.soli0
              : (element == "ธาตุทองหยาง")
                  ? AppColor.gold0
                  : (element == "ธาตุไม้หยาง")
                      ? AppColor.wood0
                      : (element == "ธาตุไฟหยิน")
                          ? AppColor.fire1
                          : (element == "ธาตุน้ำหยิน")
                              ? AppColor.water1
                              : (element == "ธาตุดินหยิน")
                                  ? AppColor.soli1
                                  : (element == "ธาตุทองหยิน")
                                      ? AppColor.gold1
                                      : AppColor.wood1;
}

Image checkHoroImage(String zodiac) {
  return Image.asset(
    (zodiac == "ชวด")
        ? AppImage.rat_0
        : (zodiac == "ฉลู")
            ? AppImage.ox_0
            : (zodiac == "ขาล")
                ? AppImage.tiger_0
                : (zodiac == "เถาะ")
                    ? AppImage.rabbit_0
                    : (zodiac == "มะโรง")
                        ? AppImage.great_snake_0
                        : (zodiac == "มะเส็ง")
                            ? AppImage.tiger_0
                            : (zodiac == "มะเมีย")
                                ? AppImage.snake_0
                                : (zodiac == "มะแม")
                                    ? AppImage.goat_0
                                    : (zodiac == "วอก")
                                        ? AppImage.monkey_0
                                        : (zodiac == "ระกา")
                                            ? AppImage.cock_0
                                            : (zodiac == "จอ")
                                                ? AppImage.dog_0
                                                : AppImage.pig_0,
    fit: BoxFit.fill,
  );
}
