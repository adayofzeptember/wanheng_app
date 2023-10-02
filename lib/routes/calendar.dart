import 'package:flutter/material.dart';
import 'package:wanheng_app/screens/calendar/page_calendar.dart';
import 'package:wanheng_app/screens/calendar/page_detail.dart';

Route pageCalendarLoading() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return const PageCalendar();
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
      milliseconds: 500,
    ),
  );
}

Route pageCalendar() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return const PageCalendar();
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

Route pageDetail() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return const PageDetail();
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

// Route pageCompass() {
//   return PageRouteBuilder(
//     pageBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//     ) {
//       return PageCompass();
//     },
//     transitionsBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child,
//     ) {
//       return SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(0.0, 0.0),
//           end: const Offset(0.0, 0.0),
//         ).animate(animation),
//         child: ScaleTransition(
//           scale: Tween<double>(
//             begin: 1,
//             end: 1,
//           ).animate(animation),
//           child: FadeTransition(
//             opacity: Tween<double>(
//               begin: 0,
//               end: 1,
//             ).animate(animation),
//             child: child,
//           ),
//         ),
//       );
//     },
//     transitionDuration: const Duration(
//       milliseconds: 300,
//     ),
//   );
// }
