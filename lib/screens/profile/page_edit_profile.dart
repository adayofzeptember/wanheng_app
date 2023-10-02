import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';

import '../../blocs/account/account_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/config.dart';
import '../../utils/convert_month.dart';
import '../../utils/images_path.dart';
import '../../widget/components/btn.dart';
import '../../widget/components/dropdown_custom.dart';
import '../../widget/components/form.dart';

// ignore: must_be_immutable
class PageEditProfile extends StatefulWidget {
  PageEditProfile(
      {Key? key,
      required this.firstName,
      required this.lastName,
      required this.gender,
      required this.selectedDay,
      required this.selectedMon,
      required this.selectedYear,
      required this.selectedHour,
      required this.selectedMin})
      : super(key: key);
  String firstName, lastName, gender, selectedDay, selectedMon, selectedYear, selectedHour, selectedMin;

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  TextEditingController nameController = TextEditingController();

  TextEditingController lastnameController = TextEditingController();

  final days = List<String>.generate(31, (counter) => "${counter + 1}");

  final month = [
    "มกราคม",
    "กุมภาพันธ์",
    "มีนาคม",
    "เมษายน",
    "พฤษภาคม",
    "มิถุนายน",
    "กรกฎาคม",
    "สิงหาคม",
    "กันยายน",
    "ตุลาคม",
    "พฤศจิกายน",
    "ธันวาคม"
  ];

  final year =
      List<String>.generate(80, (counter) => "${(int.parse(DateTime.now().year.toString()) - 80) + counter}").reversed.toList();

  final min = List<String>.generate(60, (counter) => (counter < 10) ? "0${counter}" : "$counter");

  final hour = List<String>.generate(24, (counter) => (counter < 10) ? "0${counter}" : "$counter");

  String? selectedDay, selectedMon, selectedYear, selectedHour, selectedMin;
  String? gender;

