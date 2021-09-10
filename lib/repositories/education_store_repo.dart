import 'package:doctoworld_doctor/Auth/Login/UI/login_ui.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Model/education_model.dart';
import 'package:doctoworld_doctor/Model/sign_up_model.dart';
import 'package:doctoworld_doctor/controllers/auth_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-Sign up-data-API-call
getEducationStoreData(bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<AuthController>().changeSignUpCheckerState(true);
    educationModel = EducationModel.fromJson(response);
    print('Ahmad');
    print('getEducationStoreData ------>> ${educationModel.success}');
    Get.to(LoginUI());
  } else if (responseCheck && response == null) {
    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
