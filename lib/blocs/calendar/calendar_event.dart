// ignore_for_file: must_be_immutable

part of 'calendar_bloc.dart';

abstract class CalendarEvent extends Equatable {
  const CalendarEvent();

  @override
  List<Object> get props => [];
}

class SelectDate extends CalendarEvent {
  String date, strDate, day, yearMonth;
  bool? premiumCheck;
  SelectDate({
    required this.date,
    this.premiumCheck,
    required this.strDate,
    required this.day,
    required this.yearMonth,
  });
}

class GetTodayNumber extends CalendarEvent {}
