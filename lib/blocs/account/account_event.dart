// ignore_for_file: must_be_immutable

part of 'account_bloc.dart';

abstract class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class ClearState extends AccountEvent {}

class LoginWithFacebook extends AccountEvent {
  var context;
  String name, email, picture;
  LoginWithFacebook({
    required this.context,
    required this.name,
    required this.email,
    required this.picture,
  });
}

class LoginCheck extends AccountEvent {
  var context;
  String phone, password;
  LoginCheck({required this.context, required this.phone, required this.password});
}

class Register extends AccountEvent {
  var context;
  String password, cmPassword;
  Register({
    required this.context,
    // required this.phone,
    required this.password,
    required this.cmPassword,
  });
}

class RegisterEmail extends AccountEvent {
  String email;
  RegisterEmail({required this.email});
}

class CounterTime extends AccountEvent {
  int counter;
  CounterTime({required this.counter});
}

class CheckOTP extends AccountEvent {
  var context;
  String otp, email, action;
  CheckOTP({required this.context, required this.otp, required this.email, required this.action});
}

class UserCreate extends AccountEvent {
  var context;
  String firstName, lastName, gender, birthDay;
  File? imageProfile;
  UserCreate({
    required this.context,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDay,
    this.imageProfile,
  });
}

class LoadAccount extends AccountEvent {
  var context;
  bool firstLoad;
  LoadAccount({required this.context, required this.firstLoad});
}

class SendOtpForgetPassword extends AccountEvent {
  String email;
  SendOtpForgetPassword({required this.email});
}

class ResetPassword extends AccountEvent {
  var context;
  String password, cmPassword;
  ResetPassword({
    required this.context,
    required this.password,
    required this.cmPassword,
  });
}

//zep
class LoginWithSocial extends AccountEvent {
  String getGoogleEmail, getGoogleImg;
    var context;
  LoginWithSocial({required this.getGoogleEmail, required this.getGoogleImg, required this.context});
}
