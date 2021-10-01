import 'package:doctoworld_doctor/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

createNotifyRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {

    if(response['status']){
   getMethod(context, getNotifyTokenService, {
     'user_id':storageBox!.read('doctor_id'),
     'role':'doctor'
   }, false, getNotifyTokenRepo);

    }else{
     
    }
    print('cart ------>> $response');
  } else if (!responseCheck && response == null) {



    print('Exception........................');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}