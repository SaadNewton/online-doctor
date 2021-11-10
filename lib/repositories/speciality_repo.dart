//@dart=2.9
import 'package:doctoworld_doctor/Model/add_speciality_model.dart';
import 'package:doctoworld_doctor/controllers/auth_controller.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
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

updateSpeciality(bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  Get.find<LoaderController>().updateFormController(false);

  if (responseCheck) {
    Get.find<AuthController>().changeSignUpCheckerState(true);
    addSpecialityModel = AddSpecialityModel.fromJson(response);
    Get.find<LoaderController>().updateDataController(true);

    getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
        getDoctorProfileRepo);
    print('getSpeciality ------>> ${addSpecialityModel.data}');
  } else if (responseCheck && response == null) {
    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}