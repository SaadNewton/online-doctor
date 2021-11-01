import 'package:doctoworld_doctor/Model/save_prescription_data_model.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

savePrescriptionDataRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    savePrescriptionDataModel = SavePrescriptionDataModel.fromJson(response);
    if (savePrescriptionDataModel.status == true) {
      print(
          'savePrescriptionDataRepo ------>> ${savePrescriptionDataModel.message}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
  }
}
