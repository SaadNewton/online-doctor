//@dart=2.9
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/approve_appointment_repo.dart';
import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
import 'package:doctoworld_doctor/repositories/remove_appointment_repo.dart';
import 'package:doctoworld_doctor/screens/appointment_detail_screen.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAppointmentScreen extends StatefulWidget {
  const AllAppointmentScreen({Key key}) : super(key: key);

  @override
  _AllAppointmentScreenState createState() => _AllAppointmentScreenState();
}

class _AllAppointmentScreenState extends State<AllAppointmentScreen>
    with SingleTickerProviderStateMixin {
  TabController allAppointmentTabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);
    });
    allAppointmentTabController = new TabController(length: 3, vsync: this);
    getMethod(
        context,
        getAllAppointmentsService,
        {'doctor_id': storageBox.read('doctor_id')},
        true,
        getAllLAppointmentRepo);
    getMethod(
        context,
        getDoneAppointmentsService,
        {'doctor_id': storageBox.read('doctor_id')},
        true,
        getDoneAppointmentRepo);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<LoaderController>(
        init: LoaderController(),
        builder:(loaderController)=> Scaffold(
          appBar: AppBar(
            title: Text('Appointments'),
            textTheme: Theme.of(context).textTheme,
            centerTitle: true,
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
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              children: [
                Container(
                  height: 53,
                  width: MediaQuery.of(context).size.width * 0.95,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            offset: Offset(0, 1),
                            blurRadius: 9,
                            spreadRadius: 2)
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: TabBar(
                    controller: allAppointmentTabController,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: Theme.of(context).textTheme.headline5.copyWith(
                        fontWeight: FontWeight.w600, color: Colors.white),
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: primaryColor),
                    tabs: [
                      Center(
                        child: new Text(
                          'New',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Center(
                        child: new Text(
                          'Pending',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      Center(
                        child: new Text(
                          'Completed',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                    onTap: (v) {
                      print(v.toString());
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      loaderController.dataLoader
                          ? Center(child: CircularProgressIndicator())
                          : getAllAppointmentsModel.data == null
                          ? Container(
                        child: Center(
                            child: Text(
                              'Record Not Found',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.w600),
                            )),
                      )
                          : ListView.builder(
                          itemCount: getAllAppointmentsModel.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 9,
                                          spreadRadius: 3),
                                    ]),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0, vertical: 16),
                                      child: Row(
                                        children: [
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
                                                    getAllAppointmentsModel
                                                        .data[index].name,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Disease:  ',
                                                  ),
                                                  getAllAppointmentsModel
                                                      .data[index]
                                                      .disease ==
                                                      null
                                                      ? SizedBox()
                                                      : Text(
                                                    getAllAppointmentsModel
                                                        .data[index].disease,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight
                                                            .w600),
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
                                                    getAllAppointmentsModel
                                                        .data[index].bookingDate,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Text('Time:  '),
                                                  Text(
                                                    getAllAppointmentsModel
                                                        .data[index].timeSerial,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .subtitle1
                                                        .copyWith(
                                                        fontWeight:
                                                        FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
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
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              color:
                                              Theme.of(context).primaryColor),
                                          child: Center(
                                            child: InkWell(
                                              child: Text(
                                                'Accept',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              onTap: () {
                                                ///............///

                                                Get.find<LoaderController>()
                                                    .updateFormController(true);
                                                postMethod(
                                                    context,
                                                    approveAppointmentService,
                                                    {
                                                      'doctor_id':
                                                      getAllAppointmentsModel
                                                          .data[index].doctorId,
                                                      'appointment_id':
                                                      getAllAppointmentsModel
                                                          .data[index].id
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
                                        Container(
                                          height: 40,
                                          width: 80,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)),
                                              color:
                                              Theme.of(context).primaryColor),
                                          child: Center(
                                            child: InkWell(
                                              child: Text(
                                                'Reject',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              onTap: () {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return CustomDialogBox(
                                                        titleColor:
                                                        customDialogQuestionColor,
                                                        descriptions:
                                                        'Are you sure You want to delete this appointment?',
                                                        text: 'Remove',
                                                        functionCall: () {
                                                          Navigator.pop(context);
                                                          Get.find<
                                                              LoaderController>()
                                                              .updateFormController(
                                                              true);

                                                          postMethod(
                                                              context,
                                                              removeAppointmentService,
                                                              {
                                                                'doctor_id':
                                                                getAllAppointmentsModel
                                                                    .data[index]
                                                                    .doctorId,
                                                                'appointment_id':
                                                                getAllAppointmentsModel
                                                                    .data[index]
                                                                    .id
                                                              },
                                                              true,
                                                              removeAppointments);

                                                          setState(() {});
                                                        },
                                                        img:
                                                        'assets/dialog_Question Mark.svg',
                                                      );
                                                    });
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                      loaderController.dataLoader
                          ? Center(child: CircularProgressIndicator())
                          : getDoneAppointmentsModel.data == null
                          ? Container(
                        child: Center(
                            child: Text(
                              'Record Not Found',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.w600),
                            )),
                      )
                          :ListView.builder(
                          itemCount: getDoneAppointmentsModel.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return getDoneAppointmentsModel.data[index].isComplete == 1
                                ?Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(AppointmentDetailScreen(appointment: getDoneAppointmentsModel.data[index],));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 9,
                                            spreadRadius: 3),
                                      ]),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 16),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${getDoneAppointmentsModel.data[index].name}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${getDoneAppointmentsModel.data[index].bookingDate}',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .subtitle1
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${getDoneAppointmentsModel.data[index].timeSerial}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                :SizedBox();
                          }),
                      loaderController.dataLoader
                          ? Center(child: CircularProgressIndicator())
                          : getDoneAppointmentsModel.data == null
                          ? Container(
                        child: Center(
                            child: Text(
                              'Record Not Found',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontWeight: FontWeight.w600),
                            )),
                      )
                          :ListView.builder(
                          itemCount: getDoneAppointmentsModel.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return getDoneAppointmentsModel.data[index].isComplete == 2
                                ?Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                              child: InkWell(
                                onTap: () {
                                  Get.to(AppointmentDetailScreen(appointment: getDoneAppointmentsModel.data[index],));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            blurRadius: 9,
                                            spreadRadius: 3),
                                      ]),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12.0, vertical: 16),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        '${getDoneAppointmentsModel.data[index].name}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${getDoneAppointmentsModel.data[index].bookingDate}',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .subtitle1
                                                              .copyWith(
                                                              fontSize: 14,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w600),
                                                        ),
                                                      ),
                                                      Text(
                                                        '${getDoneAppointmentsModel.data[index].timeSerial}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                            fontSize: 14,
                                                            fontWeight:
                                                            FontWeight
                                                                .w600),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                                :SizedBox();
                          }),
                    ],
                    controller: allAppointmentTabController,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
