

import 'package:doctoworld_doctor/Model/agora_model.dart';
import 'package:doctoworld_doctor/Model/get_all_doctors_articles.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

getAgoraRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    print('aaaaaaaaaaaaa');
    Get.find<LoaderController>().updateDataController(false);
    Get.find<LoaderController>().agoraModel = AgoraModel.fromJson(response);
    Get.find<LoaderController>().updateAgoraModel(Get.find<LoaderController>().agoraModel);
    print('getAgoraRepo ------>> ${Get.find<LoaderController>().agoraModel.channelName}');

  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}