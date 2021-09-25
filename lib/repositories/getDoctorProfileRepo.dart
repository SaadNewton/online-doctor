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

    updateEmailController.text = getDoctorProfileModal.data.email;
    updateLocationController.text = getDoctorProfileModal.data.address;
    Get.find<LoaderController>().specialityList = [];
    getDoctorProfileModal.data.speciality.forEach((element) {
      Get.find<LoaderController>().updateSpecialityList(
          {
            'speciality': element
          }
      );
    });

    Get.find<LoaderController>().clinicType = null;
    Get.find<LoaderController>().clinicTypeList = [];

    getDoctorProfileModal.data.clinics.forEach((element) {

      if(Get.find<LoaderController>()
          .clinicTypeList.length != 0){

        if(element.name.toString() !=
            Get.find<LoaderController>().clinicTypeList[(Get.find<LoaderController>()
                .clinicTypeList.length)-1].toString()){

          Get.find<LoaderController>().updateClinicTypeList(
              element.name.toString()
          );
        }
      }else{
        Get.find<LoaderController>().updateClinicTypeList(
            element.name.toString()
        );
      }

    });

    Get.find<LoaderController>().emptyScheduleList();
    // scheduleList = [];
    // response['data']['serial_day_app'].forEach((element){
    //   Get.find<LoaderController>().updateScheduleList(
    //       {
    //         'noOfDays': getDoctorProfileModal.data.serialDay,
    //         'slotDuration': element['duration'],
    //         'startTime':element['start_time'],
    //         'endTime':element['end_time'],
    //         'slots':element['slots'],
    //         'schedule_type': element['schedule_type'],
    //         'clinic_name': element['clinic_name'],
    //         'clinic_address': element['clinic_address'],
    //         'days': element['days']
    //       }
    //   );
    // });

    print('getDoctorProfileRepo ------>> ${getDoctorProfileModal.data}');
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().updateFormController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

updateDoctorPersonalProfileRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      Get.snackbar('Success','Updated Successfully');

    } else {
      Get.snackbar('Failed','Try again');

    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().updateDataController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}