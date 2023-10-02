import 'package:flutter/material.dart';
import 'package:wanheng_app/screens/settings/page_setting.dart';

Route pageSetting() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return PageSetting();
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
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
