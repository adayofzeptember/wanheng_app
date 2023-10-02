// // ignore_for_file: must_be_immutable
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:wanheng_app/blocs/compass/compass_bloc.dart';
// import '../../utils/app_colors.dart';
// import '../../utils/images_path.dart';

// class PageCompass_Original extends StatefulWidget {
//   @override
//   _CompassAppState createState() => _CompassAppState();
// }

// class _CompassAppState extends State<PageCompass_Original> {
//   @override
//   void initState() {
//     context.read<CompassBloc>().add(StartWatchCompass());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('sdgfdfg');
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
        
//         backgroundColor: AppColor.mainColor,
//         body: Container(
//           width: w,
//           height: h,
//           alignment: Alignment.center,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage(AppImage.bg1),
//               fit: BoxFit.fill,
//             ),
//           ),
//           child: SingleChildScrollView(
//             child: Container(
//               child: Column(
//                 children: [
//                   const SizedBox(height: 12),
//                   const Text(
//                     'เข็มทิศ',
//                     style: TextStyle(
//                       fontSize: 25,
//                       color: AppColor.title,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                     child: Stack(
//                       // alignment: Alignment.center,
//                       children: [
//                         Container(
//                           height: 420,
//                           width: 500,
//                           // decoration: BoxDecoration(color: Colors.blueGrey),
//                           child: 
//                           BlocBuilder<CompassBloc, CompassState>(
//                             builder: (context, state) {
//                               print(state.heading.toString());
//                               return Transform.rotate(
//                                 angle: ((state.heading) * (pi / 180) * -1),
//                                 child: Image.asset(
//                                   'assets/images/bgcompass.png',
//                                   scale: 1,
//                                   fit: BoxFit.contain,
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         Positioned(
//                           top: 0,
//                           left: (w / 2) - 20,
//                           child: Image.asset(
//                             'assets/images/arrow.png',
//                             height: 215,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(20),
//                     // height: 200,
//                     width: w * .85,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: BlocBuilder<CompassBloc, CompassState>(
//                       builder: (context, state) {
//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: [
//                                    Text(
//                                   "${state.heading.toStringAsFixed(0)}° ",
//                                   style: const TextStyle(
//                                     fontSize: 25,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 // Text(
//                                 //   "${state.heading.toStringAsFixed(0)}° ",
//                                 //   style: const TextStyle(
//                                 //     fontSize: 25,
//                                 //     fontWeight: FontWeight.bold,
//                                 //   ),
//                                 // ),
//                                 Text(
//                                   (state.heading <= 20)
//                                       ? 'ทิศเหนือ' //N
//                                       : (state.heading <= 70)
//                                           ? 'ทิศตะวันออกเฉียงเหนือ' //'NE'
//                                           : (state.heading <= 110)
//                                               ? 'ทิศตะวันออก' //'E'
//                                               : (state.heading <= 160)
//                                                   ? 'ตะวันออกเฉียงใต้' //'SE'
//                                                   : (state.heading <= 200)
//                                                       ? 'ทิศใต้' //'S'
//                                                       : (state.heading <= 250)
//                                                           ? 'ทิศตะวันตกเฉียงใต้' //'SW'
//                                                           : (state.heading <= 290)
//                                                               ? 'ทิศตะวันตก' //'W'
//                                                               : (state.heading <=
//                                                                       340)
//                                                                   ? 'ทิศตะวันตกเฉียงเหนือ' //'NW'
//                                                                   : 'ทิศเหนือ', //'N',
//                                   style: const TextStyle(
//                                     fontSize: 20,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Predict(heading: state.heading),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Predict extends StatelessWidget {
//   Predict({Key? key, required this.heading}) : super(key: key);
//   double heading;

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       (heading <= 15)
//           ? 'ชวด น้ำ+'
//           : (heading <= 45)
//               ? 'ฉลู ดิน-'
//               : (heading <= 75)
//                   ? 'ขาล ไม้+'
//                   : (heading <= 105)
//                       ? 'เถาะ ไม้-'
//                       : (heading <= 135)
//                           ? 'มะโรง ดิน'
//                           : (heading <= 165)
//                               ? 'มะเส็ง ไฟ-'
//                               : (heading <= 195)
//                                   ? 'มะเมีย ไฟ+'
//                                   : (heading <= 225)
//                                       ? 'มะแม ดิน'
//                                       : (heading <= 255)
//                                           ? 'วอก ทอง-'
//                                           : (heading <= 285)
//                                               ? 'ระกา ทอง+'
//                                               : (heading <= 315)
//                                                   ? 'จอ ดิน+'
//                                                   : (heading <= 345)
//                                                       ? 'กุน น้ำ-'
//                                                       : "ชวด น้ำ+",
//       style: TextStyle(
//         fontSize: 25,
//         fontWeight: FontWeight.bold,
//         color: (heading <= 15)
//             ? AppColor.water0
//             : (heading <= 45)
//                 ? AppColor.soli0
//                 : (heading <= 75)
//                     ? AppColor.wood0
//                     : (heading <= 105)
//                         ? AppColor.wood1
//                         : (heading <= 135)
//                             ? const Color.fromARGB(255, 244, 190, 53)
//                             : (heading <= 165)
//                                 ? AppColor.fire1
//                                 : (heading <= 195)
//                                     ? AppColor.fire0
//                                     : (heading <= 225)
//                                         ? const Color.fromARGB(
//                                             255, 248, 148, 33)
//                                         : (heading <= 255)
//                                             ? const Color.fromARGB(
//                                                 255, 150, 150, 150)
//                                             : (heading <= 285)
//                                                 ? AppColor.gold0
//                                                 : (heading <= 315)
//                                                     ? const Color.fromARGB(
//                                                         255, 191, 120, 55)
//                                                     : (heading <= 345)
//                                                         ? const Color.fromARGB(
//                                                             255, 135, 193, 229)
//                                                         : AppColor.water0,
//       ),
//     );
//   }
// }
