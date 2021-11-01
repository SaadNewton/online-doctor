import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/create_report_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/all_appointment_screen.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'get_all_appointments_repo.dart';

createReportRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    createReportModel = CreateReportModel.fromJson(response);
    if (createReportModel.status == true) {
      print('create Report Repo ------>> ${createReportModel.message}');
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'Success',
              titleColor: customDialogQuestionColor,
              descriptions: 'Health report has been sent to customer',
              text: 'ok',
              functionCall: () {
                postMethod(
                    context,
                    changeAppointmentStatusService,
                    {'is_complete': 2, 'appointment_id': appointmentID},
                    true,
                    completeAppointmentRepo);
                Get.off(AllAppointmentScreen());
                Get.find<LoaderController>().updateFormController(false);
              },
              img: 'assets/dialog_success.svg',
            );
          });
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'Failed',
              titleColor: customDialogQuestionColor,
              descriptions: 'Sorry, we encountered and error',
              text: 'ok',
              functionCall: () {
                Navigator.pop(context);
                // Get.back();
                Get.find<LoaderController>().updateFormController(false);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    Get.snackbar('Failed', 'Something went wrong at our end',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.white);
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
  }
}
