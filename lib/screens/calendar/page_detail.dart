import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wanheng_app/routes/payment.dart';
import 'package:wanheng_app/widget/components/card_detail.dart';
import '../../blocs/calendar/calendar_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';

class PageDetail extends StatefulWidget {
  const PageDetail({Key? key}) : super(key: key);

  @override
  State<PageDetail> createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  @override
  void initState() {
    context.read<CalendarBloc>().add(GetTodayNumber());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return BlocBuilder<CalendarBloc, CalendarState>(
      builder: (context, state) {
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
          
         
            leading: 
            IconButton(
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
          body: GestureDetector(
            onHorizontalDragEnd: (details) {
              // Swiping in right direction.
              if (details.primaryVelocity! > 0) {
                  int dayMinus = int.parse(state.dayOnly) - 1;
                String resultDay =
                    (dayMinus < 10) ? "0${dayMinus}" : dayMinus.toString();

                String finalNewDate = state.yearMonthOnly + resultDay;

                DateTime parsedNewDate =
                    DateFormat('yyyy-MM-dd').parse(finalNewDate);
                //*
                List<String> check1Bloc =
                    state.yearMonthOnly.toString().split('-');
                List<String> check2NewMonth =
                    parsedNewDate.toString().split('-');
                var formatterDate = DateFormat.yMMMMEEEEd();

                if (check1Bloc[1] == check2NewMonth[1]) {
                  if (state.premium) {
                    context.read<CalendarBloc>().add(SelectDate(
                          day: dayMinus.toString(),
                          yearMonth: state.yearMonthOnly,
                          date: finalNewDate,
                          strDate: formatterDate.format(parsedNewDate),
                        ));
                  } else {
                    if (int.parse(state.dayOnly) > state.dayPremiumCheckMinus) {
                      context.read<CalendarBloc>().add(SelectDate(
                            day: dayMinus.toString(),
                            yearMonth: state.yearMonthOnly,
                            date: finalNewDate,
                            strDate: formatterDate.format(parsedNewDate),
                          ));
                    } else {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'สำหรับแพ็คเกจ Premium',
                              style: TextStyle(color: AppColor.mainColor),
                            ),
                            content: Text(
                                'สมัครแพ็คเกจ Premium เพื่อดูฮวงจุ้ยที่นานกว่า 1 สัปดาห์ขึ้นไป'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'ปิด',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.push(
                                    context, pageSettingPayment()),
                                child: Text(
                                  'การสมัครแพ็กเกจ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 246, 193, 0)),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  }
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'คุณถึงจุดสุดเดือนนี้แล้ว',
                          style: TextStyle(color: AppColor.mainColor),
                        ),
                        content: Text('โปรดเลือกเดือนใหม่ที่หน้าปฏิทิน'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'ปิด',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }

              // Swiping in left direction.
              if (details.primaryVelocity! < 0) {
                   int dayPlus = int.parse(state.dayOnly) + 1;
                  String resultDay =
                      (dayPlus < 10) ? "0${dayPlus}" : dayPlus.toString();

                  String finalNewDate = state.yearMonthOnly + resultDay;

                  DateTime parsedNewDate =
                      DateFormat('yyyy-MM-dd').parse(finalNewDate);

                  var formatterDate = DateFormat.yMMMMEEEEd();

                  List<String> check1Bloc =
                      state.yearMonthOnly.toString().split('-');
                  List<String> check2NewMonth =
                      parsedNewDate.toString().split('-');

                  if (check1Bloc[1] == check2NewMonth[1]) {
                    if (state.premium) {
                      context.read<CalendarBloc>().add(SelectDate(
                            day: dayPlus.toString(),
                            yearMonth: state.yearMonthOnly,
                            date: finalNewDate,
                            strDate: formatterDate.format(parsedNewDate),
                          ));
                    } else {
                      if (int.parse(state.dayOnly) <
                          state.dayPremiumCheckPlus) {
                        context.read<CalendarBloc>().add(SelectDate(
                              day: dayPlus.toString(),
                              yearMonth: state.yearMonthOnly,
                              date: finalNewDate,
                              strDate: formatterDate.format(parsedNewDate),
                            ));
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                'สำหรับแพ็คเกจ Premium',
                                style: TextStyle(color: AppColor.mainColor),
                              ),
                              content: Text(
                                  'สมัครแพ็คเกจ Premium เพื่อดูฮวงจุ้ยที่นานกว่า 1 สัปดาห์ขึ้นไป'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text(
                                    'ปิด',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.push(
                                      context, pageSettingPayment()),
                                  child: Text(
                                    'การสมัครแพ็กเกจ',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 246, 193, 0)),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'คุณถึงจุดสุดเดือนนี้แล้ว',
                            style: TextStyle(color: AppColor.mainColor),
                          ),
                          content: Text('โปรดเลือกเดือนใหม่ที่หน้าปฏิทิน'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text(
                                'ปิด',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }
              }
            },
            child: Container(
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
                  child: (state.loading == false)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          
                            CardDetail(
                              isTop: true,
                              title: 'ราศีบน',
                              iconTitleElemment:
                                  state.predictData.top.element.element,
                              zodiac: '',
                              subtitle: state.predictData.top.interpret.title,
                              content:
                                  state.predictData.top.interpret.description,
                              person: state.predictData.top.interpret.person,
                            ),
                            CardDetail(
                              isTop: false,
                              title: 'ราศีล่าง',
                              zodiac: state.predictData.bottom.zodiac.zodiac,
                              subtitle:
                                  state.predictData.bottom.interpret.title,
                              content: state
                                  .predictData.bottom.interpret.description,
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
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
