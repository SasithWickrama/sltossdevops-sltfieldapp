import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slt_field_app/providers/home_provider.dart';
import 'package:slt_field_app/providers/login_provider.dart';
import 'package:slt_field_app/providers/service_provider.dart';
import 'package:slt_field_app/screens/home.dart';
import 'package:slt_field_app/screens/login.dart';
import 'package:slt_field_app/screens/service_detail.dart';
import 'package:slt_field_app/screens/welcome.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'models/AppStore.dart';

AppStore appStore = AppStore();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await initializeService();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => LoginProvider()),
      ChangeNotifierProvider(create: (context) => HomeProvider()),
      ChangeNotifierProvider(create: (context) => ServiceProvider()),


    ],
    child: const MyApp(),
  ));
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidgetBuilder: (_) { //ignored progress for the moment
        return Center(
          child: SpinKitCubeGrid(
            color: Colors.lightBlueAccent,
            size: 50.0,
          ),
        );
      },
      overlayColor: Colors.black.withOpacity(0.8),
      duration: Duration(seconds: 1),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SLT FIELD',
        initialRoute: '/',
        routes: {
          '/': (context) => const Login(),
          '/login': (context) => const Login(),
          '/home': (context) => const Home(),
          '/service': (context) => const ServiceDetails(),

        },

      ),
    );
  }


}
