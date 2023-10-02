import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../blocs/account/account_bloc.dart';
import '../../routes/login.dart';
import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';
import '../../widget/components/form.dart';

class PageResetPassword extends StatefulWidget {
  const PageResetPassword({Key? key}) : super(key: key);

  @override
  _PageResetPasswordState createState() => _PageResetPasswordState();
}

class _PageResetPasswordState extends State<PageResetPassword> {
  var passwordController = TextEditingController();
  var cmPasswordController = TextEditingController();
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
                              'สร้างรหัสผ่านใหม่',
                              style: TextStyle(
                                fontSize: 24,
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FormCustom(
                            controller: passwordController,
                            hint: 'รหัสผ่าน',
                            obscure: true,
                            borderColor: (state.regCheckPass == true) ? Colors.red : null,
                          ),
                          (state.regCheckPass == true)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(' *รหัสผ่านไม่น้อยกว่า 8 ตัวอักษร', style: errStyle),
                                )
                              : const SizedBox(height: 4),
                          FormCustom(
                            controller: cmPasswordController,
                            hint: 'ยืนยันรหัสผ่าน',
                            obscure: true,
                            borderColor: (state.regPassMatch == true) ? Colors.red : null,
                          ),
                          (state.regPassMatch == true)
                              ? Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text(' *รหัสผ่านไม่ตรงกัน', style: errStyle),
                                )
                              : const SizedBox(height: 8),
                          (state.loading == true)
                              ? SpinKitPouringHourGlassRefined(
                                  color: AppColor.mainColor,
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                            )),
                                      ),
                                      onPressed: () {
                                        Navigator.push(context, pageLogin());
                                      },
                                      child: const Text(
                                        'ย้อนกลับ',
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
                                        context.read<AccountBloc>().add(ResetPassword(
                                              context: context,
                                              password: passwordController.text,
                                              cmPassword: cmPasswordController.text,
                                            ));
                                      },
                                      child: const Text(
                                        'ยืนยัน',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.white,
                                        ),
                                      ),
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
