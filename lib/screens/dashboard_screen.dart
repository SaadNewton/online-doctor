//@dart=2.9
import 'dart:async';

import 'package:dio/dio.dart' as dio_instance;
import 'package:doctoworld_doctor/Auth/log_in_data/login_ui.dart';
import 'package:doctoworld_doctor/Auth/phone_auth_ui.dart';
import 'package:doctoworld_doctor/Components/custom_drawer.dart';
import 'package:doctoworld_doctor/repositories/getArticlesRepo.dart';
import 'package:doctoworld_doctor/screens/all_appointment_screen.dart';
import 'package:doctoworld_doctor/screens/article_detail_screen.dart';
import 'package:doctoworld_doctor/screens/articles_screen.dart';
import 'package:doctoworld_doctor/screens/new_appointments.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/check_doctor_status_repo.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/screens/education_form.dart';
import 'package:doctoworld_doctor/screens/experience%20_form.dart';
import 'package:doctoworld_doctor/screens/speciality_form.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<dynamic> dashboard = [
    {
      'text1': '0 PKR',
      'text2': 'Total Online Earn',
      'image': 'assets/orange.png',
      'icon': Icons.credit_card
    },
    {
      'text1': '0 PKR',
      'text2': 'Total Cash Earn',
      'image': 'assets/blue.png',
      'icon': Icons.account_balance_wallet_outlined
    },
    {
      'text1': '0',
      'text2': 'New Appointment',
      'image': 'assets/orange.png',
      'icon': Icons.group_rounded
    },
    {
      'text1': '',
      'text2': 'All Appointment',
      'image': 'assets/blue.png',
      'icon': Icons.reorder
    }
  ];

