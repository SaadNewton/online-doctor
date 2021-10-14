import 'dart:async';
import 'package:doctoworld_doctor/Auth/log_in_data/login_ui.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  delayScreen() async {
    var duration = new Duration(seconds: 2);
    return new Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>
               storageBox!.hasData('session')
                   ? storageBox!.hasData('profile')
                   ? Dashboard()
                   : ProfileWizard()
                   : LoginUI()));
  }

  @override
  void initState() {
    // TODO: implement initState
    delayScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///background image
        Image.asset(
          'assets/splash-background.png',
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),

        ///Gradient container
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  customGradientLightBlue.withOpacity(0.3),
                  Theme.of(context).primaryColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Center(
              child: Image.asset('assets/splash-logo.png'),
            )),
      ],
    );
  }
}