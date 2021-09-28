// @dart=2.9

import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Model/get_all_doctors_articles.dart';
import 'package:doctoworld_doctor/Model/get_articles_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- get-articles-data-API-call
getAllLArticlesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getArticlesModel = GetArticlesModel.fromJson(response);
    if (getArticlesModel.status == true) {
      print('getAllLArticlesRepo ------>> ${getArticlesModel.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
getAllDoctorsArticlesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    getAllDoctorsArticles = GetAllDoctorsArticles.fromJson(response);
    if (getAllDoctorsArticles.status == true) {
      print('getAllLArticlesRepo ------>> ${getAllDoctorsArticles.data}');
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
addArticlesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      Get.snackbar(
          'Success',
          'Successfully Uploaded',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      Get.find<LoaderController>().updateDataController(true);
      getMethod(
          context,
          getAllArticlesService,
          {'doctor_id': storageBox.read('doctor_id')},
          true,
          getAllLArticlesRepo);
      Navigator.pop(context);
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
deleteArticlesRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      Get.snackbar(
          'Success',
          'Successfully Done',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      Get.find<LoaderController>().updateDataController(true);
      getMethod(
          context,
          getAllArticlesService,
          {'doctor_id': storageBox.read('doctor_id')},
          true,
          getAllLArticlesRepo);
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);
    Get.find<LoaderController>().updateDataController(false);


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
