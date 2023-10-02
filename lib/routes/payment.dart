// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';
import 'package:wanheng_app/screens/page_fixing.dart';
import 'package:wanheng_app/screens/payment/page_paid_success.dart';
import 'package:wanheng_app/screens/payment/page_payment.dart';

import '../screens/backup/page_payment.dart';

// Route pagePayment() {
//   return PageRouteBuilder(
//     pageBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//     ) {
//       return PagePayment();
//       // return PageFixing();
//     },
//     transitionsBuilder: (
//       BuildContext context,
//       Animation<double> animation,
//       Animation<double> secondaryAnimation,
//       Widget child,
//     ) {
//       return SlideTransition(
//         position: Tween<Offset>(
//           begin: const Offset(0.0, 1.0),
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

Route pageSettingPayment() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return PageSettingPayment();
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

Route pagePaidSuccess() {
  return PageRouteBuilder(
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      return PagePaidSuccess();
    },
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
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
