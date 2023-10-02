import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../blocs/account/account_bloc.dart';
import '../../routes/login.dart';
import '../../services/google signin/signin_method.dart';
import '../../utils/app_colors.dart';
import '../../utils/config.dart';
import '../../widget/components/btn.dart';

class PageDelete extends StatefulWidget {
  const PageDelete({Key? key}) : super(key: key);

  @override
  _PageDeleteState createState() => _PageDeleteState();
}

class _PageDeleteState extends State<PageDelete> {
  List<RadioModel> sampleData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sampleData.add(RadioModel(false, "ฉันไม่ได้ใช้วันเฮงอีกต่อไป"));
    sampleData.add(RadioModel(false, 'ฉันต้องการเปิดบัญชีใหม่'));
    sampleData.add(RadioModel(false, "รายการของฉันไม่ได้ขาย"));
    sampleData.add(RadioModel(false, "ฉันมีปัญหากับการทำธุรกรรม"));
    sampleData.add(RadioModel(false, "ฉันไม่เห็นด้วยกับนโยบายของวันเฮง"));
    sampleData.add(RadioModel(false, "ฉันไม่เห็นด้วยกับค่าธรรมเนียมวันเฮง"));
    sampleData.add(RadioModel(false, "ฉันมีข้อกังวลด้านความปลอดภัยหรือความเป็นส่วนตัว"));
    sampleData.add(RadioModel(false, "เหตุผลของฉันไม่อยู่ในรายการ"));
  }

  String? detail;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 132, 2, 2),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text("ลบบัญชี"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 12),
              child: Container(
                height: 100,
                child: Text("""
หากคุณลบบัญชีของคุณ คุณจะไม่สามารถเข้าถึงการขายหรือการซื้อใดๆ ของคุณได้

ข้อมูลทั้งหมดของคุณจะถูกลบอย่างถาวร ไม่สามารถกู้คืนได้
"""),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: sampleData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        sampleData.forEach((element) => element.isSelected = false);
                        sampleData[index].isSelected = true;
                        detail = sampleData[index].text;
                      });
                    },
                    child: RadioItem(sampleData[index]),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 100,
              child: Btn(
                title: "ยืนยันการลบ",
                onClick: () {
                  if (detail != null) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        contentPadding: const EdgeInsets.all(8),
                        // backgroundColor: Colors.black.withOpacity(0.8),
                        title: Center(child: Text("ยืนยันการลบ!")),
                        content: Text("""
หากคุณลบบัญชีของคุณ คุณจะไม่สามารถเข้าถึงการขายหรือการซื้อใดๆ ของคุณได้

ข้อมูลทั้งหมดของคุณจะถูกลบอย่างถาวร ไม่สามารถกู้คืนได้
                        """),
                        actions: [
                          Btn(
                              bgColor: Colors.grey.shade400,
                              title: "ยกเลิก",
                              textColor: Colors.black,
                              onClick: () => Navigator.pop(context)),
                          Btn(
                            bgColor: AppColor.mainColor,
                            textColor: Colors.white,
                            title: "ตกลง",
                            onClick: () async {
                              EasyLoading.show(maskType: EasyLoadingMaskType.black, status: 'Loading...');

                              final prefs = await SharedPreferences.getInstance();
                              String? token = prefs.getString('token');
                              final dio = Dio();
                              try {
                                final response = await dio.delete(
                                  "$apiPath/delete-user",
                                  options: Options(
                                    headers: {
                                      "Authorization": "Bearer $token",
                                    },
                                    validateStatus: (_) => true,
                                    contentType: Headers.jsonContentType,
                                    responseType: ResponseType.json,
                                  ),
                                  data: {'details': detail},
                                );
                                if (response.statusCode == 200) {
                                  Purchases.logOut();
                                  await FacebookAuth.instance.logOut();
                                  if (GoogleSignInAPI.check() != null) {
                                    await GoogleSignInAPI.logout();
                                  }

                                  await prefs.remove("token");
                                  await prefs.remove("platformLoginCheck");

                                  context.read<AccountBloc>().add(ClearState());
                                  await EasyLoading.showSuccess("ลบบัญชีสำเร็จ");

                                  await Navigator.pushReplacement(context, pageLogin());
                                } else {
                                  EasyLoading.showError("Something went wrong!\n${response.statusMessage}");
                                }
                              } on Exception catch (e) {
                                EasyLoading.showToast('Something went wrong! \n$e');
                                print("Exception $e");
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    EasyLoading.showError("กรุณาเลือกสาเหตุ");
                  }
                },
                bgColor: AppColor.mainColor,
                textColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(15.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                  color: _item.isSelected ? Colors.blueAccent : Colors.transparent,
                  border: Border.all(width: 1.0, color: _item.isSelected ? Colors.blueAccent : Colors.grey),
                  borderRadius: const BorderRadius.all(const Radius.circular(50.0)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10.0),
                child: Text(_item.text),
              )
            ],
          ),
        ),
        Divider(),
      ],
    );
  }
}

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}