// final List<Color> colors = <Color>[customOrangeColor, primaryColor, Colors.red, Colors.green];
  final List<Color> color1 = <Color>[
    Color(0xff8E54E9),
    Color(0xff3A7BD5),
    Color(0xff2948FF),
    Color(0xff38EF7D)
  ];
  final List<Color> color2 = <Color>[
    Color(0xff4776E6),
    Color(0xff00D2FF),
    Color(0xff396AFC),
    Color(0xff11998E)
  ];


  viewChange(int index) {
    switch (index) {
      case 0:
        return {};
        break;
      case 1:
        return {};
        break;
      case 2:
        return {Get.to(MyAppointmentsBody())};
        break;
      case 3:
        return {Get.to(AllAppointmentScreen())};
        break;
    }
  }

  checkDoctorStatus() {
    if (!Get.find<LoaderController>().checkDoctorStatusLoader) {
      print('aaa');
      getMethod(context, checkDoctorStatusService,
          {'doctor_id': storageBox.read('doctor_id')}, true, doctorStatusRepo);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(
        context,
        getAllAppointmentsService,
        {'doctor_id': storageBox.read('doctor_id')},
        true,
        getAllLAppointmentRepo);
    getMethod(
        context,
        allDoctorsArticlesService,
        null,
        false,
        getAllDoctorsArticlesRepo);
    super.initState();
    if (!storageBox.hasData('approved')) {
      Timer.periodic(Duration(seconds: 2), (Timer t) {
        checkDoctorStatus();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.find<LoaderController>().updateCheckDoctorStatusLoader(true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      builder: (loaderController) => !loaderController.checkDoctorStatusLoader
          ? Scaffold(
              backgroundColor: backgroundColor,
              body: SafeArea(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/doctor_logo.png',
                      width: MediaQuery.of(context).size.width * .4,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                        backgroundColor: primaryColor,
                        radius: 150,
                        child: Text(
                          'Please wait\n Your request has been sent for approval.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                  ],
                )),
              ))
          : Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                title: Text(
                  'Dashboard',
                ),
                textTheme: Theme.of(context).textTheme,
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
              drawer: CustomDrawer(),
              body: loaderController.dataLoader
                  ? Center(child: CircularProgressIndicator())
                  : Container(
                      color: Color(0xffF4F7F8),
                      height: MediaQuery.of(context).size.height,
                      width: double.infinity,
                      child: ListView(
                        children: [
                          ///---earnings
                          // InkWell(
                          //   onTap: () {},
                          //   child: Container(
                          //     child: Padding(
                          //       padding: const EdgeInsets.symmetric(
                          //           horizontal: 15.0),
                          //       child: SizedBox(
                          //         height: 140,
                          //         child: Column(children: [
                          //           Expanded(
                          //             child: Padding(
                          //               padding: const EdgeInsets.fromLTRB(
                          //                   0, 10, 0, 0),
                          //               child: Container(
                          //                 height: double.infinity,
                          //                 width: double.infinity,
                          //                 decoration: BoxDecoration(
                          //                     image: DecorationImage(
                          //                         image: AssetImage('assets/orange.png'),
                          //                         fit: BoxFit.fill),
                          //                     //  color: Colors.white,
                          //                     borderRadius:
                          //                     BorderRadius.circular(20),
                          //                     boxShadow: [
                          //                       BoxShadow(
                          //                           color: Colors.grey
                          //                               .withOpacity(0.2),
                          //                           spreadRadius: 2,
                          //                           blurRadius: 5)
                          //                     ],
                          //                     gradient: LinearGradient(
                          //                       begin: Alignment.topRight,
                          //                       end: Alignment.bottomLeft,
                          //                       colors: [
                          //                         Color(0xff8E54E9),
                          //                         Color(0xff4776E6),
                          //                       ],
                          //                     )),
                          //                 child: Padding(
                          //                   padding:
                          //                   const EdgeInsets.fromLTRB(15, 15, 15, 10),
                          //                   child: Column(
                          //                     mainAxisAlignment:
                          //                     MainAxisAlignment
                          //                         .end,
                          //                     crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                     children: [
                          //                       Row(
                          //                         mainAxisAlignment:
                          //                         MainAxisAlignment
                          //                             .spaceBetween,
                          //                         children: [
                          //                           Expanded(
                          //                             child: Text(
                          //                               'EARNINGS',
                          //                               style: TextStyle(
                          //                                   color: Colors.white,
                          //                                   fontSize: 22,
                          //                                   fontWeight:
                          //                                   FontWeight
                          //                                       .w500),
                          //                             ),
                          //                           ),
                          //                           Icon(
                          //                             Icons.credit_card,
                          //                             color: Colors.white38,
                          //                             size: 60,
                          //                           ),
                          //                         ],
                          //                       ),
                          //                     ],
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ),
                          //         ]),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          ///---appointments
                          InkWell(
                            onTap: () {
                              Get.to(AllAppointmentScreen());
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SizedBox(
                                  height: 140,
                                  child: Column(children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage('assets/blue.png'),
                                                  fit: BoxFit.fill),
                                              //  color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 5)
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff3A7BD5),
                                                  Color(0xff00D2FF),
                                                ],
                                              )),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(15, 15, 15, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'APPOINTMENTS',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.app_registration,
                                                      color: Colors.white38,
                                                      size: 60,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                          ///---articles
                          InkWell(
                            onTap: () {
                              Get.to(ArticlesScreen());
                            },
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: SizedBox(
                                  height: 140,
                                  child: Column(children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 0),
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage('assets/blue.png'),
                                                  fit: BoxFit.fill),
                                              //  color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.2),
                                                    spreadRadius: 2,
                                                    blurRadius: 5)
                                              ],
                                              gradient: LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                colors: [
                                                  Color(0xff2948FF),
                                                  Color(0xff396AFC),
                                                ],
                                              )),
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.fromLTRB(15, 15, 15, 10),
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .end,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        'MY ARTICLES',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                            FontWeight
                                                                .w500),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.article_outlined,
                                                      color: Colors.white38,
                                                      size: 60,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),

                          ///all-articles
                          getAllDoctorsArticles.data == null
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30,left: 15),
                                    child: Text(
                                      'All ARTICLES',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight:
                                          FontWeight
                                              .w500),
                                    ),
                                  ),
                                  SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Wrap(
                            children: List.generate(getAllDoctorsArticles.data.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.fromLTRB(15, 12, 0, 20),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width*.4,
                                        height: MediaQuery.of(context).size.height*.28,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.grey.withOpacity(0.5),
                                              blurRadius: 9,
                                              spreadRadius: 3
                                            )
                                          ]
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              getAllDoctorsArticles.data[index].image == null
                                                  ? SizedBox()
                                                  : Container(
                                                width: MediaQuery.of(context).size.width*.2,
                                                height: MediaQuery.of(context).size.height*.1,
                                                    child: Image.network(
                                                    '$mediaUrl${getAllDoctorsArticles.data[index].image}',
                                                width: MediaQuery.of(context).size.width*.2,
                                              ),
                                                  ),
                                              SizedBox(height: 8,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${getAllDoctorsArticles.data[index].title}',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      '${getAllDoctorsArticles.data[index].description}',
                                                      maxLines: 2,
                                                     softWrap: true,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.black
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 8,),
                                              Spacer(),
                                              InkWell(
                                                onTap: (){
                                                  Get.to(ArticleDetailScreen(
                                                    getAllDoctorsArticlesData: getAllDoctorsArticles.data[index],));
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: primaryColor,
                                                    borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'View Details',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ),
                                      ),
                                    );
                            }),
                          ),
                                  ),
                                ],
                              )
                        ],
                      )
                    ),
            ),
    );
  }
}
