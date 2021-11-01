import 'package:doctoworld_doctor/Model/get_medicine_from_search_model.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

getMedicineFromSearchRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    medicineSearchModel = GetMedicineFromSearchModel.fromJson(response);
    if (medicineSearchModel.status == true) {
      print(
          'getMedicineFromSearchRepo ------>> ${medicineSearchModel.message}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
  }
}
