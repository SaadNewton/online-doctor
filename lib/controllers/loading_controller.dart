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

  bool checkDoctorStatusLoader = false;
  updateCheckDoctorStatusLoader(bool value) {
    checkDoctorStatusLoader = value;
    update();
  }


  List educationList = [];
  updateEducationList(Map<String,dynamic> updateValue){
    educationList.add(updateValue);
    update();
  }
  emptyEducationList(){
    educationList = [];
    update();
  }


  List experienceList = [];
  updateExperienceList(Map<String,dynamic> updateValue){
    experienceList.add(updateValue);
    update();
  }
  emptyExperienceList(){
    experienceList = [];
    update();
  }


  List specialityList = [];
  updateSpecialityList(Map<String,dynamic> updateValue){
    specialityList.add(updateValue);
    update();
  }
  emptySpecialityList(){
    specialityList = [];
    update();
  }


  List scheduleList = [];
  updateScheduleList(Map<String,dynamic> updateValue){
    scheduleList.add(updateValue);
    update();
  }
  emptyScheduleList(){
    scheduleList = [];
    update();
  }


  List clinicsList = [];
  updateClinicList(Map<String,dynamic> updateValue){
    clinicsList.add(updateValue);
    update();
  }
  emptyClinicList(){
    clinicsList = [];
    update();
  }

}
