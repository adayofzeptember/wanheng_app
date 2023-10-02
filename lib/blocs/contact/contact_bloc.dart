import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/config.dart';

part 'contact_event.dart';
part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  final dio = Dio();
  ContactBloc() : super(ContactState(loading: false)) {
    //?
    on<Send_ContactCasual>((event, emit) async {
      EasyLoading.show(maskType: EasyLoadingMaskType.black, status: 'กำลังส่ง');
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      try {
        emit(state.copyWith(loading: true));
        final response = await dio.post(apiPath + "/contact-send",
            options: Options(
              headers: {
                "Authorization": "Bearer $token",
                "Content-Type": "application/json",
                'Accept': 'application/json',
              },
            ),
            data: json.encode({
              "title": event.getTitle,
              "content": event.getContext,
            }));
        if (response.statusCode == 200) {
          EasyLoading.showSuccess('เสร็จสิ้น');
          EasyLoading.dismiss();
          print(response.data);
        } else {
          EasyLoading.showInfo("มีข้อผิดพลาดเกิดขึ้น\n${response.data}");
          EasyLoading.dismiss();
          print(response.data);
        }
      } catch (e) {
        EasyLoading.showInfo("มีข้อผิดพลาดเกิดขึ้น\n${e}");
      }
    });
  }
}
