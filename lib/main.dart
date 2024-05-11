import 'package:cpuinfo_application/pages/cpuCrud/addCpuPage/addCpuPage.dart';
import 'package:cpuinfo_application/pages/cpuCrud/cpuCrudPage.dart';
import 'package:cpuinfo_application/pages/cpuCrud/modifyCpu/modifyCpuPage.dart';
import 'package:cpuinfo_application/pages/cpuInformation/CpuInformationPage.dart';
import 'package:cpuinfo_application/pages/firstPage/firstPage.dart';
import 'package:cpuinfo_application/pages/homePage/homePage.dart';
import 'package:cpuinfo_application/pages/viewProcessor/ViewAllProcessorsPage.dart';
import 'package:cpuinfo_application/providers/CpuProvider.dart';
import 'package:cpuinfo_application/pages/comparator/ComparatorAddPage.dart';
import 'package:cpuinfo_application/pages/register/RegisterPage.dart';
import 'package:cpuinfo_application/providers/UserProvider.dart';
import 'package:cpuinfo_application/pages/login/LoginPage.dart';
import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
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
      ChangeNotifierProvider(create: (_) => CpuComparatorProvider())
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
      initialRoute: "home",
      routes: {
        "login": (BuildContext context) => LoginPage(),
        "register": (context) => RegisterPage(),
        "firstPage": (context) => FirstPage(),
        "home": (context) => HomePage(),
        "comparatormenu": (context) => const ComparatorAddPage(),
        "cpuCrudPage": (context) => cpuCrudPage(),
        "addCPU": (context) => CreateCpuPage(),
        "viewAllProcessors": (context) => const ViewAllProcessorsPage(),
        "viewProcesorInformation": (context) => CpuInformationPage(),
        "modifyCPU": (context) => ModifyCpuPage(),
      },
    );
  }
}

AppBar mainAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFF353535),
    title: const Text("CPU INFO", style: TextStyle(color: Colors.white)),
  );
}
