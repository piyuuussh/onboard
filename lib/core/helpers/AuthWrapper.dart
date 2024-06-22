import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onboard/model/model/user.dart' as model;
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/route/customNavigator.dart';

class AuthWrapper extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User user = snapshot.data as User;
          if (user != null) {
            CustomNavigator.pushReplace(context, AppPages.home);
          } else {
            CustomNavigator.pushReplace(context, AppPages.login);
          }
        }
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
