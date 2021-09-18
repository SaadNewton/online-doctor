// @dart=2.9

import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Model/get_speciality_list_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-getSpecialityListRepo-data-API-call
getSpecialityListRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    getSpecialityListModel = GetSpecialityListModel.fromJson(response);
    getSpecialityListModel.data.forEach((element) {
      getSpecialitiesList.add(element.name);
    });
    print('getSpecialityListRepo ------>> ${getSpecialityListModel.data}');
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
