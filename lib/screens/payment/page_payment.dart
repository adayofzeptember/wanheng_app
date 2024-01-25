import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wanheng_app/routes/payment.dart';
import 'package:wanheng_app/routes/terms_privacy.dart';
import '../../blocs/account/account_bloc.dart';
import '../../utils/app_colors.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../services/purchase/constant.dart';
import '../../widget/components/bg_package.dart';
import '../../widget/components/btn.dart';
import '../../widget/components/package_box.dart';

class PageSettingPayment extends StatefulWidget {
  const PageSettingPayment({Key? key}) : super(key: key);

  @override
  _PageSettingPaymentState createState() => _PageSettingPaymentState();
}

class _PageSettingPaymentState extends State<PageSettingPayment> {
  // ignore: unused_field
  CustomerInfo? _customerInfo;
  Offerings? offeringAll;
  Package? productTest, productMonthly, productYearly, selectedPackage;
  int? indexPackage;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    fetchData();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final customerInfo = await Purchases.getCustomerInfo();
    print(customerInfo.allPurchasedProductIdentifiers);

    Purchases.addReadyForPromotedProductPurchaseListener(
        (productID, startPurchase) async {
      print("*********************************************************");
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
    try {
      var offeringMonthly, offeringYearly;
      offeringAll = await Purchases.getOfferings();
      // var offeringProductTest;
      // offeringProductTest = offeringAll?.getOffering("Subscriptions")?.getPackage("Monthly Testing");
      offeringMonthly =
          offeringAll?.getOffering("Subscriptions")?.getPackage("\$rc_monthly");
      offeringYearly =
          offeringAll?.getOffering("Subscriptions")?.getPackage("\$rc_annual");

      setState(() {
        // productTest = offeringProductTest;
        productMonthly = offeringMonthly;
        productYearly = offeringYearly;
      });
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    if (productMonthly != null || productYearly != null) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("วันเฮง Premium"),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: AppColor.mainColor,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
          child: BlocBuilder<AccountBloc, AccountState>(
            builder: (context, state) {
              return ListView(
                children: [
                  if (state.premium)
                    Text(
                      "Premium จะหมดอายุ " + state.expirationDate,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    )
                  else
                    BgPackage(
                      w: w,
                      column: [
                        Text(
                          "สมัครสมาชิกพรีเมียม",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            // fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 10),
                        // if (state.isTesting)
                        //   PackageWidget(
                        //     selected: (indexPackage == 1) ? AppColor.premium : Colors.grey.shade300,
                        //     w: w,
                        //     ontap: () {
                        //       indexPackage = 1;
                        //       selectedPackage = productTest;
                        //       setState(() {});
                        //     },
                        //     type: '${productTest!.storeProduct.title} ',
                        //     price:
                        //         "ราคา ${productTest!.storeProduct.priceString}/${(productTest!.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"}",
                        //     detail: "ครั้งต่อไปต่ออายุที่ราคา ราคา ${productTest!.storeProduct.priceString} \n"
                        //         "เมื่อถึงวันหมดอายุจะทำการต่ออายุอัตโนมัติิ ${(productTest!.storeProduct.subscriptionPeriod == 'P1M') ? '1 เดือน' : '1 ปี'} สามารถยกเลิกได้ตลอดเวลา",
                        //   ),
                        PackageWidget(
                          selected: (indexPackage == 2)
                              ? AppColor.premium
                              : Colors.grey.shade300,
                          w: w,
                          ontap: () {
                            selectedPackage = productMonthly;
                            indexPackage = 2;
                            setState(() {});
                          },
                          type: '${productMonthly!.storeProduct.title} ',
                          price:
                              "ราคา ${productMonthly!.storeProduct.priceString}/${(productMonthly!.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"}",
                          detail:
                              "ครั้งต่อไปต่ออายุที่ราคา ราคา ${productMonthly!.storeProduct.priceString}\n"
                              "เมื่อถึงวันหมดอายุจะทำการต่ออายุอัตโนมัติิ ${(productMonthly!.storeProduct.subscriptionPeriod == 'P1M') ? '1 เดือน' : '1 ปี'} สามารถยกเลิกได้ตลอดเวลา",
                        ),
                        PackageWidget(
                          selected: (indexPackage == 3)
                              ? AppColor.premium
                              : Colors.grey.shade300,
                          w: w,
                          ontap: () {
                            selectedPackage = productYearly;
                            indexPackage = 3;
                            setState(() {});
                          },
                          type: '${productYearly!.storeProduct.title} ',
                          price:
                              "ราคา ${productYearly!.storeProduct.priceString}/${(productYearly!.storeProduct.subscriptionPeriod == "P1M") ? "เดือน" : "ปี"}",
                          detail:
                              "ครั้งต่อไปต่ออายุที่ราคา ราคา ${productYearly!.storeProduct.priceString}\n"
                              "เมื่อถึงวันหมดอายุจะทำการต่ออายุอัตโนมัติิ ${(productYearly!.storeProduct.subscriptionPeriod == 'P1M') ? '1 เดือน' : '1 ปี'} สามารถยกเลิกได้ตลอดเวลา",
                        ),
                      ],
                    ),
                  SizedBox(height: 10),
                  BgPackage(
                    w: w,
                    column: [
                      Text(
                        "สิทธิประโยชน์ของสมาชิกพรีเมียม",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.solidCompass,
                              color: Color.fromARGB(255, 249, 213, 82)),
                          SizedBox(width: 8),
                          Text(
                            "เข็มทิศ",
                            style: TextStyle(color: AppColor.mainColor),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.calendarCheck,
                              color: Color.fromARGB(255, 249, 213, 82)),
                          SizedBox(width: 8),
                          Text(
                            "ปฏิทินฮวงจุ้ยทั้งหมด",
                            style: TextStyle(color: AppColor.mainColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  BgPackage(
                    w: w,
                    column: [
                      Text(
                        "รายละเอียดของบริการต่ออายุอัตโนมัติ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        (Platform.isAndroid)
                            ? "● ชำระเงิน: ภายหลังผู้ใช้ยืนยันการซื้อและชำระเงินจะถูกบันทึกในบัญชี Goole Play Store"
                                "\n● ยกเลิกการต่ออายุ: หากต้องการยกเลิการต่ออายุ กรุณากดไปที่แอป Play Store และที่การชำระเงินและการสมัครใช้บริการ หรือกดที่เมนู การชำระเงินและการใช้บริการ เพื่อปิดระบบการต่ออายุอัตโนมัติก่อนี่จะถึงเวลาหมดอายุ"
                                "\n● ค่าธรรมเนียมต่ออายุ: บัญชี Google Play Store จะหักค่าธรรมเนียมโดยอัตโนมัติเมื่อสิ้นสุดช่วงเวลาของการสมัครรับข้อมูลแต่ละช่วง"
                            : "● การชำระเงิน: ภายหลังผู้ใช้ยืนยันการซื้อและชำระเงินจะถูกบันทึกในบัญชี iTunes"
                                "\n● ยกเลิกการต่ออายุ: หากต้องการยกเลิการต่ออายุ กรุณาไปที่การจัดการตั้งค่า iTunes/Apple ID เพื่อปิดระบบการต่ออายุอัตโนมัติก่อน 24 ชั่วโมงที่จะถึงเวลาหมดอายุ หากยกเลิกภายในภาย 24 ชั่วโมงหมดอายุ ค่าธรรมเนียมจะถูกเรียกเก็บ"
                                "\n● ค่าธรรมเนียมการต่ออายุ: บัญชี iTunes Apple จะหักค่าธรรมเนียมภายใน 24 ชั่วโมงก่อนหมดอายุ หลังหักค่าธรรมเนียมเรียบร้อยแล้ว ระยะเวลาสมาชิกจะถูกต่ออายุไปอีกหนึ่งรอบ",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  BgPackage(
                    w: w,
                    column: [
                      TextButton(
                        onPressed: () => Navigator.push(context, pageTerms()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ข้อตกลงให้บริการ",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(Icons.arrow_right, color: Colors.black)
                          ],
                        ),
                      ),
                      Divider(),
                      TextButton(
                        onPressed: () => Navigator.push(context, pagePrivacy()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "นโยบายความเป็นส่วนตัว",
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.black),
                            ),
                            Icon(Icons.arrow_right, color: Colors.black)
                          ],
                        ),
                      ),
                      Divider(),
                      if (Platform.isAndroid)
                        TextButton(
                          onPressed: () async {
                            launchUrl(Uri.parse(
                                'https://play.google.com/store/account/subscriptions'));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "การชำระเงินและการสมัครใช้บริการ",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.black),
                              ),
                              Icon(Icons.arrow_right, color: Colors.black)
                            ],
                          ),
                        )
                      else
                        TextButton(
                          onPressed: () async {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('ยกเลิกต่ออายุอัตโนมัติ'),
                                  content: const Text(
                                      "ตามนโยบายของ Apple ท่านจะต้องไปที่อุปกรณ์ของ Apple เข้าสู่ระบบด้วยบัญชี Apple ID ที่เปิดใช้"
                                      "บริการต่ออายุอัตโนมัติเพื่อทำรายการยกเลิกการต่ออายุ\n"
                                      "ไปยังหน้า ตั้งค่า ในมือถือ ต่อด้วย iTunes Store และ App Store -> เลือก Apple ID -> เลือก ดูApple ID -> "
                                      "ในหน้าบัญชีนั้นให้เลือก จัดการสมาชิก -> ยกเลิกการสมัครเป็นสมาชิก"),
                                  actions: <Widget>[
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: const Text(
                                        'ไปที่ตั้งค่ายกเลิกการต่ออายุ',
                                        style: TextStyle(
                                            color: AppColor.mainColor),
                                      ),
                                      onPressed: () => launchUrl(Uri.parse(
                                          "https://apps.apple.com/account/subscriptions")),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        textStyle: Theme.of(context)
                                            .textTheme
                                            .labelLarge,
                                      ),
                                      child: const Text(
                                        'ออก',
                                        style: TextStyle(color: AppColor.title),
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ],
                                );
                              },
                            );
                            // launchUrl(Uri.parse("https://apps.apple.com/account/subscriptions"));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "ยกเลิกพรีเมียม",
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.red),
                              ),
                              Icon(Icons.arrow_right, color: Colors.red)
                            ],
                          ),
                        ),
                      Divider(),
                      TextButton(
                        onPressed: () async {
                          // EasyLoading.show(maskType: EasyLoadingMask e));
                        },
                        child: Text(
                          "กู้คืนการซื้อ",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
            child: Btn(
              title:
                  'ชำระเงิน ${selectedPackage != null ? selectedPackage?.storeProduct.title : ""}',
              onClick: () async {
                if (selectedPackage != null) {
                  //!
                  try {
                    EasyLoading.show(
                        status: "โปรดรอสักครู่..",
                        maskType: EasyLoadingMaskType.black);
                    final customerInfo =
                        await Purchases.purchasePackage(selectedPackage!);
                    final isPro = customerInfo.entitlements.active
                        .containsKey(entitlementKey);
                    if (isPro) {
                      EasyLoading.dismiss();
                      print("*****************************");
                      Navigator.pushReplacement(context, pagePaidSuccess());
                      print("*****************************");
                    }
                  } on PlatformException catch (e) {
                    final errorCode = PurchasesErrorHelper.getErrorCode(e);
                    if (errorCode ==
                        PurchasesErrorCode.purchaseCancelledError) {
                      EasyLoading.dismiss();
                      print('User cancelled');
                    } else if (errorCode ==
                        PurchasesErrorCode.purchaseNotAllowedError) {
                      EasyLoading.showError("User not allowed to purchase");
                      print('User not allowed to purchase');
                    } else if (errorCode ==
                        PurchasesErrorCode.paymentPendingError) {
                      EasyLoading.showError("${errorCode}");
                      print('Payment is pending');
                    }
                    EasyLoading.dismiss();
                  }
                } else {
                  EasyLoading.showInfo("กรุณาเลือกรายการ");
                }
              },
              bgColor: const Color.fromARGB(255, 215, 190, 138),
              textColor: AppColor.mainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black),
        elevation: 0,
        backgroundColor: const Color.fromARGB(250, 250, 250, 250),
        title: Text(
          "วันเฮง Premium",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: const Center(
        child: Text('โปรดรอสักครู่..'),
      ),
    );
  }
}

Future<void> sendRevoke() async {
  final dio = Dio();
  try {
    final response = await dio.get(
      "https://api.revenuecat.com/v1/subscribers/\$email:tangtikon.intisan@compattana.com",
      options: Options(
        contentType: 'application/json',
        headers: {
          "Authorization": "Bearer sk_TTafgskyOsLMAgDuRMcQkYfNBEvRr",
        },
      ),
    );
    print(response.data);
  } on Exception catch (e) {
    print("Exception LoginCheck $e");
  }
}
