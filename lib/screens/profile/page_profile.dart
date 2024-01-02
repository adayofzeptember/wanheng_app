import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanheng_app/routes/profile.dart';
import 'package:wanheng_app/routes/settings.dart';
import 'package:wanheng_app/screens/calendar/page_calendar.dart';
import 'package:wanheng_app/widget/components/btn.dart';
import '../../blocs/account/account_bloc.dart';
import '../../routes/payment.dart';
import '../../utils/app_colors.dart';
import '../../utils/config.dart';
import '../../utils/images_path.dart';

// ignore: must_be_immutable
class PageProfile extends StatelessWidget {
  PageProfile({Key? key}) : super(key: key);
  TextStyle label = const TextStyle(color: Colors.grey, fontSize: 15);
  TextStyle title = const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    print("PageProfile");

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'โปรไฟล์',
            style: TextStyle(
              fontSize: 20,
              color: AppColor.title,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 132, 2, 2),
          actions: [
            IconButton(
              onPressed: () => Navigator.push(context, pageSetting()),
              icon: const Icon(
                Icons.menu,
                color: AppColor.title,
              ),
            ),
          ],
          elevation: 0,
        ),
        backgroundColor: AppColor.mainColor,
        body: Container(
          width: w,
          height: h,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.bg2),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: (state.avatar == "")
                          ? DecorationImage(image: AssetImage(AppImage.noImage), fit: BoxFit.cover)
                          : DecorationImage(image: NetworkImage("$apiPublic" + state.avatar), fit: BoxFit.cover),
                      borderRadius: const BorderRadius.all(Radius.circular(150.0)),
                      border: Border.all(
                        color: Colors.white,
                        width: 5.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: Text(
                      "${state.firstName} ${state.lastName}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (state.premium)
                    Container(
                      width: 150,
                      decoration: BoxDecoration(color: AppColor.premium, borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            AppImage.diabem,
                            width: 16,
                          ),
                          Text(
                            ' Premium member',
                            style: TextStyle(
                              fontSize: 12,
                              color: const Color.fromARGB(255, 129, 83, 26),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
                      width: w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          Text('ชื่อ-นามสกุล', style: label),
                          Text("${state.firstName} ${state.lastName}", style: title),
                          const SizedBox(height: 10),
                          Text('เพศ', style: label),
                          Text(state.gender, style: title),
                          const SizedBox(height: 10),
                          Text('วัน เดือน ปีเกิด', style: label),
                          Text("${state.birthDay} ${state.birthMonth} ${state.birthYear}", style: title),
                          const SizedBox(height: 10),
                          Text('เวลาเกิด', style: label),
                          Text('${state.brithHour} : ${state.birthMin} น.', style: title),
                          const SizedBox(height: 10),
                          Text('ธาตุประจำตัว', style: label),
                          Text(
                            '${state.element}',
                            style: TextStyle(
                              color: checkElementColorAccount(state.element),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (state.premium)
                            Text(
                              "Premium หมดอายุ " + state.expirationDate,
                              style: TextStyle(
                                color: Color.fromARGB(255, 190, 158, 43),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          const SizedBox(height: 30),
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: Btn(
                                title: 'แก้ไขโปรไฟล์',
                                onClick: () {
                                  Navigator.push(
                                      context,
                                      pageEditProfile(
                                        firstName: state.firstName,
                                        lastName: state.lastName,
                                        gender: state.gender,
                                        selectedDay: state.birthDay,
                                        selectedMon: state.birthMonth,
                                        selectedYear: state.birthYear,
                                        selectedHour: state.brithHour,
                                        selectedMin: state.birthMin,
                                      ));
                                },
                                bgColor: AppColor.mainColor,
                                textColor: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: Btn(
                                title: (state.premium) ? 'การชำระเงิน' : "การสมัครแพ็กเกจ",
                                onClick: () => Navigator.push(context, pageSettingPayment()),
                                bgColor: const Color.fromARGB(255, 215, 190, 138),
                                textColor: AppColor.mainColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
