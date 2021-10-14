
import 'package:doctoworld_doctor/screens/chat_page.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/approve_appointment_repo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

sendMessageRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    Get.find<LoaderController>().updateFormController(false);
    if (response['status'].toString() == 'true') {
      print('ADDED');
      postMethod(
          context,
          fcmService,
          {
            'notification': <String, dynamic>{
              'body': sendMessageController.text,
              'title': 'Chat'
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'channel': null,
              'channel_token': null,
              'routeWeb': '/',
              'routeApp':null,
            },
            'to': Get.find<LoaderController>().otherRoleToken,
          },
          false,
          method1
      );
      sendMessageController.clear();
      // Get.find<LoaderController>().updateDataController(true);
    } else {}
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}