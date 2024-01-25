import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanheng_app/blocs/account/account_bloc.dart';
import 'package:wanheng_app/routes/login.dart';
import 'package:wanheng_app/routes/register.dart';
import 'package:wanheng_app/services/google%20signin/signin_method.dart';
import 'package:wanheng_app/utils/app_colors.dart';
import 'package:wanheng_app/utils/images_path.dart';
import 'package:wanheng_app/widget/components/form.dart';
import '../../widget/components/alert_err_login.dart';
import '../../widget/components/btn.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class PageLogin extends StatefulWidget {
  const PageLogin({Key? key}) : super(key: key);

  @override
  State<PageLogin> createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  // var phoneController = TextEditingController(text: "tangtikon.intisan@compattana.com");
  // var passwordController = TextEditingController(text: "11111111");
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool keyboardVisible = false;
  bool dev = true;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    // keyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: AppColor.mainColor,
            elevation: 0,
          ),
        ),
        backgroundColor: AppColor.mainColor,
        body: Container(
          width: w,
          height: h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.bg3),
              fit: BoxFit
                  .cover, //(!keyboardVisible) ? BoxFit.fill : BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
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
                    padding: const EdgeInsets.all(35),
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
                            'เข้าสู่ระบบ',
                            style: TextStyle(
                              fontSize: 24,
                              color: AppColor.mainColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'เข้าสู่ระบบด้วยอีเมล',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FormCustom(
                          controller: phoneController,
                          hint: 'อีเมลของคุณ',
                          lengthLimitText: 200,
                        ),
                        const SizedBox(height: 4),
                        FormCustom(
                          controller: passwordController,
                          hint: 'รหัสผ่าน',
                          obscure: true,
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Navigator.push(context, pageForgot()),
                            child: Text(
                              "ลืมรหัสผ่าน",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            return (state.invalid == true)
                                ? Center(child: AlertErrorLogin())
                                : const SizedBox(height: 4);
                          },
                        ),
                        const SizedBox(height: 6),
                        BlocBuilder<AccountBloc, AccountState>(
                            builder: (context, state) {
                          if (state.loading == false) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(110, 43),
                                    backgroundColor: AppColor.subBg,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: const BorderSide(
                                        width: 2.0,
                                        color: AppColor.mainColor,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context, pageTermsAndCondition());
                                  },
                                  child: const Text(
                                    'สมัครสมาชิก',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: AppColor.mainColor,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(110, 43),
                                    backgroundColor: AppColor.mainColor,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                          width: 2.0,
                                          color: AppColor.mainColor,
                                        )),
                                  ),
                                  onPressed: () {
                                    if (dev == true) {
                                      phoneController.text =
                                          "chawanthon.wirajarnyaphan@compattana.com";
                                      passwordController.text =
                                          "Zeptember1997.";
                                    }
                                    // Navigator.push(context, pageOtpLogin());
                                    context.read<AccountBloc>().add(LoginCheck(
                                          context: context,
                                          phone: phoneController.text,
                                          password: passwordController.text,
                                        ));
                                  },
                                  child: const Text(
                                    'ต่อไป',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.normal,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SpinKitPouringHourGlassRefined(
                              color: AppColor.mainColor,
                            );
                          }
                        }),
                        if (Platform.isAndroid)
                          Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                width: w,
                                child: Row(children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 10.0, right: 20.0),
                                        child: const Divider(
                                          color: Colors.black,
                                          height: 36,
                                        )),
                                  ),
                                  const Center(
                                    child: Text(
                                      'หรือ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 20.0, right: 10.0),
                                        child: const Divider(
                                          color: Colors.black,
                                          height: 36,
                                        )),
                                  ),
                                ]),
                              ),
                              const SizedBox(height: 10),
                              if (Platform.isAndroid)
                                Btn(
                                  onClick: () {
                                    _googleSignInFunction(context);
                                  },
                                  imgOrIcon: Image.asset(
                                      'assets/images/logo_google.png'),
                                  title: 'เข้าสู่ระบบด้วย Google',
                                  textColor: Colors.black,
                                )
                              else
                                Btn(
                                  onClick: () async {
                                    EasyLoading.show(
                                        maskType: EasyLoadingMaskType.black,
                                        status: 'กำลังโหลด');
                                    try {
                                      final credential = await SignInWithApple
                                          .getAppleIDCredential(
                                        scopes: [
                                          AppleIDAuthorizationScopes.email,
                                          AppleIDAuthorizationScopes.fullName,
                                        ],
                                      );
                                      print(credential.state);

                                      Map<String, dynamic> user =
                                          JwtDecoder.decode(
                                              "${credential.identityToken}");
                                      context.read<AccountBloc>().add(
                                          LoginWithSocial(
                                              context: context,
                                              getGoogleEmail: user["email"],
                                              getGoogleImg: ""));
                                    } catch (e) {
                                      print(e);
                                      EasyLoading.dismiss();
                                    }
                                  },
                                  imgOrIcon:
                                      Icon(Icons.apple, color: Colors.black),
                                  title: 'เข้าสู่ระบบด้วย Apple',
                                  textColor: Colors.black,
                                ),
                              const SizedBox(height: 3),
                              Btn(
                                onClick: () {
                                  useFacebook_toLogin();
                                },
                                imgOrIcon: Icon(
                                  Icons.facebook_outlined,
                                  color: Colors.blue,
                                ),
                                title: 'เข้าสู่ระบบด้วย Facebook',
                                textColor: Colors.black,
                              ),
                            ],
                          )
                        else
                          Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//! Login variation
  Future useFacebook_toLogin() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      await FacebookAuth.instance
          .login(permissions: ["public_profile", "email"]).then((value) {
        FacebookAuth.instance.getUserData().then((userDataFacebook) {
          print("------------facebook account------------");
          EasyLoading.show(
              maskType: EasyLoadingMaskType.black, status: 'กำลังโหลด');
          // EasyLoading.showToast(userDataFacebook["email"]);
          print(userDataFacebook["name"]);
          print(userDataFacebook["email"]);
          print(userDataFacebook["picture"]["data"]["url"]);
          prefs.setString('platformLoginCheck', 'fb');
          _loadBloc(userDataFacebook["email"].toString(),
              userDataFacebook["picture"]["data"]["url"].toString(), "fb");
        });
      });
    } catch (e) {
      EasyLoading.showToast(e.toString());
    }
  }

  Future _googleSignInFunction(context) async {
    final prefs = await SharedPreferences.getInstance();
    if (Platform.isAndroid) {
      GoogleSignInAPI.login().then((result) {
        result!.authentication.then((googleKey) {
          EasyLoading.show(
              maskType: EasyLoadingMaskType.black, status: 'กำลังโหลด');

          // EasyLoading.showToast(result.email.toString());
          print("------------google account--------------");
          print(result.email.toString());
          print(result.displayName.toString());
          prefs.setString('platformLoginCheck', 'gg');
          _loadBloc(result.email.toString(), result.photoUrl.toString(), "gg");
        }).catchError((error1) {
          EasyLoading.showInfo(error1.toString());
        });
      });
    } else {
      print("IOS");
    }
  }

  void _loadBloc(String mail, img, check) {
    context.read<AccountBloc>().add(LoginWithSocial(
        context: context,
        getGoogleEmail: mail.toString(),
        getGoogleImg: img.toString()));
  }
}
