// ignore_for_file: must_be_immutable
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lat_compass/lat_compass.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:wanheng_app/screens/compass/tween.dart';
import 'package:wanheng_app/utils/app_colors.dart';
import 'package:wanheng_app/utils/images_path.dart';
import 'package:wanheng_app/widget/components/btn.dart';
import '../../blocs/account/account_bloc.dart';
import '../../blocs/compass/compass_bloc.dart';
import '../../routes/payment.dart';
import '../../utils/filter_email.dart';
import '../../widget/components/predict.dart';

class PageCompass extends StatefulWidget {
  const PageCompass({super.key});

  @override
  State<PageCompass> createState() => _PageCompassState();
}

class _PageCompassState extends State<PageCompass> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  late TweenRotationDegree tween;
  double _radian = 0;
  StreamSubscription? _subscription;
  CompassEvent? _compassEvent;
  double degToRad(double value) => value * math.pi / 180;
  @override
  void initState() {
    super.initState();
    // _checkGyroscopeStatus();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    tween = TweenRotationDegree(begin: 0, end: 0);
    controller.addListener(() {
      final value = tween.evaluate(animation);
      _radian = degToRad(value) * -1;
      context.read<CompassBloc>().add(RadianCompass(radian: _radian));
    });
    _subscription = LatCompass().stream?.listen((eventListen) {
      if (Platform.isIOS) {
        _radian = degToRad(eventListen.magneticHeading % 360) * -1;
        context.read<CompassBloc>().add(RadianCompass(radian: _radian));
      } else {
        // animation for android
        tween = TweenRotationDegree(
          begin: (_compassEvent?.magneticHeading ?? 0) % 360,
          end: eventListen.magneticHeading % 360,
        );
        controller
          ..reset()
          ..forward();
      }
      _compassEvent = eventListen;

      context.read<CompassBloc>().add(HandingCompass(handing: eventListen.magneticHeading));
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColor.mainColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 38),
          width: w,
          height: h,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImage.bg1),
              fit: BoxFit.fill,
            ),
          ),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              if (state.premium || state.email == "tangtikon@gmail.com" || checkEmailDomain(state.email, "compattana.com")) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // const Text(
                    //   'เข็มทิศ',
                    //   style: TextStyle(
                    //     fontSize: 25,
                    //     color: AppColor.title,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 430,
                      width: 370, //ปรับให้ตรงกับค่า left เข็มทิศ
                      child: BlocBuilder<CompassBloc, CompassState>(
                        builder: (context, state) {
                          return Stack(
                            children: [
                              Transform.rotate(
                                angle: state.radian,
                                child: Image.asset(
                                  'assets/images/bgcompass.png',
                                  height: 430,
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: (370 / 2) - 10,
                                child: Image.asset(
                                  'assets/images/arrow.png',
                                  height: 220,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      // height: 200,
                      width: w * .85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: BlocBuilder<CompassBloc, CompassState>(
                        builder: (context, state) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Predict(handing: state.handing),
                              Text(
                                (state.handing <= 20)
                                    ? 'ทิศเหนือ' //N
                                    : (state.handing <= 70)
                                        ? 'ทิศตะวันออกเฉียงเหนือ' //'NE'
                                        : (state.handing <= 110) //* 90
                                            ? 'ทิศตะวันออก' //'E'
                                            : (state.handing <= 160)
                                                ? 'ตะวันออกเฉียงใต้' //'SE'
                                                : (state.handing <= 200)
                                                    ? 'ทิศใต้' //'S'
                                                    : (state.handing <= 250)
                                                        ? 'ทิศตะวันตกเฉียงใต้' //'SW'
                                                        : (state.handing <= 290)
                                                            ? 'ทิศตะวันตก' //'W'
                                                            : (state.handing <= 340)
                                                                ? 'ทิศตะวันตกเฉียงเหนือ' //'NW'
                                                                : 'ทิศเหนือ', //'N',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Text(
                                "${state.handing.toStringAsFixed(2)}° ",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container(
                  width: w,
                  height: h,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(AppImage.bg1),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "สมัครสมาชิกพรีเมียมเพื่อเข้าถึงเข็มทิศ",
                        style: TextStyle(
                          color: AppColor.title,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 200,
                        child: Btn(
                          bgColor: AppColor.premium,
                          textColor: AppColor.mainColor,
                          fontWeight: FontWeight.bold,
                          title: "สมัครพรีเมียม",
                          onClick: () => Navigator.push(context, pageSettingPayment()),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
