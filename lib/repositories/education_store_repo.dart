//@dart=2.9
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-deleteEducationStoreData-data-API-call

deleteEducationStoreData(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().updateDataController(true);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      Get.find<LoaderController>().updateDataController(true);

      getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
          getDoctorProfileRepo);
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().updateDataController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}