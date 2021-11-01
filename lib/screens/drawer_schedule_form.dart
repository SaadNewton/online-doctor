//@dart=2.9
import 'dart:math';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/repositories/scheduleRepo.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/screens/schedule_form.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DrawerScheduleForm extends StatefulWidget {
  @override
  _DrawerScheduleFormState createState() => _DrawerScheduleFormState();
}

class _DrawerScheduleFormState extends State<DrawerScheduleForm> {

  final scheduleKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _availableDaysController = TextEditingController();
  final TextEditingController _slotDurationController = TextEditingController();
  final TextEditingController _onlineFeeController = TextEditingController();
  final TextEditingController _clinicController = TextEditingController();
  String scheduleType;
  List<String> scheduleTypeList = [
    'Online',
    'On Site'
  ];

  String selectedDay;
  List<String> daysList = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday'
  ];

  // final timeFormat = DateFormat("HH:mm");
  final timeFormat = DateFormat.jm();
  String fromTime ;
  String toTime;

  final slidableController = SlidableController();
  final _scrollController = ScrollController();

  bool daysCheckerError = false;
  bool daysChecker = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);

    });
    getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
        getDoctorProfileRepo);
  }
  bool addChecker = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(loaderController)=> ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Schedule',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: (){
                    setState(() {
                      scheduleType = null;
                      addChecker = !addChecker;
                    });
                  },
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: primaryColor,
                    child: Icon(
                        addChecker
                            ?Icons.rotate_left_outlined
                            :Icons.add,
                        color:Colors.white),
                  ),
                ),
              )
            ],
          ),
          resizeToAvoidBottomInset: false,
          body: loaderController.dataLoader
              ?Center(child: CircularProgressIndicator())
              :FadedSlideAnimation(
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: scheduleKey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding:  EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        addChecker
                            ?Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Column(
                                children: [

                                  ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          hintText: 'Select Schedule Type',
                                          hintStyle: TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                        ),
                                        // isExpanded: true,
                                        focusColor: Colors.white,
                                        // dropdownColor: Colors.grey.withOpacity(0.2),
                                        // iconSize: 10,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 17
                                        ),
                                        iconEnabledColor: Colors.black,
                                        value: scheduleType,
                                        items: scheduleTypeList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style:
                                                  TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (String value) {
                                          print(value);
                                          setState(() {
                                            scheduleType = value;
                                          });
                                        },
                                        validator: (String value) {
                                          if (value == null) {
                                            return 'Field is Required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.0),
                                  scheduleType == null
                                      ? SizedBox()
                                      : scheduleType == 'Online'
                                      ? Column(
                                    children: [
                                      /// serial days
                                      ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),
                                              fillColor: Colors.grey.withOpacity(0.2),
                                              filled: true,
                                              hintText: 'Select Day',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4))),
                                            ),
                                            // isExpanded: true,
                                            focusColor: Colors.white,
                                            // dropdownColor: Colors.grey.withOpacity(0.2),
                                            // iconSize: 10,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17
                                            ),
                                            iconEnabledColor: Colors.black,
                                            value: selectedDay,
                                            items: daysList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style:
                                                      TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                            onChanged: (String value) {
                                              print(value);
                                              setState(() {
                                                selectedDay = value;
                                              });
                                            },
                                            validator: (String value) {
                                              if (value == null) {
                                                return 'Field is Required';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),

                                      /// Time Slot Duration (minutes)
                                      EntryField(
                                        textInputFormatter: LengthLimitingTextInputFormatter(2),
                                        color: Colors.grey.withOpacity(0.2),
                                        controller: _slotDurationController,
                                        textInputType: TextInputType.number,
                                        hint: 'Time Slot Duration (minutes)',
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Field is Required';
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      /// fees
                                      EntryField(
                                        textInputFormatter: LengthLimitingTextInputFormatter(6),
                                        color: Colors.grey.withOpacity(0.2),
                                        controller: _onlineFeeController,
                                        textInputType: TextInputType.number,
                                        hint: 'Fee',
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Field is Required';
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      DateTimeField(
                                        // initialValue:
                                        // DateTime.now(),
                                        onChanged: (value) {
                                          setState(() {
                                            // fromTime = value
                                            //     .toString()
                                            //     .substring(
                                            //     11, 19);
                                            // fromTime = DateFormat.Hm(DateTime.parse(value));

                                          });
                                        },
                                        style:
                                        TextStyle(
                                            color: Colors.black,
                                            fontSize: 17
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          hintText: 'Start Time',
                                          hintStyle:
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                        ),
                                        format: timeFormat,
                                        onShowPicker: (context,
                                            currentValue) async {
                                          final time =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay
                                                .fromDateTime(
                                                currentValue ??
                                                    DateTime
                                                        .now()),
                                          );
                                          setState(() {
                                            fromTime = DateTimeField
                                                .convert(time).toString().substring(11);
                                          });
                                          print('StartTime--->>${fromTime.substring(0,5)}');
                                          return DateTimeField
                                              .convert(time);
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Field is Required';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      DateTimeField(
                                        // initialValue:
                                        // DateTime.now(),
                                        onChanged: (value) {
                                          setState(() {
                                            // toTime = value
                                            //     .toString()
                                            //     .substring(
                                            //     11, 19);
                                            // print('EndTime--->>$value');
                                            // print('EndTime--->>$toTime');
                                          });
                                        },
                                        style:
                                        TextStyle(
                                            color: Colors.black,
                                            fontSize: 17
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          hintText: 'End Time',
                                          hintStyle:
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                        ),
                                        format: timeFormat,
                                        onShowPicker: (context,
                                            currentValue) async {
                                          final time =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay
                                                .fromDateTime(
                                                currentValue ??
                                                    DateTime
                                                        .now()),
                                          );
                                          setState(() {
                                            toTime = DateTimeField
                                                .convert(time).toString().substring(11);
                                          });
                                          print('EndTime--->>$toTime');
                                          return DateTimeField
                                              .convert(time);
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Field is Required';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      CustomButton(
                                        label: loaderController.scheduleList.length == 0
                                            ?'Submit'
                                            :'Update',
                                        onTap: () {
                                          FocusScopeNode currentFocus = FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          if(scheduleKey.currentState.validate()) {
                                            final startTime = TimeOfDay(
                                                hour: int.parse(fromTime.substring(0,2).toString()),
                                                minute: int.parse(fromTime.substring(3,5).toString()));
                                            final endTime = TimeOfDay(
                                                hour: int.parse(toTime.substring(0,2).toString()),
                                                minute: int.parse(toTime.substring(3,5).toString()));
                                            final step = Duration(minutes: int.parse(_slotDurationController.text.toString()));

                                            final times = getTimes(startTime, endTime, step)
                                                .map((tod) => tod.format(context))
                                                .toList();
                                            setState(() {
                                              times.length = times.length-1;
                                            });
                                            print(times);
                                            print('${loaderController.scheduleList}');
                                            Get.find<LoaderController>().updateFormController(true);
                                            postMethod(
                                                context,
                                                scheduleSetService,
                                                {
                                                  'doctor_id': storageBox.read('doctor_id'),
                                                  'slot_type': 2,
                                                  'duration': _slotDurationController.text,
                                                  // 'serial_day': _availableDaysController.text,
                                                  'day': selectedDay,
                                                  'start_time': fromTime.substring(0,5).toString(),
                                                  'end_time': toTime.substring(0,5).toString(),
                                                  'fees': _onlineFeeController.text,
                                                  'type': 'online'
                                                },
                                                true,
                                                deleteScheduleRepo
                                            );
                                            Get.snackbar(
                                                'Success',
                                                'Successfully Done',
                                                backgroundColor: Colors.black.withOpacity(0.5),
                                                colorText: Colors.white
                                            );
                                            setState(() {
                                              _availableDaysController.clear();
                                              _slotDurationController.clear();
                                              _onlineFeeController.clear();
                                              fromTime = null;
                                              selectedDay = null;
                                              toTime = null;
                                            });
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  )
                                      : loaderController.clinicTypeList.length == 0
                                      ? Text(
                                    'Add clinics first if you want to add schedule for physical appointments',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(color: Theme.of(context).disabledColor),
                                  )
                                      : Column(
                                    children: [

                                      ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),
                                              fillColor: Colors.grey.withOpacity(0.2),
                                              filled: true,
                                              hintText: 'Select Clinic',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4))),
                                            ),
                                            // isExpanded: true,
                                            focusColor: Colors.white,
                                            // dropdownColor: Colors.grey.withOpacity(0.2),
                                            // iconSize: 10,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17
                                            ),
                                            iconEnabledColor: Colors.black,
                                            value: loaderController.clinicType,
                                            items: loaderController.clinicTypeList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style:
                                                      TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                            onChanged: (String value) {
                                              print(value);
                                              setState(() {
                                                loaderController.clinicType = value;
                                              });
                                            },
                                            validator: (String value) {
                                              if (value == null) {
                                                return 'Field is Required';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),

                                      /// serial days
                                      ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.symmetric(
                                                  vertical: 17.0, horizontal: 10.0),
                                              fillColor: Colors.grey.withOpacity(0.2),
                                              filled: true,
                                              hintText: 'Select Day',
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 17
                                              ),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(4))),
                                            ),
                                            // isExpanded: true,
                                            focusColor: Colors.white,
                                            // dropdownColor: Colors.grey.withOpacity(0.2),
                                            // iconSize: 10,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 17
                                            ),
                                            iconEnabledColor: Colors.black,
                                            value: selectedDay,
                                            items: daysList
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                                  return DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(
                                                      value,
                                                      style:
                                                      TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 17
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                            onChanged: (String value) {
                                              print(value);
                                              setState(() {
                                                selectedDay = value;
                                              });
                                            },
                                            validator: (String value) {
                                              if (value == null) {
                                                return 'Field is Required';
                                              } else {
                                                return null;
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20.0),

                                      /// Time Slot Duration (minutes)
                                      EntryField(
                                        textInputFormatter: LengthLimitingTextInputFormatter(2),
                                        color: Colors.grey.withOpacity(0.2),
                                        controller: _slotDurationController,
                                        textInputType: TextInputType.number,
                                        hint: 'Time Slot Duration (minutes)',
                                        validator: (value){
                                          if(value.isEmpty){
                                            return 'Field is Required';
                                          }else{
                                            return null;
                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      DateTimeField(
                                        onChanged: (value) {
                                          setState(() {

                                          });
                                        },
                                        style:
                                        TextStyle(
                                            color: Colors.black,
                                            fontSize: 17
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          hintText: 'Start Time',
                                          hintStyle:
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                        ),
                                        format: timeFormat,
                                        onShowPicker: (context,
                                            currentValue) async {
                                          final time =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay
                                                .fromDateTime(
                                                currentValue ??
                                                    DateTime
                                                        .now()),
                                          );
                                          setState(() {
                                            fromTime = DateTimeField
                                                .convert(time).toString().substring(11);
                                          });
                                          print('StartTime--->>${fromTime.substring(0,5)}');
                                          return DateTimeField
                                              .convert(time);
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Field is Required';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      DateTimeField(
                                        onChanged: (value) {
                                          setState(() {
                                          });
                                        },
                                        style:
                                        TextStyle(
                                            color: Colors.black,
                                            fontSize: 17
                                        ),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(4),
                                            borderSide: BorderSide.none,
                                          ),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          hintText: 'End Time',
                                          hintStyle:
                                          TextStyle(
                                              color: Colors.black,
                                              fontSize: 17
                                          ),
                                        ),
                                        format: timeFormat,
                                        onShowPicker: (context,
                                            currentValue) async {
                                          final time =
                                          await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay
                                                .fromDateTime(
                                                currentValue ??
                                                    DateTime
                                                        .now()),
                                          );
                                          setState(() {
                                            toTime = DateTimeField
                                                .convert(time).toString().substring(11);
                                          });
                                          print('EndTime--->>$toTime');
                                          return DateTimeField
                                              .convert(time);
                                        },
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Field is Required';
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(height: 20.0),

                                      CustomButton(
                                        label: loaderController.scheduleList.length == 0
                                            ?'Submit'
                                            :'Update',
                                        onTap: () {
                                          FocusScopeNode currentFocus = FocusScope.of(context);
                                          if (!currentFocus.hasPrimaryFocus) {
                                            currentFocus.unfocus();
                                          }
                                          print(getDoctorProfileModal.data.clinics
                                          [loaderController.clinicTypeList
                                              .indexOf(loaderController.clinicType)].id);
                                          if(scheduleKey.currentState.validate()) {
                                            final startTime = TimeOfDay(
                                                hour: int.parse(fromTime.substring(0,2).toString()),
                                                minute: int.parse(fromTime.substring(3,5).toString()));
                                            final endTime = TimeOfDay(
                                                hour: int.parse(toTime.substring(0,2).toString()),
                                                minute: int.parse(toTime.substring(3,5).toString()));
                                            final step = Duration(minutes: int.parse(_slotDurationController.text.toString()));

                                            final times = getTimes(startTime, endTime, step)
                                                .map((tod) => tod.format(context))
                                                .toList();
                                            setState(() {
                                              times.length = times.length-1;
                                            });
                                            print(times);
                                            print('${loaderController.scheduleList}');
                                            Get.find<LoaderController>().updateFormController(true);
                                            postMethod(
                                                context,
                                                scheduleSetService,
                                                {
                                                  'doctor_id': storageBox.read('doctor_id'),
                                                  'slot_type': 2,
                                                  'duration': _slotDurationController.text,
                                                  // 'serial_day': _availableDaysController.text,
                                                  'day': selectedDay,
                                                  'start_time': fromTime.substring(0,5).toString(),
                                                  'end_time': toTime.substring(0,5).toString(),
                                                  'type': 'onsite',
                                                  'clinic_id': getDoctorProfileModal.data.clinics
                                                  [loaderController.clinicTypeList
                                                      .indexOf(loaderController.clinicType)].id
                                                },
                                                true,
                                                deleteScheduleRepo
                                            );
                                            Get.snackbar(
                                                'Success',
                                                'Successfully Done',
                                                backgroundColor: Colors.black.withOpacity(0.5),
                                                colorText: Colors.white
                                            );
                                            setState(() {
                                              _availableDaysController.clear();
                                              _slotDurationController.clear();
                                              loaderController.clinicType = null;
                                              fromTime = null;
                                              toTime = null;
                                            });

                                          }
                                        },
                                      ),
                                      SizedBox(height: 20.0),
                                    ],
                                  ),
                                ],
                              ),
                            )
                            :SizedBox(),
                        SizedBox(height: 30,),
                        getDoctorProfileModal.data.schedules.length == 0
                            ?SizedBox()
                            :Padding(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      offset: Offset(0,1),
                                      blurRadius: 9,
                                      spreadRadius: 3
                                  )
                                ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Wrap(
                                children: List.generate(getDoctorProfileModal.data.schedules.length, (index) {
                                  return Container(
                                    width: double.infinity,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                                onTap: (){
                                                  Get.find<LoaderController>().updateFormController(true);
                                                  postMethod(
                                                      context,
                                                      scheduleDeleteService,
                                                      {
                                                        'schedule_id':
                                                        getDoctorProfileModal.data.schedules[index].id,
                                                      },
                                                      true,
                                                      deleteScheduleRepo
                                                  );
                                                  Get.snackbar(
                                                      'Success',
                                                      'Successfully Done',
                                                      backgroundColor: Colors.black.withOpacity(0.5),
                                                      colorText: Colors.white
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,size: 30,))
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Type:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                    color: Theme.of(context).disabledColor,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${getDoctorProfileModal.data.schedules
                                                [index].type.toUpperCase()}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Created at:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                    color: Theme.of(context).disabledColor,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${getDoctorProfileModal.data.schedules
                                                [index].updatedAt.toString().substring(0,10)}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'For:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                    color: Theme.of(context).disabledColor,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${getDoctorProfileModal.data.schedules
                                                [index].day}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 8,),
                                        getDoctorProfileModal.data.schedules
                                        [index].type.toString() == 'online'
                                            ?Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Fee:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                        color: Theme.of(context).disabledColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Rs. ${getDoctorProfileModal.data.schedules
                                                    [index].fees}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(fontSize: 17),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        )
                                            :Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Clinic:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                        color: Theme.of(context).disabledColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${getDoctorProfileModal.data.schedules
                                                    [index].clinic.name}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(fontSize: 17),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Address:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                        color: Theme.of(context).disabledColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${getDoctorProfileModal.data.schedules
                                                    [index].clinic.address}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(fontSize: 17),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8,),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    'Fee:',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(
                                                        color: Theme.of(context).disabledColor,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    'Rs. ${getDoctorProfileModal.data.schedules
                                                    [index].clinic.fees}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle2
                                                        .copyWith(fontSize: 17),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                          ],
                                        ),

                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Slot Duration:',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(
                                                    color: Theme.of(context).disabledColor,
                                                    fontSize: 15),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${getDoctorProfileModal.data.schedules
                                                [index].duration} min',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle2
                                                    .copyWith(fontSize: 17),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Wrap(
                                          children: List.generate(getDoctorProfileModal.data.schedules
                                          [index].serialOrSlot.length,
                                                  (innerIndex){
                                                return Padding(
                                                  padding: const EdgeInsets.fromLTRB(0, 7, 5, 7),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: primaryColor,
                                                        borderRadius: BorderRadius.circular(5)
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                        '${getDoctorProfileModal.data.schedules
                                                        [index].serialOrSlot[innerIndex]}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                        index == (loaderController.scheduleList.length-1)
                                            ?SizedBox()
                                            :Padding(
                                          padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                          child: Divider(color: Colors.grey.withOpacity(0.3),),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            beginOffset: Offset(0, 0.3),
            endOffset: Offset(0, 0),
            slideCurve: Curves.linearToEaseOut,
          ),
        ),
      ),
    );
  }

  // String selectedDay;
  // List<DaySelector> daysList = [
  //   DaySelector(
  //       title: 'Monday',
  //       selected: false
  //   ),
  //   DaySelector(
  //       title: 'Tuesday',
  //       selected: false
  //   ),
  //   DaySelector(
  //       title: 'Wednesday',
  //       selected: false
  //   ),
  //   DaySelector(
  //       title: 'Thursday',
  //       selected: false
  //   ),
  //   DaySelector(
  //       title: 'Friday',
  //       selected: false
  //   ),
  //   DaySelector(
  //       title: 'Saturday',
  //       selected: false
  //   ),
  //   DaySelector(
  //       title: 'Sunday',
  //       selected: false
  //   ),
  // ];
  Iterable<TimeOfDay> getTimes(TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }
}
