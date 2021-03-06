//@dart=2.9
import 'dart:developer';

import 'package:doctoworld_doctor/screens/new_appointments.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/approve_appointment_model.dart';
import 'package:doctoworld_doctor/Model/remove_appointment_model.dart';
import 'package:doctoworld_doctor/Model/user_detail_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/splash.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- Remove Appointments by doctor
removeAppointments(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    removeAppointmentModel = RemoveAppointmentModel.fromJson(response);
    if (removeAppointmentModel.status == true) {
      Get.snackbar(
          'Success',
          'Successfully Rejected',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      // storeDataLocally('user_detail', response);
      // storeDataLocally('session', 'active');
      // storeDataLocally('authToken', userDetailModel.data!.auth!.token);
      // Get.offAll(BottomNavigation());
      print(
          'Remove Appointment Message------>> ${removeAppointmentModel.message}');
      getMethod(context, getAllAppointmentsService, {'doctor_id': storageBox.read('doctor_id')}, true,
          getAllLAppointmentRepo);
    } else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: removeAppointmentModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    print('Not rejected');
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
