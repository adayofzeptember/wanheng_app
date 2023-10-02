import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanheng_app/routes/delete_account.dart';

import '../../blocs/account/account_bloc.dart';
import '../../routes/help.dart';
import '../../routes/login.dart';
import '../../routes/terms_privacy.dart';
import '../../services/google signin/signin_method.dart';
import '../../utils/app_colors.dart';
import '../../utils/config.dart';
import '../../utils/images_path.dart';
import '../../widget/components/bg_package.dart';
import '../../widget/components/btn.dart';

// ignore: must_be_immutable
class PageSetting extends StatelessWidget {
  PageSetting({Key? key}) : super(key: key);
  TextStyle title = const TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.title,
          ),
        ),
        title: const Text(
          'ตั้งค่า',
          style: TextStyle(
            fontSize: 20,
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 132, 2, 2),
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg4),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              BgPackage(
                w: w,
                column: [
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () => Navigator.push(context, pageTerms()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ข้อตกลงให้บริการ",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.arrow_right, color: Colors.black)
                      ],
                    ),
                  ),
                  Divider(),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () => Navigator.push(context, pagePrivacy()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "นโยบายความเป็นส่วนตัว",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.arrow_right, color: Colors.black)
                      ],
                    ),
                  ),
                  Divider(),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () => Navigator.push(context, pageHelp()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ติดต่อ",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(Icons.mail, color: Colors.black)
                      ],
                    ),
                  ),
                  Divider(),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () => Navigator.push(context, pageDeleteAccount()),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ลบบัญชี",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey.shade800),
                        ),
                        Icon(Icons.delete_forever_sharp, color: Colors.grey.shade800)
                      ],
                    ),
                  ),
                  Divider(),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: Colors.white),
                    onPressed: () {
                      confirmLogOut(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ออกจากระบบ",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.red.shade900),
                        ),
                        Icon(Icons.logout, color: Colors.red.shade900)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> confirmLogOut(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ยืนยันการออกจากระบบ',
            style: title,
          ),
          content: Text(
            'คุณต้องการยืนยันการออกจากระบบใช่หรือไม่?',
            style: TextStyle(fontSize: 16),
          ),
          actions: <Widget>[
            SizedBox(
              height: 40,
              child: Btn(
                title: 'ออกจากระบบ',
                onClick: () async {
                  final prefs = await SharedPreferences.getInstance();
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
                      Purchases.logOut();
                      await FacebookAuth.instance.logOut();
                      if (GoogleSignInAPI.check() != null) {
                        await GoogleSignInAPI.logout();
                      }

                      context.read<AccountBloc>().add(ClearState());
                      prefs.remove("token");
                      prefs.remove("platformLoginCheck");
                      Navigator.pushReplacement(context, pageLogin());
                    }
                  } on Exception catch (e) {
                    context.read<AccountBloc>().add(ClearState());
                    prefs.remove("token");
                    Navigator.pushReplacement(context, pageLogin());

                    print("Exception LogOut $e");
                  }
                },
                bgColor: AppColor.grey,
                textColor: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 40,
              child: Btn(
                title: 'ยกเลิก',
                onClick: () {
                  Navigator.pop(context);
                },
                bgColor: AppColor.mainColor,
                textColor: Colors.white,
              ),
            ),
          ],
        );
      },
    );
  }
}
