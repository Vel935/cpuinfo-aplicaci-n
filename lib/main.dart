import 'package:cpuinfo_application/controller/cpuProvider.dart';
import 'package:cpuinfo_application/controller/userProvider.dart';
import 'package:cpuinfo_application/pages/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CPU INFO",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: mainAppBar(),
        body: Center(
          child: LoginPage(),
        ),
      ),
    );
  }
}

AppBar mainAppBar() {
  return AppBar(
    title: const Text("CPU INFO"),
  );
}
