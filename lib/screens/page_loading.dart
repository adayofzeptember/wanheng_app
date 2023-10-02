import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wanheng_app/blocs/account/account_bloc.dart';

class PageLoading extends StatefulWidget {
  const PageLoading({Key? key}) : super(key: key);

  @override
  _PageLoadingState createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  String? checkToken;
  @override
  void initState() {
    super.initState();
    loading();
  }

  loading() async {
    // PermissionStatus psCamera = await Permission.camera.status;
    // PermissionStatus psCamera = await Permission.camera.status;

    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.photos,
    ].request();
    print(statuses);
    Future.delayed(const Duration(milliseconds: 1000), () {
      context.read<AccountBloc>().add(LoadAccount(context: context, firstLoad: true));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bg/loading.jpg"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
