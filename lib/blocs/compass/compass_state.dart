part of 'compass_bloc.dart';

// ignore: must_be_immutable
class CompassState extends Equatable {
  CompassState({
    required this.handing,
    required this.radian,
  });
  double handing, radian;

  CompassState copyWith({
    double? handing,
    double? radian,
  }) {
    return CompassState(
      radian: radian ?? this.radian,
      handing: handing ?? this.handing,
    );
  }

  @override
  List<Object> get props => [handing, radian];
}
