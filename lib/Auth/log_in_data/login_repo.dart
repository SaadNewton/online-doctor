//@dart=2.9
import 'dart:developer';

import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/user_detail_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-login-data-API-call
getLoginData(
    bool responseCheck, Map<String, dynamic> response, BuildContext context,) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    userDetailModel = UserDetailModel.fromJson(response);
    if (userDetailModel.status == true) {
      storeDataLocally('user_detail', response);
      storeDataLocally('session', 'active');
      storeDataLocally('authToken', userDetailModel.data.auth.token);

      if(userDetailModel.data.status == 1){
        storageBox.write('approved', 'true');
      }
      if(userDetailModel.data.speciality == null){
        Get.offAll(ProfileWizard());
      }else{
        storageBox.write('profile', 'done');
        Get.offAll(Dashboard());
      }

      print('getLogin UserData ------>> ${userDetailModel.data.email}');
      storageBox.write('doctor_id', userDetailModel.data.id);
      print(storageBox.read('doctor_id'));

    } else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: userDetailModel.message,
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

    print('Exception................................. ' + response.toString());
// Get.find<AppController>().changeServerErrorCheck(true);
  }
}
