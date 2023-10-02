import 'package:flutter/material.dart';
import 'package:wanheng_app/screens/compass/page_camera_compass.dart';
import 'package:wanheng_app/screens/compass/page_compass.dart';

import '../../utils/app_colors.dart';

class PageMainCompass extends StatefulWidget {
  const PageMainCompass({Key? key}) : super(key: key);

  @override
  _PageMainCompassState createState() => _PageMainCompassState();
}

class _PageMainCompassState extends State<PageMainCompass> with TickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    // setCamera();
    _tabController = TabController(length: 2, vsync: this);
  }

  // List<CameraDescription>? cameras;
  // void setCamera() async {
  //   await availableCameras().then((value) {
  //     cameras = value;
  //     setState(() {});
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).copyWith().size.width;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: AppColor.mainColor,
      ),
      body: Stack(
        children: [
          // Container(
          // child:
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: <Widget>[
              const PageCompass(),
              PageCameraCompass(),
            ],
          ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            height: 50,
            width: w,
            // color: AppColor.mainColor,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  left: 30,
                  right: 30,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        const BoxShadow(
                          color: Color.fromRGBO(195, 219, 226, 0.30),
                          offset: Offset(1, 1),
                          blurRadius: 20,
                          spreadRadius: 0,
                        ),
                      ],
                    ),
                    child: TabBar(
                      unselectedLabelColor: AppColor.mainColor,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColor.mainColor,
                      ),
                      labelColor: AppColor.title,
                      controller: _tabController,
                      onTap: (value) {
                        setState(() {});
                      },
                      tabs: <Widget>[
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "เข็มทิศ",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "กล้อง",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
