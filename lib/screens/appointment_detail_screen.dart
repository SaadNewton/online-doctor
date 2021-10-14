//@dart=2.9
import 'package:animation_wrappers/Animations/faded_scale_animation.dart';
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:doctoworld_doctor/screens/chat_page.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/agora_repo.dart';
import 'package:doctoworld_doctor/repositories/approve_appointment_repo.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/repositories/get_notify_token_repo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final Appointments appointment;
  AppointmentDetailScreen({this.appointment});
  @override
  _AppointmentDetailScreenState createState() =>
      _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMethod(
        context,
        getNotifyTokenService,
        {
          'user_id': widget.appointment.customerId,
          'role':'customer'
        },
        false,
        getNotifyTokenRepo
    );
    getMethod(
        context,
        agoraService,
        null,
        false,
        getAgoraRepo
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Appointment Detail'),
        textTheme: Theme.of(context).textTheme,
        centerTitle: true,
        elevation: 8,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 20,
          ),
        ),
      ),
      body: FadedSlideAnimation(
        Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment Type',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.appointment.bookingType.toUpperCase()}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment For',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.appointment.name}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Disease',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.appointment.disease}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Appointment On',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            '${widget.appointment.bookingDate} | ${widget.appointment.timeSerial}',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            widget.appointment.isComplete != 1
                ?SizedBox()
                :widget.appointment.bookingType == 'onsite'
                ?Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                // title: '',
                                titleColor: customDialogQuestionColor,
                                descriptions: 'Is this appointment is completed?',
                                text: 'Yes',
                                functionCall: () {
                                  Navigator.pop(context);Navigator.pop(context);
                                  // Get.back();
                                  Get.find<LoaderController>().updateFormController(false);
                                  postMethod(
                                      context,
                                      changeAppointmentStatusService,
                                      {
                                        'is_complete':2,
                                        'appointment_id': widget.appointment.id
                                      },
                                      true,
                                      completeAppointmentRepo
                                  );
                                },
                                img: 'assets/dialog_Question Mark.svg',
                              );
                            });
                      },
                      child: Container(
                        height: 60,
                        color: Colors.green,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              'Tap to complete',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                  fontSize: 20,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
                :Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: (){
                            postMethod(
                                context,
                                fcmService,
                                {
                                  'notification': <String, dynamic>{
                                    'body': 'Your doctor is calling you for appointment',
                                    'title': 'Appointment'
                                  },
                                  'priority': 'high',
                                  'data': <String, dynamic>{
                                    'channel': Get.find<LoaderController>().agoraModel.channelName,
                                    'channel_token': Get.find<LoaderController>().agoraModel.token,
                                    'routeWeb': '/customer/approved/appointment/detail',
                                    'routeApp':'/joinVideo',
                                  },
                                  'to': Get.find<LoaderController>().otherRoleToken,
                                },
                                false,
                                method
                            );
                          },
                          child: Container(
                            height: 60,
                            color: Theme.of(context).backgroundColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.call,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Call',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ChatScreen(
                              appointment: widget.appointment,
                            ));

                            },
                          child: Container(
                            height: 60,
                            color: Theme.of(context).primaryColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.message,
                                  color: Theme.of(context).scaffoldBackgroundColor,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'Chat',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(
                                      fontSize: 20,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomDialogBox(
                                    // title: '',
                                    titleColor: customDialogQuestionColor,
                                    descriptions: 'Is this appointment is completed?',
                                    text: 'Yes',
                                    functionCall: () {
                                      Navigator.pop(context);
                                      // Get.back();
                                      Get.find<LoaderController>().updateFormController(false);
                                      postMethod(
                                          context,
                                          changeAppointmentStatusService,
                                          {
                                            'is_complete':2,
                                            'appointment_id': widget.appointment.id
                                          },
                                          true,
                                          completeAppointmentRepo
                                      );
                                    },
                                    img: 'assets/dialog_Question Mark.svg',
                                  );
                                });
                            },
                          child: Container(
                            height: 60,
                            color: Colors.green,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Icon(
                                //   Icons.check,
                                //   color: Theme.of(context).scaffoldBackgroundColor,
                                // ),
                                // SizedBox(
                                //   width: 20,
                                // ),
                                Expanded(
                                  child: Text(
                                    'Tap to complete',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                        fontSize: 18,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
        beginOffset: Offset(0, 0.3),
        endOffset: Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
