// @dart = 2.9
import 'dart:developer';
import 'package:doctoworld_doctor/Auth/registration_data/singup_repo.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/education_form.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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



verifyOTP(BuildContext context,var otp, bool fromSignUpForm) async {
  print('verify');
  try {
    AuthCredential credential = PhoneAuthProvider.credential(

      verificationId: verificationIDForVerify, smsCode: otp,);

    User user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    if(!fromSignUpForm){
      Get.find<LoaderController>().updateFormController(false);
      if (user != null) {
        print('user added by otp');
        Get.to(Dashboard());
        storageBox.write('session', 'true');

      } else {
        print("Error");
      }
      print('Credential ---->> ${credential}');
    }else{
      if (user != null) {
        print('user added by otp from signup');
        postMethod(
            context,
            customerSignUpService,
            {
              'phone': phoneController.text,
              'email': emailController.text,
              'password': passController.text,
              'owner_name': nameController.text,
              'confirm_password': confirmPassController.text,
              'lat': 0,
              'long': 0,
              'address': locationController.text,
              'role': 'doctor',
            },
            false,
            getSignupData
        );
      } else {
        print("Error");
      }
      print('Credential ---->> ${credential}');
    }
  } catch (e) {
    Get.find<LoaderController>().updateFormController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!',
            titleColor: customDialogErrorColor,
            descriptions: '${e.code}',
            text: 'Ok',
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });
    print('Exception --->> ${e.code}');
  }
}