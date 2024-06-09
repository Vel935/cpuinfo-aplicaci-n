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
import 'package:adaptive_theme/adaptive_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CpuProvider()),
      ChangeNotifierProvider(create: (_) => CpuComparatorProvider()),
    ],
    child: MainApp(savedThemeMode: savedThemeMode),
  ));
}

class MainApp extends StatelessWidget {
  MainApp({super.key, this.savedThemeMode});

  final AdaptiveThemeMode? savedThemeMode;

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: Colors.blue,
      ),
      dark: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: Colors.blue,
      ),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        title: 'CPU INFO',
        theme: theme,
        darkTheme: darkTheme,
        debugShowCheckedModeBanner: false,
        initialRoute: "login",
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
      ),
    );
  }
}

AppBar mainAppBar() {
  return AppBar(
    backgroundColor: const Color(0xFF353535),
    title: const Text("CPU INFO", style: TextStyle(color: Colors.white)),
  );
}
