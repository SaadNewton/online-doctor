//@dart=2.9

import 'dart:developer';

import 'package:doctoworld_doctor/screens/new_appointments.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/approve_appointment_model.dart';
import 'package:doctoworld_doctor/Model/user_detail_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/screens/splash.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///-------- Approve  doctor
doctorStatusRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateDataController(false);
    doctorStatusModel = DoctorStatusModel.fromJson(response);
    if (doctorStatusModel.active) {
      storageBox.write('approved', 'true');
      Get.find<LoaderController>().updateCheckDoctorStatusLoader(true);
    }
    print('DOCTOR CHECK RESPONSE--->>${doctorStatusModel.active}');
  } else if (!responseCheck && response == null) {
    print('Doctor not Accept');
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................ ' + response.toString());
  }
}

/// active : true

class DoctorStatusModel {
  bool _active;

  bool get active => _active;

  DoctorStatusModel({bool active}) {
    _active = active;
  }

  DoctorStatusModel.fromJson(dynamic json) {
    _active = json["active"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["active"] = _active;
    return map;
  }
}
