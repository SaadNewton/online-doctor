// @dart=2.9

import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Model/get_doctor_profile_modal.dart';
import 'package:doctoworld_doctor/Model/get_speciality_list_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-profile-data-API-call
getDoctorProfileRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);

    getDoctorProfileModal = GetDoctorProfileModal.fromJson(response);

    specialityList = [];
    getDoctorProfileModal.data.speciality.forEach((element) {
      specialityList.add(
          {
            'speciality': element
          }
      );
    });

    scheduleList = [];
    scheduleList.add(
        {
          'noOfDays': getDoctorProfileModal.data.serialDay,
          'slotDuration': getDoctorProfileModal.data.duration,
          'startTime':getDoctorProfileModal.data.startTime,
          'endTime':getDoctorProfileModal.data.endTime,
          'slots':getDoctorProfileModal.data.serialOrSlot,
        }
    );

    print('getDoctorProfileRepo ------>> ${getDoctorProfileModal.data}');
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
