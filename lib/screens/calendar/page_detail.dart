import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanheng_app/widget/components/card_detail.dart';

import '../../blocs/calendar/calendar_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';

class PageDetail extends StatelessWidget {
  const PageDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 2, 2),
        elevation: 0,
        title: BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            return Text(
              state.dateSelect,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColor.mainColor,
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg4),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: BlocBuilder<CalendarBloc, CalendarState>(
              builder: (context, state) {
                return (state.loading == false)
                    ? Column(
                        children: [
                          CardDetail(
                            isTop: true,
                            title: 'ราศีบน',
                            iconTitleElemment: state.predictData.top.element.element,
                            zodiac: '',
                            subtitle: state.predictData.top.interpret.title,
                            content: state.predictData.top.interpret.description,
                            person: state.predictData.top.interpret.person,
                          ),
                          CardDetail(
                            isTop: false,
                            title: 'ราศีล่าง',
                            zodiac: state.predictData.bottom.zodiac.zodiac,
                            subtitle: state.predictData.bottom.interpret.title,
                            content: state.predictData.bottom.interpret.description,
                            person: state.predictData.bottom.interpret.person,
                          ),
                        ],
                      )
                    : Center(
                        child: CupertinoActivityIndicator(
                          radius: 20.0,
                          animating: true,
                          color: Colors.white,
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
