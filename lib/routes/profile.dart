import 'package:flutter/material.dart';
import 'package:wanheng_app/screens/profile/page_edit_profile.dart';
import 'package:wanheng_app/screens/profile/page_profile.dart';

Route pageProfile() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return PageProfile();
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1,
            end: 1,
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 1,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        ),
      );
    },
    transitionDuration: const Duration(
      milliseconds: 300,
    ),
  );
}

Route pageEditProfile({
  required firstName,
  required lastName,
  required gender,
  required selectedDay,
  required selectedMon,
  required selectedYear,
  required selectedHour,
  required selectedMin,
}) {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return PageEditProfile(
        firstName: firstName,
        lastName: lastName,
        gender: gender,
        selectedDay: selectedDay,
        selectedMon: selectedMon,
        selectedYear: selectedYear,
        selectedHour: selectedHour,
        selectedMin: selectedMin,
      );
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 0.0),
          end: const Offset(0.0, 0.0),
        ).animate(animation),
        child: ScaleTransition(
          scale: Tween<double>(
            begin: 1,
            end: 1,
          ).animate(animation),
          child: FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),
            child: child,
          ),
        ),
      );
    },
    transitionDuration: const Duration(
      milliseconds: 300,
    ),
  );
}
