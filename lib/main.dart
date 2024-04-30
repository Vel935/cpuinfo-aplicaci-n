import 'package:cpuinfo_application/pages/firstPage/firstPage.dart';
import 'package:cpuinfo_application/pages/homePage/homePage.dart';
import 'package:cpuinfo_application/providers/cpuProvider.dart';
import 'package:cpuinfo_application/pages/comparator/ComparatorAddPage.dart';
import 'package:cpuinfo_application/pages/register/RegisterPage.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:cpuinfo_application/pages/login/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cpuinfo_application/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CpuProvider()),
    ],
    child: MainApp(),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      key: navigatorKey,
      title: "CPU INFO",
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "register": (context) => RegisterPage(),
        "firstPage": (context) => FirstPage(),
        "home": (context) => HomePage(),
        "comparatormenu": (context) => const ComparatorAddPage()
      },
    );
  }
}

AppBar mainAppBar() {
  return AppBar(
    title: const Text("CPU INFO"),
  );
}
