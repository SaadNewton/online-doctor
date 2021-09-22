import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

addScheduleRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}