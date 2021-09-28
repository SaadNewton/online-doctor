//@dart=2.9

import 'dart:developer';

import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/clinic_store_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

clinicStore(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    clinicStoreModel = ClinicStoreModel.fromJson(response);
    if (clinicStoreModel.status == true) {
      Get.snackbar(
          'Success',
          'Successfully Uploaded',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      print(
          'clinic Message------>> ${clinicStoreModel.message}');
      Get.find<LoaderController>().updateClinicList(
          {
            'clinic_id':clinicStoreModel.data.id,
            'clinic_name':clinicStoreModel.data.name,
            'clinic_address':clinicStoreModel.data.address
          }
      );
      // clinicsList.add(
      //     {
      //       'clinic_id':clinicStoreModel.data.id,
      //       'clinic_name':clinicStoreModel.data.name,
      //       'clinic_address':clinicStoreModel.data.address
      //     }
      // );
    }
    else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: 'Try Again',
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    print('clinic error');
    Get.find<LoaderController>().updateFormController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!',
            titleColor: customDialogErrorColor,
            descriptions: 'Try Again',
            text: 'Ok',
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}

deleteClinic(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      Get.snackbar(
          'Success',
          'Successfully Done',
          backgroundColor: Colors.black.withOpacity(0.5),
          colorText: Colors.white
      );
      print('ADDED');
      Get.find<LoaderController>().updateDataController(true);

      getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
          getDoctorProfileRepo);
    }
    else {
      log('data ' + response.toString());
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: 'Try Again',
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    }
  } else if (!responseCheck && response == null) {
    print('clinic error');
    Get.find<LoaderController>().updateFormController(false);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialogBox(
            title: 'FAILED!',
            titleColor: customDialogErrorColor,
            descriptions: 'Try Again',
            text: 'Ok',
            functionCall: () {
              Navigator.pop(context);
            },
            img: 'assets/dialog_error.svg',
          );
        });

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}