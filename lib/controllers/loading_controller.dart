//@dart=2.9
import 'package:doctoworld_doctor/Model/agora_model.dart';
import 'package:doctoworld_doctor/Model/fetch_chat_model.dart';
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

  bool prescriptionChecker = false;
  updatePrescriptionChecker(bool value) {
    checkDoctorStatusLoader = value;
    update();
  }

  List educationList = [];
  updateEducationList(Map<String, dynamic> updateValue) {
    educationList.add(updateValue);
    update();
  }

  emptyEducationList() {
    educationList = [];
    update();
  }

  List experienceList = [];
  updateExperienceList(Map<String, dynamic> updateValue) {
    experienceList.add(updateValue);
    update();
  }

  emptyExperienceList() {
    experienceList = [];
    update();
  }

  List specialityList = [];
  updateSpecialityList(Map<String, dynamic> updateValue) {
    specialityList.add(updateValue);
    update();
  }

  emptySpecialityList() {
    specialityList = [];
    update();
  }

  List scheduleList = [];
  updateScheduleList(Map<String, dynamic> updateValue) {
    scheduleList.add(updateValue);
    update();
  }

  emptyScheduleList() {
    scheduleList = [];
    update();
  }

  List clinicsList = [];
  updateClinicList(Map<String, dynamic> updateValue) {
    clinicsList.add(updateValue);
    update();
  }

  emptyClinicList() {
    clinicsList = [];
    update();
  }

  String clinicType;
  List<String> clinicTypeList = [];
  updateClinicTypeList(String updateValue) {
    clinicTypeList.add(updateValue);
    update();
  }

  AgoraModel agoraModel = AgoraModel();
  AgoraModel agoraModelDefault = AgoraModel();

  updateAgoraModel(AgoraModel newAgoraModel) {
    agoraModel = newAgoraModel;
    update();
  }

  updateAgoraModelDefault(AgoraModel newAgoraModel) {
    agoraModelDefault = newAgoraModel;
    update();
  }

  String otherRoleToken;
  updateOtherRoleToken(String newToken) {
    newToken = otherRoleToken;
    update();
  }

  int callerType = 2;
  updateCallerType(int i) {
    callerType = i;
    update();
  }

  List<ChatData> messageList = [];
  updateMessageList(ChatData chatData) {
    messageList.add(chatData);
    update();
  }

  emptyMessageList() {
    messageList = [];
    update();
  }
}
