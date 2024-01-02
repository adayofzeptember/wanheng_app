import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanheng_app/blocs/account/account_bloc.dart';
import 'package:wanheng_app/blocs/contact/contact_bloc.dart';
import 'package:wanheng_app/screens/page_loading.dart';
import 'blocs/calendar/calendar_bloc.dart';
import 'blocs/compass/compass_bloc.dart';
import 'services/purchase/constant.dart';
import 'services/purchase/store_config.dart';

String? checkToken;

void main() async {
  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(
      store: Store.appStore,
      apiKey: appleApiKey,
    );
  } else if (Platform.isAndroid) {
    // Run the app passing --dart-define=AMAZON=true
    const useAmazon = bool.fromEnvironment("amazon");
    StoreConfig(
      store: useAmazon ? Store.amazon : Store.playStore,
      apiKey: useAmazon ? amazonApiKey : googleApiKey,
    );
  }
  Intl.defaultLocale = 'th';
  initializeDateFormatting();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  checkToken = prefs.getString('token');
  ErrorWidget.builder = (FlutterErrorDetails details) => Material(
        color: const Color.fromARGB(255, 122, 192, 191),
        child: Center(
          child: Text(
            details.exception.toString(),
          ),
        ),
      );
  await _configureSDK();
  runApp(const MyApp());
}

Future<void> _configureSDK() async {
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration configuration;
  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey);
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
  }
  await Purchases.configure(configuration);

  await Purchases.enableAdServicesAttributionTokenCollection();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AccountBloc()),
        BlocProvider(create: (context) => CompassBloc()),
        BlocProvider(create: (context) => CalendarBloc()),
        BlocProvider(create: (context) => ContactBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: EasyLoading.init(),
        theme: ThemeData(fontFamily: 'Prompt'),
        home: PageLoading(),
      ),
    );
  }
}
