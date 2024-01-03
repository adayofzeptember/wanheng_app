part of 'calendar_bloc.dart';

// ignore: must_be_immutable
class CalendarState extends Equatable {
  bool loading;
  dynamic predictData;
  String dateSelect;
  String dayOnly;
  String yearMonthOnly;
  int dayPremiumCheckPlus;


  CalendarState(
      {required this.loading,
      required this.predictData,
      required this.dateSelect,
      required this.dayOnly,
      required this.dayPremiumCheckPlus,
    
      required this.yearMonthOnly});

  CalendarState copyWith({
    bool? loading,
    dynamic predictData,
    int? dayPremiumCheckPlus,

    String? dayOnly,
    String? dateSelect,
    String? yearMonthOnly,
  }) {
    return CalendarState(
      dayOnly: dayOnly ?? this.dayOnly,
      dayPremiumCheckPlus: dayPremiumCheckPlus ?? this.dayPremiumCheckPlus,
 
      yearMonthOnly: yearMonthOnly ?? this.yearMonthOnly,
      loading: loading ?? this.loading,
      predictData: predictData ?? this.predictData,
      dateSelect: dateSelect ?? this.dateSelect,
    );
  }

  @override
  List<Object> get props => [
        loading,
        predictData,
        yearMonthOnly,
        dateSelect,
       
        dayOnly,
        dayPremiumCheckPlus,
      ];
}
