// @dart=2.9

import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-labs-data-API-call
getAllLAppointmentRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getAllAppointmentsModel = GetAllAppointmentsModel.fromJson(response);
    if (getAllAppointmentsModel.status == true) {
      print('get-all_Appointments_data ------>> ${getAllAppointmentsModel.data}');
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
