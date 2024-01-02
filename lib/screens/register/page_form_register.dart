import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanheng_app/blocs/account/account_bloc.dart';
import 'package:wanheng_app/services/google%20signin/signin_method.dart';
import 'package:wanheng_app/utils/filter_email.dart';
import '../../routes/login.dart';
import '../../utils/app_colors.dart';
import '../../utils/config.dart';
import '../../utils/convert_month.dart';
import '../../utils/images_path.dart';
import '../../widget/components/btn.dart';
import '../../widget/components/dropdown_custom.dart';
import '../../widget/components/form.dart';

// ignore: must_be_immutable
class PageFormRegister extends StatefulWidget {
  PageFormRegister({
    Key? key,
  }) : super(key: key);

  @override
  State<PageFormRegister> createState() => _PageFormRegisterState();
}

class _PageFormRegisterState extends State<PageFormRegister> {
  var nameController = TextEditingController();

  var lastnameController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColor.mainColor,
        body: Container(
          width: w,
          height: h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.bg3),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 25),
                const Text(
                  'ปฏิทินฮวงจุ้ย',
                  style: TextStyle(
                    fontSize: 30,
                    color: AppColor.title,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 0),
                  child: Container(
                    width: w,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.subBg,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Center(
                          child: Text(
                            'ลงทะเบียนเข้าใช้งาน',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            if (!checkEmailDomain(state.email, "privaterelay.appleid.com"))
                              return Row(
                                children: [
                                  Text(
                                    "Email ",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${state.email}",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              );
                            else
                              return SizedBox();
                          },
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'ชื่อ-นามสกุล',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          width: w,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: (w / 2) - 40,
                                child: FormCustom(
                                  controller: nameController,
                                  hint: 'ชื่อ',
                                ),
                              ),
                              SizedBox(
                                width: (w / 2) - 40,
                                child: FormCustom(
                                  controller: lastnameController,
                                  hint: 'นามสกุล',
                                ),
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
                                width: 90,
                                child: RadioListTile(
                                  dense: true,
                                  contentPadding: const EdgeInsets.all(1),
                                  activeColor: AppColor.mainColor,
                                  title: const Align(
                                    alignment: Alignment((-1), 0),
                                    child: Text(
                                      "ชาย",
                                      style: TextStyle(
                                        fontSize: 14,
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
                                width: 90,
                                child: RadioListTile(
                                  contentPadding: const EdgeInsets.all(0),
                                  activeColor: AppColor.mainColor,
                                  title: const Align(
                                    alignment: Alignment((-1), 0),
                                    child: Text(
                                      "หญิง",
                                      style: TextStyle(
                                        fontSize: 14,
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
                        BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            if (state.loading == false) {
                              return Center(
                                child: SizedBox(
                                  width: 150,
                                  child: Btn(
                                    title: 'ลงทะเบียน',
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
                                              firstName: nameController.text,
                                              lastName: lastnameController.text,
                                              gender: (gender == "ชาย") ? "male" : (gender == "หญิง" ? "female" : "none"),
                                              birthDay:
                                                  "${selectedYear}-${convertMonth(selectedMon)}-${selectedDay} ${selectedHour}:${selectedMin}:00",
                                            ));
                                      } else {
                                        print("Something bug in page_form_register");
                                      }
                                    },
                                    textColor: Colors.white,
                                    bgColor: AppColor.mainColor,
                                  ),
                                ),
                              );
                            } else {
                              return SpinKitPouringHourGlassRefined(
                                color: AppColor.mainColor,
                              );
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 150,
                            child: Btn(
                              onClick: () async {
                                final prefs = await SharedPreferences.getInstance();
                                String check = prefs.getString('platformLoginCheck').toString();
                                print(check);
                                if (check == "fb") {
                                  FacebookAuth.instance.logOut();
                                }
                                if (check == "gg") {
                                  await GoogleSignInAPI.logout();
                                }

                                // await GoogleSignInAPI.logout();

                                final dio = Dio();
                                try {
                                  final response = await dio.post(
                                    "$apiPath/logout",
                                    options: Options(
                                      headers: {
                                        "Authorization": "Bearer ${prefs.getString('token')}",
                                      },
                                      contentType: 'application/json',
                                    ),
                                  );
                                  if (response.data["status"] == true) {
                                    prefs.remove("token");
                                    Navigator.pushReplacement(context, pageLogin());
                                  }
                                } on Exception catch (e) {
                                  prefs.remove("token");
                                  Navigator.pushReplacement(context, pageLogin());
                                  await GoogleSignInAPI.logout();
                                  print("Exception LogOut $e");
                                }
                              },
                              // imgOrIcon: Image.asset('assets/images/logo_google.png'),
                              title: 'ออกจากระบบ',

                              textColor: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
