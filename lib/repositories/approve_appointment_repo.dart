import 'dart:developer';

import 'package:doctoworld_doctor/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_doctor/screens/new_appointments.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/approve_appointment_model.dart';
import 'package:doctoworld_doctor/Model/user_detail_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/screens/splash.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

method(){}

///-------- Approve Appointments by doctor
approveAppointments(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    approveAppointmentModel = ApproveAppointmentModel.fromJson(response);
    if (approveAppointmentModel.status == true) {
      Get.snackbar(
          'Success',
          'Successfully Accepted',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      postMethod(context,
          fcmService,
          {
            'notification': <String, dynamic>{
              'body': 'Your appointment is confirmed',
              'title': 'Appointment'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'routeWeb': '/customer/approved/appointment/detail',
              'routeApp':'/allAppointments',
            },
            'to': otherRoleToken,
          },
          false,
          method);
      // storeDataLocally('user_detail', response);
      // storeDataLocally('session', 'active');
      // storeDataLocally('authToken', userDetailModel.data!.auth!.token);
      // Get.offAll(BottomNavigation());
      print(
          'Approve Appointment Message------>> ${approveAppointmentModel.message}');
      getMethod(context, getAllAppointmentsService, {'doctor_id': storageBox!.read('doctor_id')}, true,
          getAllLAppointmentRepo);
    }
    else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: approveAppointmentModel.message,
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    print('Appointment not Accept');
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
