import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanheng_app/models/calendar_model.dart';

import '../../utils/config.dart';

part 'calendar_event.dart';
part 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  CalendarBloc()
      : super(CalendarState(
          dayPremiumCheckPlus: 0,
          dayPremiumCheckMinus: 0,
          yearMonthOnly: '',
          dayOnly: "",
          loading: false,
          predictData: {},
          dateSelect: "",
        )) {
    on<SelectDate>((event, emit) async {
      emit(state.copyWith(
          loading: true,
          dateSelect: event.strDate,
          dayOnly: event.day,
          yearMonthOnly: event.yearMonth));

      // print('date in bloc: ' +  state.yearMonthOnly+ state.dayOnly);
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      try {
        final dio = Dio();
        final response = await dio.get(
          "$apiPath/predict-calendar/${event.date}",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: 'application/json',
          ),
        );
        if (response.data["status"] == true) {
          CalendarPredict setData = CalendarPredict(
            statusUser: StatusUser(
              status: response.data["data"]["status_user"]["status"],
              title: response.data["data"]["status_user"]["title"],
            ),
            top: Top(
              element: ElementTop(
                key: response.data["data"]["top"]["element"]["key"],
                china: response.data["data"]["top"]["element"]["china"],
                zodiac: "",
                elementEn: response.data["data"]["top"]["element"]
                    ["element_en"],
                element: response.data["data"]["top"]["element"]["element"],
                attribute: response.data["data"]["top"]["element"]["attribute"],
              ),
              interpret: InterpretTop(
                key: response.data["data"]["top"]["interpret"]["key"],
                title: response.data["data"]["top"]["interpret"]["title"],
                description: response.data["data"]["top"]["interpret"]
                    ["description"],
                person: response.data["data"]["top"]["interpret"]["person"],
              ),
            ),
            bottom: Bottom(
              zodiac: ZodiacBottom(
                key: response.data["data"]["bottom"]["zodiac"]["key"],
                china: response.data["data"]["bottom"]["zodiac"]["china"],
                zodiac: response.data["data"]["bottom"]["zodiac"]["zodiac"],
                elementEn: response.data["data"]["bottom"]["zodiac"]
                    ["element_en"],
                element: response.data["data"]["bottom"]["zodiac"]["element"],
                attribute: response.data["data"]["bottom"]["zodiac"]
                    ["attribute"],
              ),
              interpret: InterpretBottom(
                key: response.data["data"]["bottom"]["interpret"]["key"],
                title: response.data["data"]["bottom"]["interpret"]["title"],
                description: response.data["data"]["bottom"]["interpret"]
                    ["description"],
                person: response.data["data"]["bottom"]["interpret"]["person"],
              ),
            ),
          );
          //print(setData.top.element.element);
          emit(state.copyWith(predictData: setData, loading: false));
        }
      } on Exception catch (e) {
        EasyLoading.showToast('มีบางอย่างผิดพลาด');
        print("Exception $e");
      }
    });

    //?
    on<GetTodayNumber>((event, emit) {
      final now = DateTime.now();
      emit(state.copyWith(dayPremiumCheckPlus: now.day + 6));
      emit(state.copyWith(dayPremiumCheckMinus: now.day - 6));
      
    });
  }
}
