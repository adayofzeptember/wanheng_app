import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanheng_app/blocs/account/account_bloc.dart';

import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';
import '../../widget/components/btn.dart';

class PagePaidSuccess extends StatelessWidget {
  const PagePaidSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg2),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Color.fromARGB(255, 243, 240, 180),
                  Color.fromARGB(255, 243, 240, 180),
                  Color.fromARGB(255, 243, 240, 180),
                  const Color.fromARGB(255, 233, 218, 84),
                  const Color.fromARGB(255, 233, 218, 84),
                  const Color.fromARGB(255, 233, 218, 84),
                ],
              ).createShader(bounds),
              child: Text(
                "ทำรายการสำเร็จ",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Image.asset(
              "assets/images/checked.png",
              width: 250,
            ),
            SizedBox(
              width: 240,
              child: Btn(
                title: "กลับหน้าหลัก",
                onClick: () => context.read<AccountBloc>().add(LoadAccount(context: context, firstLoad: true)),
                bgColor: AppColor.premium,
                textColor: AppColor.mainColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
