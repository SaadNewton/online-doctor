import 'dart:developer';

import 'package:doctoworld_doctor/Auth/registration_data/signup_userdata_model.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-login-data-API-call
getSignupData(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  log('sign up data ' + response.toString());
  LoaderController c = Get.put(LoaderController());
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    signupUserdataModel = SignupUserdataModel.fromJson(response);
    if (signupUserdataModel!.status == true) {
      storeDataLocally('user_detail', response);
      storeDataLocally('session', 'active');
      storeDataLocally('authToken', signupUserdataModel!.data.auth.token);
      storageBox!.write('doctor_id', signupUserdataModel.data.id);

      Get.offAll(ProfileWizard());
      print('getLogin UserData ------>> ${signupUserdataModel!.data}');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: signupUserdataModel!.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................' + response.toString());
// Get.find<AppController>().changeServerErrorCheck(true);
  }
}
