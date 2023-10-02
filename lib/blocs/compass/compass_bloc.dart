import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
part 'compass_event.dart';
part 'compass_state.dart';

class CompassBloc extends Bloc<CompassEventinBloc, CompassState> {
  CompassBloc() : super(CompassState(handing: 0.0, radian: 0.0)) {
    on<HandingCompass>((event, emit) {
      emit(state.copyWith(handing: event.handing));
    });

    on<RadianCompass>((event, emit) {
      emit(state.copyWith(radian: event.radian));
      // print(event.radian.toStringAsFixed(2));
      // if (event.radian.toStringAsFixed(2) == "-4.37") {
      //   HapticFeedback.lightImpact();
      // }
    });
  }
}
