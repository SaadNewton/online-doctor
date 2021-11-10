//@dart=2.9
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

addScheduleRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      Get.snackbar(
          'Success',
          'Successfully Uploaded',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      print('ADDED');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
deleteScheduleRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      Get.find<LoaderController>().updateDataController(true);

      getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
          getDoctorProfileRepo);
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}