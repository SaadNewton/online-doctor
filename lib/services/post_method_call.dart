import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio_instance;
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/services/headers.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

postMethod(
    BuildContext context,
    String apiUrl,
    dynamic postData,
    bool addAuthHeader,
    Function executionMethod // for performing functionalities
    ) async {
  dio_instance.Response response;
  dio_instance.Dio dio = new dio_instance.Dio();
  dio.options.connectTimeout = 10000;
  dio.options.receiveTimeout = 6000;
  setAcceptHeader(dio);
  setContentHeader(dio);
  //-- if API need headers then this if works and it based on bool value come from function calling

  if (addAuthHeader && storageBox!.hasData('authToken')) {
    setCustomHeader(dio, 'token', '${storageBox!.read('authToken')}');
    setCustomHeader(dio, 'role', 'doctor');

    print('token ' + storageBox!.read('authToken'));
  } else if (addAuthHeader && !storageBox!.hasData('authToken')) {}

  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('Internet Connected');
      // Get.find<AppController>().changeInternetCheckerState(true);
      try {
        print('postData--->> ${postData}');
        response = await dio.post(apiUrl, data: postData);
        log('$apiUrl--->> ${response.statusCode}');
        log('$apiUrl--->> ${response.data}');
        if (response.statusCode == 200) {

          print('true');

          executionMethod(true, response.data, context);

        } else {
          print(response.data.toString());
          executionMethod(false, null, context);
        }
      } on dio_instance.DioError catch (e) {
        print('Dio Error From Post $apiUrl -->> ${e.response!.data.toString()}');
        executionMethod(false, null, context);
        // messageShowService(response.data,false);
      }
    }
  } on SocketException catch (_) {
    // Get.find<AppController>().changeInternetCheckerState(false);
    print('Internet Not Connected');
  }
}
