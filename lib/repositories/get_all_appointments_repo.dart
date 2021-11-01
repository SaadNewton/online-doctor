// @dart=2.9

import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-labs-data-API-call
getAllLAppointmentRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getAllAppointmentsModel = GetAllAppointmentsModel.fromJson(response);
    if (getAllAppointmentsModel.status == true) {
      print(
          'get-all_Appointments_data ------>> ${getAllAppointmentsModel.data}');
    } else {
      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return CustomDialogBox(
      //         title: 'FAILED!',
      //         titleColor: customDialogErrorColor,
      //         descriptions: getAllAppointmentsModel.message,
      //         text: 'Ok',
      //         functionCall: () {
      //           Navigator.pop(context);
      //         },
      //         img: 'assets/dialog_error.svg',
      //       );
      //     });
    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

getDoneAppointmentRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getDoneAppointmentsModel = GetAllAppointmentsModel.fromJson(response);
    if (getDoneAppointmentsModel.status == true) {
      print(
          'get-done_Appointments_data ------>> ${getDoneAppointmentsModel.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

completeAppointmentRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      Get.snackbar('Thank you', 'Appointment completed successfully,',
          snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
      getMethod(
          context,
          getAllAppointmentsService,
          {'doctor_id': storageBox.read('doctor_id')},
          true,
          getAllLAppointmentRepo);
      getMethod(
          context,
          getDoneAppointmentsService,
          {'doctor_id': storageBox.read('doctor_id')},
          true,
          getDoneAppointmentRepo);
      Get.find<LoaderController>().updateDataController(true);
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
