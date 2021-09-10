//@dart=2.9
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Model/add_speciality_model.dart';
import 'package:doctoworld_doctor/controllers/auth_controller.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



getSpeciality(bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  Get.find<LoaderController>().updateFormController(false);

  if (responseCheck) {
    Get.find<AuthController>().changeSignUpCheckerState(true);
    addSpecialityModel = AddSpecialityModel.fromJson(response);
    print('getSpeciality ------>> ${addSpecialityModel.data}');
  } else if (responseCheck && response == null) {
    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}