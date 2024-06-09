import 'package:cpuinfo_application/providers/cpuComparatorProvider.dart';
import 'package:cpuinfo_application/widgets/CustomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  Future<void> _checkUserRole() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        isAdmin = userDoc['role'] == 'Administrador';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: const MyAppBar(),
      body: Container(
        alignment: Alignment.center,
        width: double.infinity,
        color: isDarkMode ? Colors.grey[850] : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '¿Qué quieres hacer?',
                style: TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: homeButtonStyle(isDarkMode),
                            onPressed: () {
                              Provider.of<CpuComparatorProvider>(
                                context,
                                listen: false,
                              ).updateActualPage("");
                              Navigator.pushNamed(context, "comparatormenu");
                            },
                            child: Text(
                              'Comparar',
                              style: homeTextButtonStyle(isDarkMode),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            style: homeButtonStyle(isDarkMode),
                            onPressed: () {
                              Provider.of<CpuComparatorProvider>(context,
                                      listen: false)
                                  .updateState(false);
                              Provider.of<CpuComparatorProvider>(context,
                                      listen: false)
                                  .updateActualPage("");
                              Navigator.pushNamed(context, 'viewAllProcessors');
                            },
                            child: Text(
                              'Ver',
                              style: homeTextButtonStyle(isDarkMode),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (isAdmin)
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: homeButtonStyle(isDarkMode),
                              onPressed: () {
                                Navigator.pushNamed(context, "cpuCrudPage");
                              },
                              child: Text(
                                'Modificar CPU',
                                style: homeTextButtonStyle(isDarkMode),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextStyle homeTextButtonStyle(bool isDarkMode) => TextStyle(
      color: isDarkMode ? Colors.white : Colors.black, fontSize: 20.0);

  ButtonStyle homeButtonStyle(bool isDarkMode) {
    return ButtonStyle(
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 150)),
      backgroundColor: MaterialStateProperty.all<Color>(
          isDarkMode ? Color(0xFF444444) : Color(0xFFCBD7DD)),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      side: MaterialStateProperty.all<BorderSide>(
        BorderSide(color: isDarkMode ? Colors.white : Colors.black, width: 2),
      ),
    );
  }
}
