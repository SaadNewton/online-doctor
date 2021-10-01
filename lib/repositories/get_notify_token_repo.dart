import 'dart:developer';

import 'package:doctoworld_doctor/Model/get_notify_token_model.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/all_appointment_screen.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
String? otherRoleToken;
getNotifyTokenRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {

    getNotifyTokenModel = GetNotifyTokenModel.fromJson(response);
    if (getNotifyTokenModel.status == true) {
      log('getNotifyTokenModel ------>> ${getNotifyTokenModel.data!.token}');
      if(!Get.find<TokenController>().forDoctor){
        otherRoleToken=getNotifyTokenModel.data!.token;
      }
    } else {}
  } else if (!responseCheck && response == null) {


    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}