import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class PageFixing extends StatelessWidget {
  const PageFixing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: AppColor.mainColor,
      ),
      body: Center(
        child: Text("กำลังปรับปรุงบริการ"),
      ),
    );
  }
}
