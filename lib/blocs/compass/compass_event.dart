// ignore_for_file: must_be_immutable

part of 'compass_bloc.dart';

abstract class CompassEventinBloc extends Equatable {
  const CompassEventinBloc();

  @override
  List<Object> get props => [];
}

class HandingCompass extends CompassEventinBloc {
  double handing;
  HandingCompass({required this.handing});
}

class RadianCompass extends CompassEventinBloc {
  double radian;
  RadianCompass({required this.radian});
}

class CalculateCompass extends CompassEventinBloc {
  late AnimationController animetionController;
  CalculateCompass({required this.animetionController});
}
