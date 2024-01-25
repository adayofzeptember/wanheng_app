import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:wanheng_app/blocs/calendar/calendar_bloc.dart';
import 'package:wanheng_app/routes/calendar.dart';
import 'package:wanheng_app/routes/payment.dart';
import 'package:wanheng_app/screens/calendar/month_coverter.dart';
import '../../blocs/account/account_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/config.dart';
import '../../utils/images_path.dart';

class PageCalendar extends StatelessWidget {
  const PageCalendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CalendarBloc>().add(GetTodayNumber());
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.mainColor,
        elevation: 0,
        title: const Text(
          'ปฏิทินฮวงจุ้ย',
          style: TextStyle(
            fontSize: 20,
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColor.mainColor,
      body: WillPopScope(
        onWillPop: () async {
          return false;
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
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              // height: 500,
              width: w,
              decoration: const BoxDecoration(
                color: AppColor.mainColor,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 228, 225, 225),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                      height: 100,
                      child: BlocBuilder<AccountBloc, AccountState>(
                        builder: (context, state) {
                     
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 70.0,
                                    height: 70.0,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: (state.avatar == "")
                                          ? DecorationImage(
                                              image:
                                                  AssetImage(AppImage.noImage),
                                              fit: BoxFit.cover)
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  "$apiPublic" + state.avatar),
                                              fit: BoxFit.cover),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(150.0)),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 2.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: w * 0.4,
                                        // color: Colors.amber,
                                        child: Text(
                                          "${state.firstName} ${state.lastName}",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(height: 3),
                                      if (state.premium)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColor.premium,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              12, 2, 12, 2),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AppImage.diabem,
                                                width: 16,
                                              ),
                                              const Text(
                                                ' Premium member',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: const Color.fromARGB(
                                                      255, 129, 83, 26),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      else
                                        Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              8, 0, 8, 0),
                                          decoration: BoxDecoration(
                                            color: const Color.fromARGB(
                                                255, 215, 190, 138),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.push(context,
                                                  pageSettingPayment());
                                            },
                                            child: Text(
                                              "การสมัครแพ็กเกจ",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: AppColor.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                width: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(60),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 209, 180, 132),
                                      width: 3.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: checkElementAccount(state.element),
                                    ),
                                    Text(
                                      state.element,
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: checkElementColorAccount(
                                            state.element),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            offset: Offset(0, -2),
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Color.fromRGBO(0, 0, 0, 0.17),
                          )
                        ],
                      ),
                      child: SizedBox(
                        height: 400,
                        child: BlocBuilder<AccountBloc, AccountState>(
                          builder: (context, state) {
                            return TableCalendar(
                              shouldFillViewport: true,
                              firstDay: DateTime.utc(2010, 10, 16),
                              lastDay: DateTime.utc(2030, 3, 14),
                              focusedDay: DateTime.now(),
                              headerVisible: true,
                              daysOfWeekVisible: true,
                              sixWeekMonthsEnforced: true,
                              onDaySelected: (daySelect, dayFocus) {
                                String month = (daySelect.month < 10)
                                    ? "0${daySelect.month}"
                                    : "${daySelect.month}";
                                String day = (daySelect.day < 10)
                                    ? "0${daySelect.day}"
                                    : "${daySelect.day}";
                                var formatterDate = DateFormat.yMMMMEEEEd();
                                print(monthCovertoThai(month));
                                if (state.premium == false) {
                                  final now = DateTime.now();
                                  final today = DateTime(
                                      now.year, now.month, now.day + 6);
                                  final backday = DateTime(
                                      now.year, now.month, now.day - 6);
                                  final checkDate = DateTime(daySelect.year,
                                      daySelect.month, daySelect.day);
                                  if (today.compareTo(checkDate) < 0 ||
                                      backday.compareTo(checkDate) > 0) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'สำหรับแพ็คเกจ Premium',
                                            style: TextStyle(
                                                color: AppColor.mainColor),
                                          ),
                                          content: Text(
                                              'สมัครแพ็คเกจ Premium เพื่อดูฮวงจุ้ยที่นานกว่า 1 สัปดาห์ขึ้นไป'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text(
                                                'ปิด',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => Navigator.push(
                                                  context,
                                                  pageSettingPayment()),
                                              child: Text(
                                                'การสมัครแพ็กเกจ',
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 246, 193, 0)),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    context.read<CalendarBloc>().add(SelectDate(
                                          premiumCheck: state.premium,
                                          yearMonth:
                                              "${daySelect.year}-$month-",
                                          day: "${daySelect.day}",
                                          date: "${daySelect.year}-$month-$day",
                                          strDate:
                                              formatterDate.format(daySelect),
                                        ));
                                    Navigator.push(context, pageDetail());
                                  }
                                } else {
                                  context.read<CalendarBloc>().add(SelectDate(
                                        premiumCheck: state.premium,
                                        yearMonth: "${daySelect.year}-$month-",
                                        day: "${daySelect.day}",
                                        date: "${daySelect.year}-$month-$day",
                                        strDate:
                                            formatterDate.format(daySelect),
                                      ));
                                  Navigator.push(context, pageDetail());
                                }
                              },
                              headerStyle: HeaderStyle(
                                  formatButtonVisible: false,
                                  titleCentered: true),
                              calendarStyle: CalendarStyle(
                                markerDecoration: const BoxDecoration(
                                  color: Color.fromARGB(182, 124, 2, 2),
                                ),
                                todayDecoration: BoxDecoration(
                                  color: AppColor.mainColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Image checkElementAccount(String element) {
  return Image.asset(
    (element == "ธาตุไฟหยาง")
        ? AppImage.fire0
        : (element == "ธาตุน้ำหยาง")
            ? AppImage.water0
            : (element == "ธาตุดินหยาง")
                ? AppImage.soli0
                : (element == "ธาตุทองหยาง")
                    ? AppImage.gold0
                    : (element == "ธาตุไม้หยาง")
                        ? AppImage.wood0
                        : (element == "ธาตุไฟหยิน")
                            ? AppImage.fire1
                            : (element == "ธาตุน้ำหยิน")
                                ? AppImage.water1
                                : (element == "ธาตุดินหยิน")
                                    ? AppImage.soli1
                                    : (element == "ธาตุทองหยิน")
                                        ? AppImage.gold1
                                        : AppImage.wood1,
    fit: BoxFit.contain,
    color: checkElementColorAccount(element),
  );
}

checkElementColorAccount(String element) {
  return (element == "ธาตุไฟหยาง")
      ? AppColor.fire0
      : (element == "ธาตุน้ำหยาง")
          ? AppColor.water0
          : (element == "ธาตุดินหยาง")
              ? AppColor.soli0
              : (element == "ธาตุทองหยาง")
                  ? AppColor.gold0
                  : (element == "ธาตุไม้หยาง")
                      ? AppColor.wood0
                      : (element == "ธาตุไฟหยิน")
                          ? AppColor.fire1
                          : (element == "ธาตุน้ำหยิน")
                              ? AppColor.water1
                              : (element == "ธาตุดินหยิน")
                                  ? AppColor.soli1
                                  : (element == "ธาตุทองหยิน")
                                      ? AppColor.gold1
                                      : AppColor.wood1;
}
