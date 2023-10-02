part of 'calendar_bloc.dart';

// ignore: must_be_immutable
class CalendarState extends Equatable {
  CalendarState({
    required this.loading,
    required this.predictData,
    required this.dateSelect,
  });
  bool loading;
  dynamic predictData;
  String dateSelect;

  CalendarState copyWith({
    bool? loading,
    dynamic predictData,
    String? dateSelect,
  }) {
    return CalendarState(
      loading: loading ?? this.loading,
      predictData: predictData ?? this.predictData,
      dateSelect: dateSelect ?? this.dateSelect,
    );
  }

  @override
  List<Object> get props => [
        loading,
        predictData,
        dateSelect,
      ];
}
