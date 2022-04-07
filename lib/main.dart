import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:grooton/Auth/login.dart';
import 'package:grooton/appState.dart';
import 'package:grooton/sizeconfig.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider<AppStateNotifier>(
      create: (context) => AppStateNotifier(),
      child: const  MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<FirebaseApp> _intialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
            future: _intialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.done) {
                return StreamBuilder(
                    stream: FirebaseAuth.instance.authStateChanges(),
                    builder: (context, Streamsnapshot) {
                      if (Streamsnapshot.hasError) {
                        return Scaffold(
                          body: Center(
                            child: Text("Error: ${Streamsnapshot.hasError}"),
                          ),
                        );
                      }

                      if (Streamsnapshot.connectionState ==
                          ConnectionState.active) {
                        return helperone();
                      }


                      return Scaffold(
                        body: Center(
                          child: Text(
                            "Checking Authentication",
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                        ),
                      );
                    });
              }
              return Scaffold(
                body: Center(
                  child: Text("Intialising App....."),
                ),
              );
            }),
      ),
    );
  }
}
class helperone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return MaterialApp(
        home: signin(),
        debugShowCheckedModeBanner: false,
      );
  }
}