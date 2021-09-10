

import 'package:doctoworld_doctor/Model/check_status_model.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/signup_repo.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';

///-------- get-Sign up-data-API-call
checkStatusData(bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    // Get.find<AuthController>().changeSignUpCheckerState(true);
    checkStatusModel = CheckStatusModel.fromJson(response);
    print('getSignUpUserData ------>> $checkStatusModel');
    if (checkStatusModel.email! || checkStatusModel.phone == true) {
      print('Exception........................email and phone already exist');
      // Get.find<AppController>().changeServerErrorCheck(true);
    }else{

      postMethod(

          context,
          doctorSignupService,
          {
            'owner_name': nameController.text,
            'user_name': usernameController.text,
            'email': emailController.text,
            'phone': phoneController.text,
            'password': passController.text,
            'confirm_password': confirmPassController.text,
            'location':  locationController.text,
            'role': 'doctor',
          },
          false,
          getSignUpUserData
      );

    }
  } else {
    print('Status code not 200');
    // Get.find<AppController>().changeServerErrorCheck(true);
  }
}