  bool? checkName, checkGender, checkDay, checkTime;
  TextStyle errStyle = TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10);

  // This is the file that will be used to store the image
  File? imageProfile;

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> openImagePicker() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageProfile = File(pickedImage.path);
      });
      Navigator.pop(context);
    }
  }

  // used camera
  Future<void> openCameraPicker() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      setState(() {
        imageProfile = File(pickedImage.path);
      });
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    lastnameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    nameController.text = widget.firstName;
    lastnameController.text = widget.lastName;
    gender = widget.gender;
    selectedDay = widget.selectedDay;
    selectedMon = widget.selectedMon;
    selectedYear = widget.selectedYear;
    selectedHour = widget.selectedHour;
    selectedMin = widget.selectedMin;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'แก้ไขโปรไฟล์',
          style: TextStyle(
            fontSize: 20,
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: AppColor.title),
        ),
        backgroundColor: AppColor.mainColor,
        elevation: 0,
      ),
      backgroundColor: AppColor.mainColor,
      body: SingleChildScrollView(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return Container(
              height: h,
              width: w,
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      height: h * .9,
                      width: w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(35.0),
                          topLeft: Radius.circular(35.0),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          const Text(
                            'ชื่อ-นามสกุล',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: w,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (w / 2) - 25,
                                  child: FormCustom(
                                    controller: nameController,
                                    hint: 'ชื่อ',
                                  ),
                                ),
                                SizedBox(
                                  width: (w / 2) - 25,
                                  child: FormCustom(controller: lastnameController, hint: 'นามสกุล'),
                                ),
                              ],
                            ),
                          ),
                          (checkName == true)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(' *ชื่อ-นามสกุลไม่ถูกต้อง', style: errStyle),
                                )
                              : const SizedBox(height: 10),
                          const Text(
                            'เพศ',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: RadioListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.all(1),
                                    activeColor: AppColor.mainColor,
                                    title: const Align(
                                      alignment: Alignment((-1), 0),
                                      child: Text(
                                        "ชาย",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    value: 'ชาย',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      gender = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: RadioListTile(
                                    contentPadding: const EdgeInsets.all(0),
                                    activeColor: AppColor.mainColor,
                                    title: const Align(
                                      alignment: Alignment((-1), 0),
                                      child: Text(
                                        "หญิง",
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    value: 'หญิง',
                                    groupValue: gender,
                                    onChanged: (value) {
                                      gender = value;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'วันเดือนปีเกิด',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (w / 4) - 30,
                                child: CustomDropdownButton2(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: 'วัน',
                                  dropdownItems: days,
                                  value: selectedDay,
                                  onChanged: (value) {
                                    print(value);
                                    setState(() {
                                      selectedDay = value;
                                    });
                                  },
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              SizedBox(
                                width: (w / 2) - 50,
                                child: CustomDropdownButton2(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: 'เดือน',
                                  dropdownItems: month,
                                  value: selectedMon,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedMon = value;
                                    });
                                  },
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                // width: (w / 3) - 40,
                                child: CustomDropdownButton2(
                                  icon: const Icon(Icons.arrow_drop_down),
                                  hint: 'ปี',
                                  dropdownItems: year,
                                  value: selectedYear,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedYear = value;
                                    });
                                  },
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: AppColor.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          (checkDay == true)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(' *วันเดือนปีเกิดไม่ถูกต้อง', style: errStyle),
                                )
                              : const SizedBox(height: 10),
                          const Text(
                            'เวลาเกิด',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (w / 2) - 40,
                                  child: CustomDropdownButton2(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    hint: 'ชั่วโมง',
                                    dropdownItems: hour,
                                    value: selectedHour,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedHour = value;
                                      });
                                    },
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColor.grey,
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(":", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                                SizedBox(
                                  width: (w / 2) - 40,
                                  child: CustomDropdownButton2(
                                    icon: const Icon(Icons.arrow_drop_down),
                                    hint: 'นาที',
                                    dropdownItems: min,
                                    value: selectedMin,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedMin = value;
                                      });
                                    },
                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppColor.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          (checkTime == true)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(' *เวลาเกิดไม่ถูกต้อง', style: errStyle),
                                )
                              : const SizedBox(height: 20),
                          const SizedBox(height: 10),
                          (state.loading == false)
                              ? Center(
                                  child: SizedBox(
                                    width: 150,
                                    child: Btn(
                                      title: 'บันทึก',
                                      onClick: () {
                                        if (nameController.text.length == 0 || lastnameController.text.length == 0) {
                                          checkName = true;
                                        } else {
                                          checkName = false;
                                        }
                                        if (gender == null) {
                                          checkGender = true;
                                          EasyLoading.showToast('โปรดเลือกเพศ');
                                        } else {
                                          checkGender = false;
                                        }
                                        if (selectedYear == null || selectedMon == null || selectedDay == null) {
                                          checkDay = true;
                                        } else {
                                          checkDay = false;
                                        }
                                        if (selectedHour == null || selectedMin == null) {
                                          checkTime = true;
                                        } else {
                                          checkTime = false;
                                        }

                                        setState(() {});

                                        if (checkName == false && checkGender == false && checkDay == false && checkTime == false) {
                                          context.read<AccountBloc>().add(UserCreate(
                                                context: context,
                                                imageProfile: imageProfile,
                                                firstName: nameController.text,
                                                lastName: lastnameController.text,
                                                gender: (gender == "ชาย") ? "male" : (gender == "หญิง" ? "female" : "none"),
                                                birthDay:
                                                    "${selectedYear}-${convertMonth(selectedMon)}-${selectedDay} ${selectedHour}:${selectedMin}:00",
                                              ));
                                        } else {
                                          print("Something bug in edit_profile");
                                        }
                                      },
                                      textColor: Colors.white,
                                      bgColor: AppColor.mainColor,
                                    ),
                                  ),
                                )
                              : SpinKitPouringHourGlassRefined(
                                  color: AppColor.mainColor,
                                ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: w,
                                height: 80,
                                child: TextButton(
                                  onPressed: () {
                                    openImagePicker();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.image_outlined, color: Colors.black),
                                      SizedBox(width: 4),
                                      Text(
                                        "แกลลอรี่",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              Container(
                                width: w,
                                height: 80,
                                child: TextButton(
                                  onPressed: () {
                                    openCameraPicker();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.camera_alt, color: Colors.black),
                                      SizedBox(width: 4),
                                      Text(
                                        "ถ่ายภาพ",
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Container(
                            width: 120.0,
                            height: 120.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              image: (imageProfile == null)
                                  ? (state.avatar == "")
                                      ? DecorationImage(image: AssetImage(AppImage.noImage), fit: BoxFit.cover)
                                      : DecorationImage(image: NetworkImage("$apiPublic" + state.avatar), fit: BoxFit.cover)
                                  : DecorationImage(image: FileImage(imageProfile!), fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                              border: Border.all(
                                color: Colors.white,
                                width: 4.0,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(0, 0),
                                  spreadRadius: 1,
                                  blurRadius: 4,
                                  color: Color.fromRGBO(233, 170, 170, 0.44),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 10,
                            right: 3,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey, width: 1.5),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
