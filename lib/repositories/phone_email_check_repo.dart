import 'dart:developer';

import 'package:doctoworld_doctor/Auth/Verification/UI/verification_ui.dart';
import 'package:doctoworld_doctor/Auth/registration_data/singup_repo.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/services/otp_service.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

phoneEmailCheckRepo(
    bool responseCheck, Map<String, dynamic> response, BuildContext context) {
  if (responseCheck) {
    LoaderController c = Get.put(LoaderController());
    var emailPhoneValidModel;
    // emailPhoneValidModel = EmailPhoneValidModel.fromJson(response);
    log('data ' + response.toString());
    if (response['email'] || response['phone']) {
      Get.find<LoaderController>().updateFormController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'Failed',
              titleColor: customDialogErrorColor,
              descriptions: 'Email or Phone Number Already Exist',
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
    } else {

      if(phoneController.text.contains('+92')){
        print('NUMBER--->>${phoneController.text}');
        otpFunction(
            phoneController.text,
            context
        );
        Get.find<LoaderController>().updateFormController(false);
        Get.to(VerificationUI(number:  phoneController,fromSignUpForm: true,));
      }else{
        if(phoneController.text.startsWith('0'))
          phoneController.text = phoneController.text.replaceFirst('0', '+92');
        print('NUMBER--->>${phoneController.text}');

        otpFunction(
            phoneController.text,
            context
        );
        Get.find<LoaderController>().updateFormController(false);
        Get.to(VerificationUI(number:  phoneController,fromSignUpForm: true,));
      }
      // otpFunction(phoneController.text, context);
      // Get.to(VerificationUI(number: phoneController.text));
    }
  } else if (!responseCheck && response == null) {
    Get.find<LoaderController>().updateFormController(false);

    print('Exception........................' + response.toString());
// Get.find<AppController>().changeServerErrorCheck(true);
  }
}