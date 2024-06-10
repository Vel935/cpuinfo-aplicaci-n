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
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Text('¿Qué quieres hacer?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 27.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 131, 199, 255),
                        fontFamily: 'Roboto',
                        letterSpacing: 1.5,
                        shadows: [
                          Shadow(
                            color: isDarkMode
                                ? Colors.black
                                : Color.fromARGB(255, 0, 0, 0),
                            offset: const Offset(1, 2),
                            blurRadius: 5,
                          )
                        ])),
              ),
              const SizedBox(height: 10),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Comparar',
                                  style: homeTextButtonStyle(isDarkMode),
                                ),
                                Icon(Icons.compare_arrows_rounded, size: 60.0),
                              ],
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ver',
                                  style: homeTextButtonStyle(isDarkMode),
                                ),
                                Icon(
                                  Icons.remove_red_eye_rounded,
                                  size: 60.0,
                                ),
                              ],
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Modificar CPU',
                                    style: homeTextButtonStyle(isDarkMode),
                                  ),
                                  Icon(
                                    Icons.edit,
                                    size: 60.0,
                                  ),
                                ],
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
      color: isDarkMode ? Colors.white : Colors.black, fontSize: 30.0);

  ButtonStyle homeButtonStyle(bool isDarkMode) {
    return ButtonStyle(
      minimumSize:
          MaterialStateProperty.all<Size>(const Size(double.infinity, 150)),
      backgroundColor: MaterialStateProperty.all<Color>(
          isDarkMode ? Color(0xFF444444) : Color.fromARGB(255, 131, 199, 255)),
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
