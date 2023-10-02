import 'dart:async';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:lat_compass/lat_compass.dart';
import 'package:screenshot/screenshot.dart';
import 'package:wanheng_app/utils/app_colors.dart';

import '../../blocs/account/account_bloc.dart';
import '../../blocs/compass/compass_bloc.dart';
import '../../utils/filter_email.dart';
import '../../widget/components/predict.dart';

class PageCameraCompass extends StatefulWidget {
  // final List<CameraDescription>? cameras;

  const PageCameraCompass({Key? key}) : super(key: key);

  @override
  _PageCameraCompassState createState() => _PageCameraCompassState();
}

class _PageCameraCompassState extends State<PageCameraCompass> {
  late CameraController cameraController;
  bool isInitialized = false;

  // int _counter = 0;
  // late Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();

  Future initCamera() async {
    // print(cameraController);
    await availableCameras().then((value) async {
      cameraController = CameraController(value[0], ResolutionPreset.high);
      try {
        await cameraController.initialize().then((_) {
          if (cameraController.value.isInitialized) {
            isInitialized = true;
          }
          if (!mounted) return;
          setState(() {});
        });
      } on CameraException catch (e) {
        debugPrint("camera error $e");
      }
    });
  }

  Future capPhoto() async {
    screenshotController.capture().then((Uint8List? image) {
      //Capture Done
      imageSaved(image!);
      ShowCapturedWidget(context, image);
    }).catchError((onError) {
      print(onError);
    });
  }

  imageSaved(Uint8List image) async {
    // ignore: unused_local_variable
    final result = await ImageGallerySaver.saveImage(image);
    print("File Saved to Gallery");
  }

  Future<dynamic> ShowCapturedWidget(BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        // ignore: unnecessary_null_comparison
        body: capturedImage != null
            ? Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(color: Colors.black),
                child: Image.memory(capturedImage),
              )
            : Container(),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: FloatingActionButton(
            backgroundColor: Colors.black.withOpacity(0.8),
            onPressed: () => Navigator.pop(context),
            child: Icon(Icons.close),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    cameraController.dispose();
    _subscription?.cancel();

    super.dispose();
  }

  late AnimationController controller;
  StreamSubscription? _subscription;
  double degToRad(double value) => value * math.pi / 180;

  @override
  void initState() {
    super.initState();
    // initialize the rear camera
    Future.delayed(const Duration(seconds: 1)).then((val) {
      initCamera();
    });

    _subscription = LatCompass().stream?.listen((eventListen) {
      context.read<CompassBloc>().add(HandingCompass(handing: eventListen.magneticHeading));
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;
    double h = MediaQuery.of(context).copyWith().size.height;
    return Scaffold(
      body: isInitialized
          ? Screenshot(
              controller: screenshotController,
              child: Stack(
                children: [
                  SizedBox(
                    width: w,
                    height: h,
                    child: GestureDetector(
                      onDoubleTap: () {
                        screenshotController
                            .captureFromWidget(Container(
                                padding: const EdgeInsets.all(30.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent, width: 5.0),
                                  color: Colors.redAccent,
                                ),
                                child: Text("This is an invisible widget")))
                            .then((capturedImage) {
                          // Handle captured image
                        });
                        capPhoto();
                        print("object");
                      },
                      child: CameraPreview(cameraController),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<CompassBloc, CompassState>(
                            builder: (context, state) {
                              return Text(
                                "${state.handing.toStringAsFixed(0)}°",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          Container(
                            height: h * 0.5,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: Container(
                                    child: Image.asset(
                                      "assets/images/icons/arrow_up.png",
                                      color: AppColor.mainColor.withOpacity(0.5),
                                      width: 30,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: w * .496,
                                  top: 30,
                                  child: Container(
                                    height: h * 0.5,
                                    width: 3.5,
                                    color: AppColor.mainColor.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Wrap(children: [
                      Container(
                        margin: const EdgeInsets.all(40),
                        padding: const EdgeInsets.all(10),
                        width: w * .85,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            if (state.premium ||
                                state.email == "tangtikon@gmail.com" ||
                                checkEmailDomain(state.email, "compattana.com")) {
                              return BlocBuilder<CompassBloc, CompassState>(
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
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } else {
                              return Text(
                                "สมัครสมาชิกพรีเมียมเพื่อเข้าถึงผลลัพธ์เข็มทิศ",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            )
          : Container(
              height: h,
              width: w,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColor.mainColor,
                ),
              ),
            ),
    );
  }
}
