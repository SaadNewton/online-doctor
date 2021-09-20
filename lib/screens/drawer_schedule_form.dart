//@dart=2.9
import 'dart:math';

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DrawerScheduleForm extends StatefulWidget {
  @override
  _DrawerScheduleFormState createState() => _DrawerScheduleFormState();
}

class _DrawerScheduleFormState extends State<DrawerScheduleForm> {

  final scheduleKey = GlobalKey<FormState>();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _availableDaysController = TextEditingController();
  final TextEditingController _slotDurationController = TextEditingController();
  final TextEditingController _clinicController = TextEditingController();
  String scheduleType;
  List<String> scheduleTypeList = [
    'Time',
    'Serial'
  ];

  // final timeFormat = DateFormat("HH:mm");
  final timeFormat = DateFormat.jm();
  String fromTime ;
  String toTime;

  final slidableController = SlidableController();
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomInset: false,
      body: FadedSlideAnimation(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                        children: [

                          /// clinic
                          EntryField(
                            color: Colors.grey.withOpacity(0.2),
                            controller: _clinicController,
                            hint: 'Clinic Name',
                            validator: (value){
                              if(value.isEmpty){
                                return 'Field is Required';
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),

                          /// location
                          EntryField(
                            color: Colors.grey.withOpacity(0.2),
                            controller: _locationController,
                            hint: 'Clinic Address',
                            validator: (value){
                              if(value.isEmpty){
                                return 'Field is Required';
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),

                          ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 17.0, horizontal: 10.0),
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  filled: true,
                                  hintText: 'Select one',
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

                          /// Serial Available For Next How Many Days
                          EntryField(
                            color: Colors.grey.withOpacity(0.2),
                            controller: _availableDaysController,
                            textInputType: TextInputType.number,
                            hint: 'Available For Next How Many Days',
                            validator: (value){
                              if(value.isEmpty){
                                return 'Field is Required';
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),

                          /// Time Slot Duration (minutes)
                          EntryField(
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
                              print('StartTime--->>$fromTime');
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
                                print('EndTime--->>$value');
                                print('EndTime--->>$toTime');
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
                            label: 'Submit',
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
                                print(times);
                                setState(() {
                                  scheduleList.add(
                                      {
                                        'clinicName': _clinicController.text,
                                        'clinicAddress': _locationController.text,
                                        'scheduleType': scheduleType,
                                        'noOfDays': _availableDaysController.text,
                                        'slotDuration': _slotDurationController.text,
                                        'startTime':fromTime,
                                        'endTime':toTime,
                                        'slots': times
                                      }
                                  );

                                  _clinicController.clear();
                                  _locationController.clear();
                                  _availableDaysController.clear();
                                  _slotDurationController.clear();
                                  scheduleType = null;
                                  fromTime = null;
                                  toTime = null;
                                });
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                        ],
                      ),
                    ),
                    scheduleList.length == 0
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
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              SizedBox(height: 8,),
                              Wrap(
                                children: List.generate(scheduleList.length, (index) {
                                  return Slidable(
                                    closeOnScroll: true,
                                    controller: slidableController,
                                    actionPane: SlidableDrawerActionPane(),
                                    actionExtentRatio: 0.2,
                                    secondaryActions: <Widget>[
                                      IconSlideAction(
                                        color: Colors.blue,
                                        icon: Icons.edit,
                                        onTap: () {
                                          setState(() {
                                            _clinicController.text = scheduleList[index]['clinicName'];
                                            _locationController.text = scheduleList[index]['clinicAddress'];
                                            scheduleType = scheduleList[index]['scheduleType'];
                                            _availableDaysController.text = scheduleList[index]['noOfDays'];
                                            _slotDurationController.text = scheduleList[index]['slotDuration'];
                                            // fromTime = scheduleList[index]['startTime'];
                                            // toTime = scheduleList[index]['endTime'];

                                            _scrollController.animateTo(
                                              _scrollController.position.minScrollExtent,
                                              curve: Curves.easeOut,
                                              duration: const Duration(milliseconds: 500),
                                            );

                                            scheduleList.removeAt(index);
                                          });
                                        },
                                      ),
                                      IconSlideAction(
                                        color: Colors.red,
                                        icon: Icons.delete,
                                        onTap: () {
                                          setState(() {
                                            scheduleList.removeAt(index);
                                          });
                                        },
                                      ),
                                    ],
                                    child: Builder(
                                      builder:(BuildContext contextS)=>
                                          InkWell(
                                            onTap: (){
                                              print('CLICK ${index}');
                                              Slidable.of(contextS).open();
                                            },
                                            child: Container(
                                              color: Colors.white,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${scheduleList[index]['clinicName']}',
                                                          style: TextStyle(
                                                              color: Colors.black,
                                                              fontSize: 14,
                                                              fontWeight: FontWeight.bold
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.fromLTRB(5, 2, 5, 0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${scheduleList[index]['clinicAddress']}',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 11,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Wrap(
                                                    children: List.generate(scheduleList[index]['slots'].length, (innerIndex){
                                                      return Padding(
                                                        padding: const EdgeInsets.fromLTRB(5, 7, 5, 0),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: primaryColor,
                                                              borderRadius: BorderRadius.circular(5)
                                                          ),
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(
                                                              '${scheduleList[index]['slots'][innerIndex]}',
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
                                                  index == (scheduleList.length-1)
                                                      ?SizedBox()
                                                      :Padding(
                                                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                                                    child: Divider(color: Colors.grey.withOpacity(0.3),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 80.0),
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
      floatingActionButton: scheduleList.length == 0
          ?SizedBox()
          :FloatingActionButton(
        backgroundColor: primaryColor,
        child: Icon(
          Icons.check,
          color: Colors.white,
        ),
        onPressed: (){
          if(
          educationList.length != 0 &&
              experienceList.length != 0 &&
              specialityList.length != 0 &&
              scheduleList.length != 0
          ){
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: 'SUCCESS!',
                    titleColor: customDialogSuccessColor,
                    descriptions: 'Profile Updated Successfully',
                    text: 'Ok',
                    functionCall: () {
                      Navigator.pop(context);
                      Get.offAll(Dashboard());
                    },
                    img: 'assets/dialog_success.svg',
                  );
                });
          }else{
            showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return CustomDialogBox(
                    title: 'FAILED!',
                    titleColor: customDialogErrorColor,
                    descriptions: 'Please Fill All Forms',
                    text: 'Ok',
                    functionCall: () {
                      Navigator.pop(context);
                    },
                    img: 'assets/dialog_error.svg',
                  );
                });
          }
        },
      ),
    );
  }
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