import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
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
  @override
  void initState(){

    Get.find<LoaderController>().updateDataController(true);
    getMethod(
        context,
        getAllAppointmentsService,
        {'doctor_id': 1, 'booking_date': "2021-06-29"},
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
          builder:(_)=>_.dataLoader ?Center(child: CircularProgressIndicator()): ListView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 2,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // Container(
                    //   width: MediaQuery.of(context).size.width,
                    //   padding: EdgeInsets.all(20.0),
                    //   color: Theme.of(context).primaryColorLight,
                    //   child: Text('Appointments',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodyText1!
                    //           .copyWith(fontSize: 15)),
                    // ),
                    ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: getAllAppointmentsModel.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, position) {
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
                                            Text(
                                              getAllAppointmentsModel.data![index].name!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle1!
                                                  .copyWith(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              getAllAppointmentsModel.data![index]
                                                  .disease!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2!
                                                  .copyWith(
                                                  fontSize: 12,
                                                  color: Theme.of(context)
                                                      .disabledColor),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                                getAllAppointmentsModel.data![index].bookingDate!
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
                                    child: Center(child: Text('Accept',
                                      style: TextStyle(color: Colors.white, fontSize: 12),
                                    )),
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
                                      child: Center(child: Text('Cancel',
                                        style: TextStyle(color: Colors.white, fontSize: 12),
                                      )),
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
                  ],
                );
              }),
        ),
      );
  }
}
