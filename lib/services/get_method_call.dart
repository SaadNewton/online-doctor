import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart' as dio_instance;
import 'package:doctoworld_doctor/services/headers.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

getMethod(
    BuildContext context,
    String apiUrl,
    dynamic queryData,
    bool addAuthHeader,
    Function executionMethod // for performing functionalities
    ) async {
  // final c = Get.put(AppController());
  dio_instance.Response response;
  dio_instance.Dio dio = new dio_instance.Dio();

  // dio.options.connectTimeout = 20000;
  dio.options.receiveTimeout = 6000;

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
        response = await dio.get(apiUrl, queryParameters: queryData);

        if (response.statusCode == 200) {
          log('StatusCode------>> ${response.statusCode}');
          log('Response $apiUrl------>> ${response.data}');
          executionMethod(true, response.data, context);
        } else {
          executionMethod(false, null, context);
        }
      } on dio_instance.DioError catch (e) {
        executionMethod(false, null, context);
        if (e.response != null) {
          print(
              'Dio Error From Get $apiUrl -->> ${e.response}');
        } else {
          print('Dio Error From Get $apiUrl -->> ${e}');
        }

        // messageShowService(response.data,false);

      }
    }
  } on SocketException catch (_) {
    // Get.find<AppController>().changeInternetCheckerState(false);
    print('Internet Not Connected');
  }
}