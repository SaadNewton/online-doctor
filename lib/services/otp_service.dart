// @dart = 2.9
import 'dart:developer';
import 'package:doctoworld_doctor/screens/education_form.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


String verificationIDForVerify;
Future<bool> otpFunction(String phone, BuildContext context) async {
  print('otpFunction');
  FirebaseAuth _auth = FirebaseAuth.instance;
  _auth.verifyPhoneNumber(
    phoneNumber: phone,
    timeout: Duration(seconds: 55),
    verificationCompleted: (AuthCredential credential) async {
      // method();

      print('Credential from verificationCompleted ---->> ${credential}');
    },
    verificationFailed: (FirebaseAuthException exception) {
      // method();
      print('Exception ---->> ${exception.message}');

    },
    codeSent: (String verificationId, [int forceResendingToken]) {
      // method();
      verificationIDForVerify = verificationId;
      log('verificationId ---->> ${verificationId}');
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}



verifyOTP(BuildContext context,var otp) async {
  print('verify');
  try {
    AuthCredential credential = PhoneAuthProvider.credential(

      verificationId: verificationIDForVerify, smsCode: otp,);

    User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    if (user != null) {
      print('user added by otp');
      Get.to(EducationForm());
      storageBox.write('session', 'true');

    } else {
      print("Error");
    }
    print('Credential ---->> ${credential}');
  } catch (e) {
    print('Exception --->> ${e.code}');
  }
}