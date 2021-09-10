import 'package:get/get.dart';

class LoaderController extends GetxController {
  bool formLoader = false;
  updateFormController(bool value) {
    formLoader = value;
    update();
  }

  bool dataLoader = true;
  updateDataController(bool value) {
    dataLoader = value;
    update();
  }

  bool timeOutLoader = true;
  updateTimeOutController(bool value) {
    timeOutLoader = value;
    update();
  }
}
