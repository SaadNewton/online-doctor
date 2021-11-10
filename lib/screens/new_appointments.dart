// // @dart=2.9
// import 'package:animation_wrappers/animation_wrappers.dart';
// import 'package:doctoworld_doctor/Components/custom_dialog.dart';
// import 'package:doctoworld_doctor/Locale/locale.dart';
// import 'package:doctoworld_doctor/Routes/routes.dart';
// import 'package:doctoworld_doctor/Theme/colors.dart';
// import 'package:doctoworld_doctor/controllers/loading_controller.dart';
// import 'package:doctoworld_doctor/data/global_data.dart';
// import 'package:doctoworld_doctor/repositories/approve_appointment_repo.dart';
// import 'package:doctoworld_doctor/repositories/get_all_appointments_repo.dart';
// import 'package:doctoworld_doctor/repositories/remove_appointment_repo.dart';
// import 'package:doctoworld_doctor/services/get_method_call.dart';
// import 'package:doctoworld_doctor/services/post_method_call.dart';
// import 'package:doctoworld_doctor/services/service_urls.dart';
// import 'package:doctoworld_doctor/storage/local_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
// import '../Locale/locale.dart';
//
// // class Appointment {
// //   String? heading;
// //   List<AppointmentTile> appts;
// //
// //   Appointment(this.heading, this.appts);
// // }
//
// class MyAppointmentsBody extends StatefulWidget {
//   @override
//   _MyAppointmentsBodyState createState() => _MyAppointmentsBodyState();
// }
//
// class AppointmentTile {
//   String name;
//   String disease;
//   String dateTime;
//
//   AppointmentTile(this.name, this.disease, this.dateTime);
// }
//
// class _MyAppointmentsBodyState extends State<MyAppointmentsBody> {
//   String disease;
//
//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       Get.find<LoaderController>().updateDataController(true);
//     });
//     getMethod(
//         context,
//         getAllAppointmentsService,
//         {'doctor_id': storageBox.read('doctor_id')},
//         true,
//         getAllLAppointmentRepo);
//     super.initState();
//   }
//
//   Widget build(BuildContext context) {
//     return GetBuilder<LoaderController>(
//       init: LoaderController(),
//       builder: (loaderController) => ModalProgressHUD(
//         inAsyncCall: loaderController.formLoader,
//         child: Scaffold(
//           appBar: AppBar(
//             automaticallyImplyLeading: false,
//             title: Text(
//               'Appointments',
//               style: TextStyle(color: Colors.black),
//             ),
//             centerTitle: true,
//             leading: InkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//                 size: 20,
//               ),
//             ),
//             actions: [
//               IconButton(
//                 icon: Icon(Icons.history),
//                 color: Theme.of(context).primaryColor,
//                 onPressed: () {
//                   Get.find<LoaderController>().updateDataController(true);
//
//                   getMethod(
//                       context,
//                       getAllAppointmentsService,
//                       {'doctor_id': storageBox.read('doctor_id')},
//                       true,
//                       getAllLAppointmentRepo);
//                 },
//               )
//             ],
//           ),
//           body: loaderController.dataLoader
//               ? Center(child: CircularProgressIndicator())
//               : getAllAppointmentsModel.data == null
//                   ? Container(
//                       child: Center(
//                           child: Text(
//                         'Record Not Found',
//                         style: Theme.of(context)
//                             .textTheme
//                             .subtitle1
//                             .copyWith(fontWeight: FontWeight.w600),
//                       )),
//                     )
//                   : ListView.builder(
//                       itemCount: getAllAppointmentsModel.data.length,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         return Padding(
//                           padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(10),
//                                 boxShadow: [
//                                   BoxShadow(
//                                       color: Colors.grey.withOpacity(0.5),
//                                       blurRadius: 9,
//                                       spreadRadius: 3),
//                                 ]),
//                             child: Column(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 12.0, vertical: 16),
//                                   child: Row(
//                                     children: [
//                                       SizedBox(
//                                         width: 12,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                               Text('Name:  '),
//                                               Text(
//                                                 getAllAppointmentsModel
//                                                     .data[index].name,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1
//                                                     .copyWith(
//                                                         fontWeight:
//                                                             FontWeight.w600),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text(
//                                                 'Disease:  ',
//                                               ),
//                                               getAllAppointmentsModel
//                                                           .data[index]
//                                                           .disease ==
//                                                       null
//                                                   ? SizedBox()
//                                                   : Text(
//                                                       getAllAppointmentsModel
//                                                           .data[index].disease,
//                                                       style: Theme.of(context)
//                                                           .textTheme
//                                                           .subtitle1
//                                                           .copyWith(
//                                                               fontWeight:
//                                                                   FontWeight
//                                                                       .w600),
//                                                     ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text('Date:  '),
//                                               Text(
//                                                 getAllAppointmentsModel
//                                                     .data[index].bookingDate,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1
//                                                     .copyWith(
//                                                         fontWeight:
//                                                             FontWeight.w600),
//                                               ),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             height: 10,
//                                           ),
//                                           Row(
//                                             children: [
//                                               Text('Time:  '),
//                                               Text(
//                                                 getAllAppointmentsModel
//                                                     .data[index].timeSerial,
//                                                 style: Theme.of(context)
//                                                     .textTheme
//                                                     .subtitle1
//                                                     .copyWith(
//                                                         fontWeight:
//                                                             FontWeight.w600),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Container(
//                                       height: 40,
//                                       width: 80,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(8)),
//                                           color:
//                                               Theme.of(context).primaryColor),
//                                       child: Center(
//                                         child: InkWell(
//                                           child: Text(
//                                             'Accept',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                           onTap: () {
//                                             ///............///
//
//                                             Get.find<LoaderController>()
//                                                 .updateFormController(true);
//                                             postMethod(
//                                                 context,
//                                                 approveAppointmentService,
//                                                 {
//                                                   'doctor_id':
//                                                       getAllAppointmentsModel
//                                                           .data[index].doctorId,
//                                                   'appointment_id':
//                                                       getAllAppointmentsModel
//                                                           .data[index].id
//                                                 },
//                                                 true,
//                                                 approveAppointments);
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: 8,
//                                     ),
//                                     Container(
//                                       height: 40,
//                                       width: 80,
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(8)),
//                                           color:
//                                               Theme.of(context).primaryColor),
//                                       child: Center(
//                                         child: InkWell(
//                                           child: Text(
//                                             'Reject',
//                                             style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 12),
//                                           ),
//                                           onTap: () {
//                                             showDialog(
//                                                 context: context,
//                                                 builder:
//                                                     (BuildContext context) {
//                                                   return CustomDialogBox(
//                                                     titleColor:
//                                                         customDialogQuestionColor,
//                                                     descriptions:
//                                                         'Are you sure You want to delete this appointment?',
//                                                     text: 'Remove',
//                                                     functionCall: () {
//                                                       Navigator.pop(context);
//                                                       Get.find<
//                                                               LoaderController>()
//                                                           .updateFormController(
//                                                               true);
//
//                                                       postMethod(
//                                                           context,
//                                                           removeAppointmentService,
//                                                           {
//                                                             'doctor_id':
//                                                                 getAllAppointmentsModel
//                                                                     .data[index]
//                                                                     .doctorId,
//                                                             'appointment_id':
//                                                                 getAllAppointmentsModel
//                                                                     .data[index]
//                                                                     .id
//                                                           },
//                                                           true,
//                                                           removeAppointments);
//
//                                                       setState(() {});
//                                                     },
//                                                     img:
//                                                         'assets/dialog_Question Mark.svg',
//                                                   );
//                                                 });
//                                           },
//                                         ),
//                                       ),
//                                     )
//                                   ],
//                                 ),
//                                 SizedBox(
//                                   height: 10,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//         ),
//       ),
//     );
//   }
// }
