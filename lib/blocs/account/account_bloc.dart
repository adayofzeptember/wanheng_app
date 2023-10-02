// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanheng_app/routes/navigatorbar.dart';
import 'package:wanheng_app/routes/register.dart';

import '../../routes/login.dart';
import '../../utils/config.dart';
import '../../utils/filter_email.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc()
      : super(AccountState(
          email: "",
          userId: 0,
          phone: "",
          avatar: "",
          firstName: "",
          lastName: "",
          gender: "",
          birthDay: "",
          birthMonth: "",
          birthYear: "",
          brithHour: "",
          birthMin: "",
          invalid: false,
          loading: false,
          regPassMatch: false,
          regCheckPass: false,
          regCheckPhone: false,
          element: "",
          regCheckEmail: false,
          resCheckOTP: false,
          countdown: 0,
          premium: false,
          expirationDate: "",
          isTesting: false,
        )) {
    on<ClearState>((event, emit) {
      emit(state.copyWith(
        email: "",
        userId: 0,
        phone: "",
        avatar: "",
        firstName: "",
        lastName: "",
        gender: "",
        birthDay: "",
        birthMonth: "",
        birthYear: "",
        brithHour: "",
        birthMin: "",
        invalid: false,
        loading: false,
        regPassMatch: false,
        regCheckPass: false,
        regCheckPhone: false,
        element: "",
        regCheckEmail: false,
        resCheckOTP: false,
        countdown: 0,
        premium: false,
        expirationDate: "",
        isTesting: false,
      ));
    });

    on<LoadAccount>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      if (token == null) {
        EasyLoading.dismiss();
        Navigator.pushReplacement(event.context, pageLogin());
      } else {
        EasyLoading.dismiss();
        final dio = Dio();
        try {
          final response = await dio.get(
            "$apiPath/user",
            options: Options(
              headers: {
                "Authorization": "Bearer $token",
              },
              contentType: 'application/json',
            ),
          );
          if (response.data["status"] == true) {
            EasyLoading.dismiss();
            emit(state.copyWith(userId: response.data["data"]["id"]));
            if (response.data["data"]["profile"] == null || response.data["data"]["profile"]["first_name"] == null) {
              emit(state.copyWith(email: response.data["data"]["email"]));
              Navigator.pushReplacement(event.context, pageFormRegister());
            } else {
              LogInResult result = await Purchases.logIn("\$email:${response.data["data"]["email"]}");
              Purchases.setEmail("${response.data["data"]["email"]}");
              try {
                CustomerInfo customerInfo = await Purchases.getCustomerInfo();
                if (customerInfo.entitlements.active.isNotEmpty) {
                  // Grant user "pro" access
                  print(customerInfo.originalAppUserId);
                  print(customerInfo.activeSubscriptions);
                  for (final mapEntry in customerInfo.entitlements.active.entries) {
                    final key = mapEntry.key;
                    final value = mapEntry.value;
                    print('Key: $key, Value: ${value.isActive}'); // Key: a, Value: 1 ...
                    print(value.productIdentifier);
                    print(value);
                    emit(state.copyWith(
                      premium: value.isActive,
                      expirationDate: DateFormat.yMMMMd().format(DateTime.parse("${value.expirationDate}").toLocal()) +
                          " " +
                          DateFormat.Hm().format(DateTime.parse("${value.expirationDate}").toLocal()),
                    ));
                  }
                } else {
                  print("no premium");
                }
              } on PlatformException catch (e) {
                EasyLoading.showInfo("มีข้อผิดพลาดเกิดขึ้น\n${e.message}");
              }

              List birthDate =
                  DateFormat.yMMMMd().format(DateTime.parse(response.data["data"]["profile"]["birthday"])).toString().split(" ");
              List birthTime =
                  DateFormat.Hms().format(DateTime.parse(response.data["data"]["profile"]["birthday"])).toString().split(":");
              String gender = (response.data["data"]["profile"]["gender"] == "male")
                  ? "ชาย"
                  : (response.data["data"]["profile"]["gender"] == "female")
                      ? "หญิง"
                      : "ไม่ระบุ";
              //เช็คว่าเป็นเมลของ compattana ถ้าเป็นจะแสดงสินค้าสำหรับทดสอบ
              bool isEmailInDesiredDomain = checkEmailDomain(response.data["data"]["email"], "compattana.com");
              emit(state.copyWith(
                email: response.data["data"]["email"],
                phone: response.data["data"]["phone_number"],
                firstName: response.data["data"]["profile"]["first_name"],
                lastName: response.data["data"]["profile"]["last_name"],
                gender: gender,
                birthDay: birthDate[0],
                birthMonth: birthDate[1],
                birthYear: birthDate[2],
                brithHour: birthTime[0],
                birthMin: birthTime[1],
                avatar: response.data["data"]["profile"]["avatar"],
                element: response.data["data"]["profile"]["element"]["element"],
                isTesting: isEmailInDesiredDomain,
              ));

              if (event.firstLoad) {
                Navigator.pushReplacement(event.context, pageNavigatorBar(0));
              } else {
                // Navigator.pushReplacement(event.context, pageProfile());
                Navigator.pushReplacement(event.context, pageNavigatorBar(2));
              }
            }
          } else {
            print(response.data);
            EasyLoading.showToast('มีข้อผิดพลาด\n${response.statusCode}');
          }
        } on Exception catch (e) {
          print("x");
          prefs.remove("token");
          EasyLoading.showToast('เซสชั่นหมดอายุ\n$e');
          print("Exception ${e}");

          Navigator.push(event.context, pageLogin());
        }
      }
    });

    on<LoginCheck>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      emit(state.copyWith(loading: true, invalid: false));

      final dio = Dio();
      try {
        final response = await dio.post(
          "$apiPath/login",
          options: Options(
            contentType: 'application/json',
          ),
          data: {'email': event.phone, 'password': event.password},
        );
        if (response.data["status"] == true) {
          print(response.data);
          prefs.setString('token', response.data["api_token"]);
          emit(state.copyWith(invalid: false, loading: false));
          add(LoadAccount(context: event.context, firstLoad: true));
        } else {
          print(response.data);
          emit(state.copyWith(invalid: true, loading: false));
          print("err");
        }
      } on Exception catch (e) {
        emit(state.copyWith(invalid: true, loading: false));
        print("Exception LoginCheck $e");
      }
    });

    on<Register>((event, emit) async {
      final dio = Dio();
      if (event.password.length < 8) {
        emit(state.copyWith(regCheckPass: true));
      } else {
        emit(state.copyWith(regCheckPass: false));
      }
      if (event.password != event.cmPassword) {
        emit(state.copyWith(regPassMatch: true));
      } else {
        emit(state.copyWith(regPassMatch: false));
      }
      // if (event.phone.length != 10) {
      //   emit(state.copyWith(regCheckPhone: true));
      // } else {
      //   emit(state.copyWith(regCheckPhone: false));
      // }
      if (state.regCheckPhone == false && state.regCheckPass == false && state.regPassMatch == false) {
        emit(state.copyWith(loading: true));
        try {
          final response = await dio.post(
            "$apiPath/register",
            options: Options(
              contentType: 'application/json',
              responseType: ResponseType.json,
              followRedirects: false,
              validateStatus: (_) => true,
            ),
            data: {
              "email": state.email,
              "password": event.password,
            },
          );
          if (response.data["status"] == true) {
            final prefs = await SharedPreferences.getInstance();
            prefs.setString('token', response.data["api_token"]);
            emit(state.copyWith(loading: false));
            add(LoadAccount(context: event.context, firstLoad: false));
            // Navigator.push(event.context, pageFormRegister());
          } else {
            EasyLoading.showToast('ผู้ใช้นี้มีอยู่แล้ว\n');
            emit(state.copyWith(loading: false));
          }
        } on Exception catch (e) {
          EasyLoading.showToast('Something went wrong! \n$e');
          print("Exception $e");
          emit(state.copyWith(loading: false));
        }
      } else {
        EasyLoading.showToast('Something went wrong!');
        print("err");
        emit(state.copyWith(loading: false));
      }
    });

    on<UserCreate>((event, emit) async {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      emit(state.copyWith(loading: true));

      final formData;
      if (event.imageProfile != null) {
        String? fileName = event.imageProfile!.path.split('/').last;
        formData = FormData.fromMap({
          "user_id": state.userId,
          "first_name": event.firstName,
          "last_name": event.lastName,
          "gender": event.gender,
          "birthday": event.birthDay,
          "avatar": await MultipartFile.fromFile(event.imageProfile!.path, filename: fileName),
        });
      } else {
        formData = FormData.fromMap({
          "user_id": state.userId,
          "first_name": event.firstName,
          "last_name": event.lastName,
          "gender": event.gender,
          "birthday": event.birthDay,
        });
      }

      final dio = Dio();
      try {
        final response = await dio.post(
          "$apiPath/create-user",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.json,
            followRedirects: false,
            validateStatus: (_) => true,
          ),
          data: formData,
        );
        if (response.data["status"] == true) {
          emit(state.copyWith(loading: false));
          EasyLoading.showToast('บันทึกข้อมูลสำเร็จ');
          add(LoadAccount(context: event.context, firstLoad: false));
          // Navigator.push(event.context, pageProfile());
        } else {
          EasyLoading.showToast('มีบางอย่างผิดพลาด');
          emit(state.copyWith(loading: false));
          print("err");
        }
      } on Exception catch (e) {
        EasyLoading.showToast('มีบางอย่างผิดพลาด');
        print("Exception LoginCheck $e");
        emit(state.copyWith(loading: false));
      }
    });

    on<RegisterEmail>((event, emit) async {
      bool isValid = isEmailValid(event.email);
      int counter = 60;
      Timer timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (counter > 0) {
          counter--;
          add(CounterTime(counter: counter));
        } else {
          timer.cancel();
        }
      });
      if (isValid) {
        emit(state.copyWith(regCheckEmail: false));
        final dio = Dio();

        final response = await dio.post(
          "$apiPath/send-otp",
          options: Options(
            validateStatus: (_) => true,
            contentType: Headers.jsonContentType,
            responseType: ResponseType.json,
          ),
          data: {'email': event.email},
        );
        if (response.statusCode == 200) {
          print("ส่ง OTP สำเร็จ");
        } else {
          EasyLoading.showError("ไม่สามารถส่ง OTP ได้\n${response.data["error"]}");
          timer.cancel();
        }
      } else {
        emit(state.copyWith(regCheckEmail: true));
        timer.cancel();
      }
    });

    on<CounterTime>((event, emit) async {
      emit(state.copyWith(countdown: event.counter));
    });

    on<CheckOTP>((event, emit) async {
      emit(state.copyWith(loading: true));
      final dio = Dio();
      try {
        final response = await dio.post(
          "$apiPath/verify-otp",
          options: Options(
            contentType: 'application/json',
          ),
          data: {'otp': event.otp, 'email': event.email},
        );
        if (response.statusCode == 200) {
          emit(state.copyWith(
            loading: false,
            resCheckOTP: false,
            email: event.email,
          ));
          if (event.action == "create") {
            Navigator.push(event.context, pagePassword());
          } else {
            Navigator.push(event.context, pageResetPassword());
          }
        } else {
          emit(state.copyWith(loading: false, resCheckOTP: false));

          EasyLoading.showError("${response.statusCode}\nไม่สามารถส่งข้อมูลได้ลองอีกครั้งภายหลัง");
        }
      } on Exception catch (e) {
        emit(state.copyWith(loading: false, resCheckOTP: true));
        EasyLoading.showError("ไม่สามารถส่งข้อมูลได้ลองอีกครั้งภายหลัง\n${e}");
        EasyLoading.showError("ไม่สามารถ\nตรวจสอบข้อมูลได้ในขณะนี้ลองอีกครั้ง");
      }
    });

    on<SendOtpForgetPassword>((event, emit) async {
      bool isValid = isEmailValid(event.email);
      int counter = 60;
      Timer timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (counter > 0) {
          counter--;
          add(CounterTime(counter: counter));
        } else {
          timer.cancel();
        }
      });
      if (isValid) {
        emit(state.copyWith(regCheckEmail: false));
        final dio = Dio();
        try {
          final response = await dio.post(
            "$apiPath/forgot-password-otp",
            options: Options(
              validateStatus: (_) => true,
              contentType: Headers.jsonContentType,
              responseType: ResponseType.json,
            ),
            data: {'email': event.email},
          );
          if (response.statusCode == 200) {
            print("ส่ง OTP สำเร็จ");
          } else {
            EasyLoading.showError("ไม่สามารถส่ง OTP ได้\n${response.statusMessage}");
            timer.cancel();
          }
        } on Exception catch (e) {
          EasyLoading.showToast('Something went wrong! \n$e');
          print("Exception $e");
          emit(state.copyWith(loading: false));
        }
      } else {
        emit(state.copyWith(regCheckEmail: true));
        timer.cancel();
      }
    });

    on<ResetPassword>(((event, emit) async {
      final dio = Dio();
      if (event.password.length < 8) {
        emit(state.copyWith(regCheckPass: true));
      } else {
        emit(state.copyWith(regCheckPass: false));
      }
      if (event.password != event.cmPassword) {
        emit(state.copyWith(regPassMatch: true));
      } else {
        emit(state.copyWith(regPassMatch: false));
      }

      if (state.regCheckPass == false && state.regPassMatch == false) {
        emit(state.copyWith(loading: true));
        try {
          final response = await dio.put(
            "$apiPath/reset-password",
            options: Options(
              contentType: 'application/json',
              responseType: ResponseType.json,
              followRedirects: false,
              validateStatus: (_) => true,
            ),
            data: {
              "email": state.email,
              "newpassword": event.password,
            },
          );
          if (response.data["status"] == true) {
            emit(state.copyWith(loading: false));
            EasyLoading.showSuccess("เปลี่ยนรหัสผ่านสำเร็จ");
            Navigator.push(event.context, pageLogin());
          } else {
            EasyLoading.showToast('${response.statusMessage}');
            emit(state.copyWith(loading: false));
          }
        } on Exception catch (e) {
          EasyLoading.showToast('Something went wrong! \n$e');
          print("Exception $e");
          emit(state.copyWith(loading: false));
        }
      } else {
        EasyLoading.showToast('Something went wrong!');
        print("err");
        emit(state.copyWith(loading: false));
      }
    }));

    //zep
    on<LoginWithSocial>((event, emit) async {
      final dio = Dio();
      final prefs = await SharedPreferences.getInstance();
      try {
        final response = await dio.post(
          "${apiPath}/google-login",
          options: Options(
            contentType: 'application/json',
          ),
          data: {
            'email': event.getGoogleEmail,
            'avatar': event.getGoogleImg,
          },
        );
        print(response.data);
        if (response.data["status"] == true) {
          prefs.setString('token', response.data["api_token"]);
          print(response.data);

          add(LoadAccount(context: event.context, firstLoad: true));
        } else {
          EasyLoading.showInfo("ข้อผิดพลาด\n${response.statusMessage.toString()}");

          print("error");
        }
      } on Exception catch (e) {
        EasyLoading.showInfo("ข้อผิดพลาด\n${e.toString()}");
        print("Exception LoginCheck $e");
      }
    });
  }
}
