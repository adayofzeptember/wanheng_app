part of 'calendar_bloc.dart';

// ignore: must_be_immutable
class CalendarState extends Equatable {
  bool loading;
  bool premium;
  dynamic predictData;
  String dateSelect;
  String dayOnly;

  String yearMonthOnly;
  int dayPremiumCheckPlus;
  int dayPremiumCheckMinus;

  CalendarState(
      {required this.loading,
      required this.predictData,
      required this.dateSelect,
      required this.premium,
      required this.dayOnly,
      required this.dayPremiumCheckPlus,
      required this.dayPremiumCheckMinus,
      required this.yearMonthOnly});

  CalendarState copyWith({
    bool? loading,
    bool? premium,
    dynamic predictData,
    int? dayPremiumCheckPlus,
    int? dayPremiumCheckMinus,
    String? dayOnly,
    String? dateSelect,
    String? yearMonthOnly,
  }) {
    return CalendarState(
      dayOnly: dayOnly ?? this.dayOnly,
      premium: premium ?? this.premium,
      dayPremiumCheckPlus: dayPremiumCheckPlus ?? this.dayPremiumCheckPlus,
      dayPremiumCheckMinus: dayPremiumCheckMinus ?? this.dayPremiumCheckMinus,
      yearMonthOnly: yearMonthOnly ?? this.yearMonthOnly,
      loading: loading ?? this.loading,
      predictData: predictData ?? this.predictData,
      dateSelect: dateSelect ?? this.dateSelect,
    );
  }

  @override
  List<Object> get props => [
        loading,
        premium,
        predictData,
        dayPremiumCheckMinus,
        yearMonthOnly,
        dateSelect,
        dayOnly,
        dayPremiumCheckPlus,
      ];
}
