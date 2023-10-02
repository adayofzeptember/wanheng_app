// ignore_for_file: unused_field

import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:wanheng_app/utils/app_colors.dart';
import '../../blocs/account/account_bloc.dart';
import '../../services/purchase/constant.dart';

class PagePayment extends StatefulWidget {
  const PagePayment({Key? key}) : super(key: key);

  @override
  _PagePaymentState createState() => _PagePaymentState();
}

class _PagePaymentState extends State<PagePayment> {
  int select = 0;
  CustomerInfo? _customerInfo;
  Offerings? _offerings;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    fetchData();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final customerInfo = await Purchases.getCustomerInfo();
    print("initPlatformState");

// $RCAnonymousID:af6fe67f032c434faa33a25677386786
    Purchases.addReadyForPromotedProductPurchaseListener((productID, startPurchase) async {
      print("*********************************************************PPPPPPP");
      print('Received readyForPromotedProductPurchase event for '
          'productID: $productID');

      try {
        final purchaseResult = await startPurchase.call();
        print('Promoted purchase for productID '
            '${purchaseResult.productIdentifier} completed, or product was'
            'already purchased. customerInfo returned is:'
            ' ${purchaseResult.customerInfo}');
      } on PlatformException catch (e) {
        print('Error purchasing promoted product: ${e.message}');
      }
    });

    if (!mounted) return;

    setState(() {
      _customerInfo = customerInfo;
    });
  }

  Future<void> fetchData() async {
    Offerings? offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _offerings = offerings;
    });
  }

  Package? packages;

  @override
  Widget build(BuildContext context) {
    if (_offerings != null) {
      final offering = _offerings!.current;
      if (offering != null) {
        List<Widget> buttonThings = offering.availablePackages
            .map((package) {
              List<Widget> buttons = [
                PurchaseButton(package: package),
              ];

              return buttons;
            })
            .expand((i) => i)
            .toList();
        return Scaffold(
          appBar: AppBar(
            // actions: [IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: Colors.black))],
            // automaticallyImplyLeading: false,
            leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios), color: Colors.black),
            elevation: 0,
            centerTitle: true,
            backgroundColor: const Color.fromARGB(250, 250, 250, 250),
            title: Text(
              "วันเฮง Premium",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
            child: ListView(
              children: [
                SizedBox(height: 20),
                Column(
                  children: buttonThings,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text("เงื่อนไขการชำระเงิน"),
                    ),
                    Text("และ"),
                    TextButton(
                      onPressed: () {},
                      child: Text("เงื่อนไขการให้บริการ"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        // actions: [IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: Colors.black))],
        // automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back_ios), color: Colors.black),
        elevation: 0,
        backgroundColor: const Color.fromARGB(250, 250, 250, 250),
        title: Text(
          "วันเฮง Premium",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text('Loading...'),
      ),
    );
  }
}

class PurchaseButton extends StatelessWidget {
  final Package package;

  // ignore: public_member_api_docs
  const PurchaseButton({Key? key, required this.package}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    return BlocBuilder<AccountBloc, AccountState>(
      builder: (context, state) {
        return Column(
          children: [
            if (package.storeProduct.identifier != "testing_product:product-test")
              PackageWidget(
                w: w,
                ontap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ตรวจสอบข้อมูลการชำระเงิน'),
                        content: Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${package.storeProduct.title}'),
                              Text(
                                  'ราคา ${package.storeProduct.price.toStringAsFixed(0)} บาท/${(package.storeProduct.identifier == "premium_1_m:premium-1month") ? "เดือน" : "ปี"}'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'ปิด',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                Navigator.pop(context);
                                final customerInfo = await Purchases.purchasePackage(package);
                                final isPro = customerInfo.entitlements.active.containsKey(entitlementKey);
                                if (isPro) {
                                  print("*****************************");

                                  print("*****************************");
                                }
                              } on PlatformException catch (e) {
                                final errorCode = PurchasesErrorHelper.getErrorCode(e);
                                if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
                                  print('User cancelled');
                                } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
                                  print('User not allowed to purchase');
                                } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
                                  print('Payment is pending');
                                }
                              }
                            },
                            child: Text(
                              'ดำเนินการชำระเงิน',
                              style: TextStyle(
                                color: Colors.greenAccent.shade700,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                type: '${package.storeProduct.title} ',
                price:
                    "ราคา ${package.storeProduct.price.toStringAsFixed(0)} บาท/${(package.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"}",
                detail:
                    "ราคา ${package.storeProduct.price.toStringAsFixed(0)} บาทต่อ${(package.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"} สามารถยกเลิกได้ตลอดเวลา",
              ),
            if (package.storeProduct.identifier == "testing_product:product-test" && state.isTesting == true)
              PackageWidget(
                w: w,
                ontap: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('ตรวจสอบข้อมูลการชำระเงิน'),
                        content: Container(
                          height: 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${package.storeProduct.title}'),
                              Text(
                                  'ราคา ${package.storeProduct.price.toStringAsFixed(0)} บาท/${(package.storeProduct.identifier == "premium_1_m:premium-1month") ? "เดือน" : "ปี"}'),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'ปิด',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              try {
                                Navigator.pop(context);
                                final customerInfo = await Purchases.purchasePackage(package);
                                final isPro = customerInfo.entitlements.active.containsKey(entitlementKey);
                                if (isPro) {
                                  print("*****************************");

                                  print("*****************************");
                                }
                              } on PlatformException catch (e) {
                                final errorCode = PurchasesErrorHelper.getErrorCode(e);
                                if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
                                  print('User cancelled');
                                } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
                                  print('User not allowed to purchase');
                                } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
                                  print('Payment is pending');
                                }
                              }
                            },
                            child: Text(
                              'ดำเนินการชำระเงิน',
                              style: TextStyle(
                                color: Colors.greenAccent.shade700,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                type: '${package.storeProduct.title} ',
                price:
                    "ราคา ${package.storeProduct.price.toStringAsFixed(0)} บาท/${(package.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"}",
                detail:
                    "ราคา ${package.storeProduct.price.toStringAsFixed(0)} บาทต่อ${(package.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"} สามารถยกเลิกได้ตลอดเวลา",
              ),
          ],
        );
      },
    );
  }
}

class PackageWidget extends StatelessWidget {
  const PackageWidget({
    super.key,
    required this.w,
    required this.ontap,
    required this.type,
    required this.price,
    required this.detail,
  });

  final double w;
  final Function() ontap;
  final String type, price, detail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: w,
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 20),
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          border: Border.all(color: const Color.fromARGB(255, 240, 190, 9), width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 215, 190, 138),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                type,
                style: TextStyle(color: AppColor.mainColor, fontSize: 18),
              ),
            ),
            SizedBox(height: 4),
            Text(
              price,
              style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4),
            Text(
              detail,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
