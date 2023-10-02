// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../blocs/account/account_bloc.dart';
import '../../routes/login.dart';
import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';
import '../../widget/components/button_form.dart';
import '../../widget/components/form.dart';

class PageEmail extends StatefulWidget {
  const PageEmail({Key? key}) : super(key: key);

  @override
  _PageEmailState createState() => _PageEmailState();
}

class _PageEmailState extends State<PageEmail> {
  var emailController = TextEditingController();
  var otpController = TextEditingController();
  TextStyle errStyle = TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 10);
  bool checkCountOtp = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
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
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg3),
            fit: BoxFit.cover,
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
                  child: BlocBuilder<AccountBloc, AccountState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'สมัครสมาชิก',
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'ลงทะเบียนระบบด้วย E-mail',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: FormCustom(
                                  controller: emailController,
                                  hint: 'Email ของคุณ',
                                  borderColor: (state.regCheckPhone == true) ? Colors.red : null,
                                  lengthLimitText: 200,
                                ),
                              ),
                              TextButton(
                                onPressed: (state.countdown > 0)
                                    ? null
                                    : () {
                                        context.read<AccountBloc>().add(RegisterEmail(email: emailController.text));
                                      },
                                style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 4), foregroundColor: AppColor.mainColor),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 70,
                                  // height: 35,
                                  child: (state.countdown > 0)
                                      ? Text(
                                          "${state.countdown}\nส่งรหัสใหม่",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12.5,
                                          ),
                                        )
                                      : Text(
                                          "ส่งOTP",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                ),
                              )
                            ],
                          ),
                          (state.regCheckEmail == true)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('รูปแบบEmail ไม่ถูกต้อง', style: errStyle),
                                )
                              : const SizedBox(height: 4),
                          FormCustom(
                            controller: otpController,
                            hint: 'รหัส OTP',
                            obscure: false,
                            lengthLimitText: 6,
                            borderColor: (state.regCheckPass == true) ? Colors.red : null,
                            onChanged: (val) {
                              if (val.length == 6) {
                                checkCountOtp = true;
                                setState(() {});
                              } else {
                                checkCountOtp = false;
                                setState(() {});
                              }
                            },
                          ),
                          (state.resCheckOTP)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('OTP ไม่ถูกต้อง', style: errStyle),
                                )
                              : const SizedBox(height: 4),
                          (state.loading)
                              ? SpinKitPouringHourGlassRefined(
                                  color: AppColor.mainColor,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ButtonForm(
                                      title: 'ย้อนกลับ',
                                      onPressed: () {
                                        Navigator.push(context, pageLogin());
                                      },
                                      background: AppColor.subBg,
                                      fontColor: AppColor.mainColor,
                                    ),
                                    if (checkCountOtp)
                                      ButtonForm(
                                        title: 'ยืนยัน',
                                        onPressed: () {
                                          context.read<AccountBloc>().add(CheckOTP(
                                                context: context,
                                                otp: otpController.text,
                                                email: emailController.text,
                                                action: "create",
                                              ));
                                        },
                                        background: AppColor.mainColor,
                                        fontColor: Colors.white,
                                      ),
                                  ],
                                ),
                          const SizedBox(height: 10),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
