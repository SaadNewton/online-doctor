// @dart=2.9
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/approve_appointment_repo.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/repositories/remove_appointment_repo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Locale/locale.dart';


// class Appointment {
//   String? heading;
//   List<AppointmentTile> appts;
//
//   Appointment(this.heading, this.appts);
// }



class MyAppointmentsBody extends StatefulWidget {
  @override
  _MyAppointmentsBodyState createState() => _MyAppointmentsBodyState();
}

class AppointmentTile {
  String name;
  String disease;
  String dateTime;

  AppointmentTile(this.name, this.disease, this.dateTime);
}

class _MyAppointmentsBodyState extends State<MyAppointmentsBody> {
  String disease;


  @override
  void initState(){

    Get.find<LoaderController>().updateDataController(true);
    getMethod(
        context,
        getAllAppointmentsService,
        {'doctor_id': 49},
        true,
        getAllLAppointmentRepo);
    super.initState();
  }
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Appointments',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.history),
              color: Theme.of(context).primaryColor,
              onPressed: () {},
            )
          ],
        ),
        body: GetBuilder<LoaderController>(
          init:LoaderController(),
          builder:(_)=>_.dataLoader ? Center(child: CircularProgressIndicator())
              : getAllAppointmentsModel.data == null ? Container(
            child: Center(child: Text('Record Not Found',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(
                  fontWeight: FontWeight.w600),
            )),)
              : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: getAllAppointmentsModel.data.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 16),
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    // FadedScaleAnimation(
                                    //   Image.asset(
                                    //     _Appointments[index].image,
                                    //     scale: 6,
                                    //   ),
                                    //   durationInMilliseconds: 400,
                                    // ),
                                    SizedBox(
                                      width: 12,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [

                                        Row(
                                          children: [
                                            Text('Name:  '),

                                            Text(
                                              getAllAppointmentsModel.data[index].name,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                              Row(
                                children: [
                                  Text('Disease:  ',
                                  ),
                                  getAllAppointmentsModel.data[index]
                                      .disease == null ? SizedBox()
                                           : Text(
                                              getAllAppointmentsModel.data[index]
                                                  .disease,
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                        fontWeight: FontWeight.w600),
                                            ),
                                ],
                              ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text('Date:  '),
                                            Text(
                                                getAllAppointmentsModel.data[index].bookingDate,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1
                                                  .copyWith(
                                                  fontWeight: FontWeight.w600),

                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ],
                                ),

                                Align(
                                    alignment: Alignment.topRight,
                                    child: FadedScaleAnimation(
                                      Icon(
                                        Icons.more_vert,
                                        color: Theme.of(context).primaryColor,
                                        size: 18,
                                      ),
                                      durationInMilliseconds: 400,
                                    )),

                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 40,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    color:   Theme.of(context).primaryColor
                                ),
                                child: Center(child: InkWell(
                                  child: Text('Accept',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                  onTap: (){
                                    ///............///

                                    postMethod(
                                      context,
                                        approveAppointmentService,
                                      {
                                        'doctor_id': getAllAppointmentsModel.data[index].doctorId,
                                        'appointment_id': getAllAppointmentsModel.data[index].id
                                      },
                                      true,
                                        approveAppointments);

                                  },
                                ),
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, PageRoutes.chatScreen);
                                },
                                // child: FadedScaleAnimation(
                                //   Icon(
                                //     Icons.cancel,
                                //     color: Theme.of(context)
                                //         .primaryColor,
                                //     size: 24,
                                //   ),
                                //   durationInMilliseconds: 400,
                                // ),

                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8)),
                                      color:   Theme.of(context).primaryColor
                                  ),
                                  child: Center(child: InkWell(
                                    child: Text('Cancel',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    ),
                                    onTap: (){
                                      postMethod(
                                        context,
                                          removeAppointmentService,
                                        {
                                          'doctor_id': getAllAppointmentsModel.data[index].doctorId,
                                          'appointment_id': getAllAppointmentsModel.data[index].id
                                        },
                                        true,
                                          removeAppointments
                                      );

                                      setState(() {

                                      });
                                    },
                                  ),
                                  ),
                                ),
                              )
                            ],

                          ),
                          // position + 0 != getAllAppointmentsModel.data!.length
                          Divider(
                            thickness: 8,
                          )
                          // : SizedBox.shrink(),

                        ],
                      );
                    }),

        ),
      );
  }
}
