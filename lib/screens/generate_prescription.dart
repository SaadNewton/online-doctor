//@dart=2.9
import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/create_report_repo.dart';
import 'package:doctoworld_doctor/repositories/save_prescription_data_repo.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'medicine_search_screen.dart';

int editProductId;
final TextEditingController medicineNameController = TextEditingController();

class GeneratePrescriptionScreen extends StatefulWidget {
  final Appointments appointment;
  GeneratePrescriptionScreen({this.appointment});
  @override
  _GeneratePrescriptionScreenState createState() =>
      _GeneratePrescriptionScreenState();
}

class _GeneratePrescriptionScreenState
    extends State<GeneratePrescriptionScreen> {
  List complaintsList = [];
  List prescriptionList = [];
  List<String> frequencyList = [
    '1 Day',
    '2 Days',
    '3 Days',
    '4 Days',
    '5 Days',
    '6 Days',
    '7 Days',
    '8 Days',
    '9 Days',
    '10 Days',
    '11 Day',
    '12 Days',
    '13 Days',
    '14 Days',
    '15 Days',
    '16 Days',
    '17 Days',
    '18 Days',
    '19 Days',
    '20 Days',
    '21 Day',
    '22 Days',
    '23 Days',
    '24 Days',
    '25 Days',
    '26 Days',
    '27 Days',
    '28 Days',
    '29 Days',
    '30 Days',
  ];
  List<String> dailyDozeList = [
    'Once a day',
    'Two times a day',
    'Three times a day',
  ];

  var selectedFrequency;
  var selectedDailyDose;

  GlobalKey<FormState> complaintsKey = GlobalKey();
  GlobalKey<FormState> prescriptionKey = GlobalKey();
  final TextEditingController complaintController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateFormController(false);
    });
    // TODO: implement initState
    super.initState();
    appointmentID = null;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Appointment Prescription'),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
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
                              '${widget.appointment.name}'.capitalize,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
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
                              '${widget.appointment.disease}'.capitalize,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(fontSize: 20),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
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
                      ],
                    ),
                  ),

                  /// Health Complaint Container Box

                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 6,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 10),
                          Text(
                            'Health Complaint',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    color: Theme.of(context).disabledColor,
                                    fontSize: 18),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0,
                                right: 20.0,
                                left: 20.0,
                                bottom: 16.0),
                            child: Column(
                              children: [
                                Form(
                                  key: complaintsKey,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: EntryField(
                                          color: Colors.grey.withOpacity(0.2),
                                          controller: complaintController,
                                          hint: 'Complaint',
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Field is Required';
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor,
                                          ),
                                          onPressed: () {
                                            if (complaintsKey.currentState
                                                .validate()) {
                                              FocusScopeNode currentFocus =
                                                  FocusScope.of(context);
                                              if (!currentFocus
                                                  .hasPrimaryFocus) {
                                                currentFocus.unfocus();
                                              }
                                              setState(() {
                                                complaintsList.add(
                                                    complaintController.text);
                                                complaintController.clear();
                                              });
                                            }
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20.0, bottom: 20.0),
                                            child: Text('Add'),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                complaintsList.length == 0
                                    ? Container()
                                    : Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 10, bottom: 16),
                                            child: Text(
                                              'Complaints Added',
                                            ),
                                          ),
                                          Wrap(
                                            children: List.generate(
                                                complaintsList.length, (index) {
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 10),
                                                child: Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                              Colors.grey[200],
                                                          blurRadius: 5,
                                                          spreadRadius: 5,
                                                        )
                                                      ]),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          '${index + 1}.',
                                                        ),
                                                        SizedBox(
                                                          width: 16,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              complaintsList[
                                                                  index],
                                                            ),
                                                          ],
                                                        ),
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  complaintsList
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                              },
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                  Icons.delete,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 25,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  /// Medicine Prescription Box
                  ///

                  Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 6,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Prescription',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                      color: Theme.of(context).disabledColor,
                                      fontSize: 18),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 16.0,
                                  right: 20.0,
                                  left: 20.0,
                                  bottom: 16.0),
                              child: Form(
                                key: prescriptionKey,
                                child: Column(
                                  children: [
                                    EntryField(
                                      onTap: () =>
                                          Get.to(MedicineSearchScreen()),
                                      color: Colors.grey.withOpacity(0.2),
                                      controller: medicineNameController,
                                      hint: 'Search Medicine',
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Field is Required';
                                        } else {
                                          return null;
                                        }
                                      },
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 5.0,
                                            ),
                                            child:
                                                DropdownButtonFormField<String>(
                                              validator: (v) {
                                                if (v == null) {
                                                  return 'Please fill this';
                                                }
                                                return null;
                                              },
                                              decoration: InputDecoration(
                                                  contentPadding:
                                                      EdgeInsets.only(left: 12),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey[200],
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  fillColor: Colors.white,
                                                  filled: true),
                                              hint: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                  'Frequency',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              items: List.generate(
                                                  (frequencyList.length), (a) {
                                                return DropdownMenuItem(
                                                  child: Text(frequencyList[a]),
                                                  value: frequencyList[a],
                                                );
                                              }),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedFrequency = value;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5.0, right: 5.0),
                                      child: DropdownButtonFormField<String>(
                                        validator: (v) {
                                          if (v == null) {
                                            return 'Please fill this';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 12),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[200],
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            fillColor: Colors.white,
                                            filled: true),
                                        hint: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0),
                                          child: Text(
                                            'Select Daily Doze',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                        ),
                                        items: List.generate(
                                            (dailyDozeList.length), (a) {
                                          return DropdownMenuItem(
                                            child: Text(dailyDozeList[a]),
                                            value: dailyDozeList[a],
                                          );
                                        }),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedDailyDose = value;
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                        ),
                                        onPressed: () {
                                          if (prescriptionKey.currentState
                                              .validate()) {
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);
                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                            loaderController
                                                .updateFormController(true);
                                            postMethod(
                                                context,
                                                savePrescriptionDataService,
                                                {
                                                  'appointment_id':
                                                      widget.appointment.id,
                                                  'item_id': editProductId,
                                                  'item_name':
                                                      medicineNameController
                                                          .text,
                                                  'tad': selectedDailyDose,
                                                  'frequency':
                                                      selectedFrequency,
                                                },
                                                true,
                                                savePrescriptionDataRepo);

                                            setState(() {
                                              print(
                                                  'item has been added tp the list>>>>>>>>>>>>>');
                                              prescriptionList.add({
                                                'name':
                                                    medicineNameController.text,
                                                'frequency': selectedFrequency,
                                                'dose': selectedDailyDose
                                              });
                                              medicineNameController.clear();
                                            });
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 50, vertical: 15),
                                          child: Text('Add'),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    prescriptionList.length == 0
                                        ? Container()
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, bottom: 16),
                                                child: Text(
                                                  'Medicines Added',
                                                ),
                                              ),
                                              Wrap(
                                                children: List.generate(
                                                    prescriptionList.length,
                                                    (index) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 10),
                                                    child: Container(
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .grey[200],
                                                              blurRadius: 5,
                                                              spreadRadius: 5,
                                                            )
                                                          ]),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Row(
                                                          children: [
                                                            Text(
                                                              '${index + 1}.',
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  '${prescriptionList[index]['name']}'
                                                                      .capitalize,
                                                                ),
                                                                Text(
                                                                  '${prescriptionList[index]['dose']}',
                                                                ),
                                                                SizedBox(
                                                                    width: 5),
                                                                Text(
                                                                  'For ${prescriptionList[index]['frequency']}',
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Align(
                                                                alignment: Alignment
                                                                    .centerRight,
                                                                child: InkWell(
                                                                  onTap: () {
                                                                    setState(
                                                                        () {
                                                                      prescriptionList
                                                                          .removeAt(
                                                                              index);
                                                                    });
                                                                  },
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: Colors
                                                                          .red,
                                                                      size: 25,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  SizedBox(height: 20),

                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (complaintsList.length >= 1) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          loaderController.updateFormController(true);
                          postMethod(
                              context,
                              createReportService,
                              {
                                'appointment_id': widget.appointment.id,
                                'health': complaintsList,
                              },
                              true,
                              createReportRepo);
                          setState(() {
                            appointmentID = widget.appointment.id;
                          });
                        } else {
                          Get.snackbar('Sorry',
                              'Please add atleast one health complaint',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.white);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        child: Text('Generate Prescription'),
                      )),
                  SizedBox(height: 20),
                ],
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
}
