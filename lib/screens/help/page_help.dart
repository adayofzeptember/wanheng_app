// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wanheng_app/blocs/contact/contact_bloc.dart';
import '../../utils/app_colors.dart';
import '../../utils/images_path.dart';
import '../../widget/components/btn.dart';

class PageHelp extends StatelessWidget {
  PageHelp({Key? key}) : super(key: key);

  final formContactKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var contextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 132, 2, 2),
        elevation: 0,
        title: const Text(
          'ติดต่อเรา',
          style: TextStyle(
            fontSize: 20,
            color: AppColor.title,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColor.title,
          ),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImage.bg4),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Form(
                      key: formContactKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            // height: 1600,
                            child: TextFormField(
                              cursorColor: AppColor.mainColor,
                              controller: titleController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'โปรดกรอกชื่อเรื่อง';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 243, 238, 238),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: 'ชื่อเรื่อง',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            height: 200,
                            child: TextFormField(
                              cursorColor: AppColor.mainColor,
                              textAlignVertical: TextAlignVertical.top,

                              maxLines: null, // Set this
                              expands: true,

                              controller: contextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'โปรดกรอกเนื้อหาที่ต้องการติดต่อ';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.white), borderRadius: BorderRadius.circular(10)),
                                filled: true,
                                fillColor: const Color.fromARGB(255, 243, 238, 238),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                hintText: 'เนื้อหา',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SizedBox(
                              width: double.infinity,
                              child: Btn(
                                title: 'ส่ง',
                                fontWeight: FontWeight.bold,
                                onClick: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  if (formContactKey.currentState!.validate()) {
                                    formContactKey.currentState?.save();
                                    print(titleController.text + contextController.text);

                                    context.read<ContactBloc>().add(Send_ContactCasual(
                                        context: context, getTitle: titleController.text, getContext: contextController.text));
                                    titleController.clear();
                                    contextController.clear();
                                  }
                                },
                                bgColor: const Color.fromARGB(255, 215, 190, 138),
                                textColor: AppColor.mainColor,
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
