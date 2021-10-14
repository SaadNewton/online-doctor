

import 'package:doctoworld_doctor/Model/fetch_chat_model.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctoworld_doctor/screens/chat_page.dart';

///-------- get-chat-API-call
fetchChatRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    fetchChatModel = FetchChatModel.fromJson(response);
    Get.find<LoaderController>().emptyMessageList();
    fetchChatModel.data!.forEach((element) {
      Get.find<LoaderController>().updateMessageList(element);
    });
    Get.find<LoaderController>().updateDataController(false);
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateDataController(false);

    print('Exception........................ ' + response.toString());
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
