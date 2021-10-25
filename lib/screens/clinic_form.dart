//@dart=2.9

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/clinic_repo.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ClinicForm extends StatefulWidget {
  final Function changeView;
  ClinicForm({this.changeView});
  @override
  _ClinicFormState createState() => _ClinicFormState();
}

class _ClinicFormState extends State<ClinicForm> {

  final slidableController = SlidableController();
  final _scrollController = ScrollController();
  GlobalKey<FormState> clinicKey = GlobalKey();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicAddressController = TextEditingController();
  final TextEditingController _clinicFeeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: FadedSlideAnimation(
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: clinicKey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              SizedBox(height: 10.0),
                              Text(
                                'Add clinics here if you want to add schedule for physical appointments',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Theme.of(context).disabledColor),
                              ),
                              SizedBox(height: 20),

                              ///...........institute....................///
                              EntryField(
                                textInputType: TextInputType.text,
                                color: Colors.grey.withOpacity(0.2),
                                controller: _clinicNameController,
                                hint: 'Clinic Name',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              ///...............discipline................///
                              EntryField(
                                textInputType: TextInputType.text,
                                color: Colors.grey.withOpacity(0.2),
                                controller: _clinicAddressController,
                                hint: 'Clinic Address',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              ///...............fee................///
                              EntryField(
                                color: Colors.grey.withOpacity(0.2),
                                textInputFormatter: LengthLimitingTextInputFormatter(6),
                                textInputType: TextInputType.number,
                                controller: _clinicFeeController,
                                hint: 'Clinic Fee',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              CustomButton(
                                label: 'Submit',
                                onTap: () {
                                  FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (clinicKey.currentState.validate()) {

                                    Get.find<LoaderController>()
                                        .updateFormController(true);

                                    postMethod(
                                        context,
                                        clinicStoreService,
                                        {
                                          'doctor_id': storageBox.read('doctor_id'),
                                          'name': _clinicNameController.text,
                                          'address': _clinicAddressController.text,
                                          'fees': _clinicFeeController.text
                                        },
                                        true,
                                        clinicStore
                                    );
                                    _clinicNameController.clear();
                                    _clinicAddressController.clear();
                                    _clinicFeeController.clear();
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        if (loaderController.clinicsList.length == 0)
                          SizedBox()
                        else
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.withOpacity(0.4),
                                        offset: Offset(0, 1),
                                        blurRadius: 9,
                                        spreadRadius: 3)
                                  ]),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Container(
                                        decoration:
                                        BoxDecoration(color: Colors.white),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Clinic Name',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Clinic Fees',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Text(
                                                  'Clinic Address',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: primaryColor),
                                                ),
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_back,
                                              size: 13,
                                              color: Colors.white,
                                            )
                                          ],
                                        )),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.8),
                                    ),
                                    Wrap(
                                      children: List.generate(
                                          loaderController.clinicsList.length, (index) {
                                        return Column(
                                          children: [
                                            Slidable(
                                                closeOnScroll: true,
                                                controller: slidableController,
                                                actionPane:
                                                SlidableDrawerActionPane(),
                                                actionExtentRatio: 0.2,
                                                secondaryActions: <Widget>[
                                                  IconSlideAction(
                                                    color: Colors.blue,
                                                    icon: Icons.edit,
                                                    onTap: () {
                                                      setState(() {
                                                        _clinicNameController
                                                            .text =
                                                        loaderController.clinicsList[index]
                                                        ['clinic_name'];
                                                        _clinicAddressController
                                                            .text =
                                                        loaderController.clinicsList[index]
                                                        ['clinic_address'];
                                                        _clinicFeeController
                                                            .text =
                                                        loaderController.clinicsList[index]
                                                        ['clinic_fees'].toString();

                                                        _scrollController
                                                            .animateTo(
                                                          _scrollController
                                                              .position
                                                              .minScrollExtent,
                                                          curve: Curves.easeOut,
                                                          duration:
                                                          const Duration(
                                                              milliseconds:
                                                              500),
                                                        );

                                                        loaderController.clinicsList
                                                            .removeAt(index);
                                                      });
                                                    },
                                                  ),
                                                  IconSlideAction(
                                                    color: Colors.red,
                                                    icon: Icons.delete,
                                                    onTap: () {
                                                      // postMethod(
                                                      //     context,
                                                      //     '$educationStoreDeleteService',
                                                      //     null,
                                                      //     true,
                                                      //     deleteEducationStoreData
                                                      // );
                                                      setState(() {
                                                        loaderController.clinicsList
                                                            .removeAt(index);
                                                      });
                                                    },
                                                  ),
                                                ],
                                                child: Builder(
                                                  builder:
                                                      (BuildContext contextS) =>
                                                      InkWell(
                                                        onTap: () {
                                                          print('CLICK ${index}');
                                                          Slidable.of(contextS)
                                                              .open();
                                                        },
                                                        child: Container(
                                                          color: Colors.white,
                                                          height: 30,
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    child: Text(
                                                                      '${loaderController.clinicsList[index]['clinic_name']}',
                                                                      softWrap:
                                                                      true,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          11,
                                                                          color: Colors
                                                                              .black),
                                                                    )),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    child: Text(
                                                                      '${loaderController.clinicsList[index]['clinic_fees']}',
                                                                      softWrap:
                                                                      true,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          11,
                                                                          color: Colors
                                                                              .black),
                                                                    )),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                    alignment:
                                                                    Alignment
                                                                        .center,
                                                                    child: Text(
                                                                      '${loaderController.clinicsList[index]['clinic_address']}',
                                                                      softWrap:
                                                                      true,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                          11,
                                                                          color: Colors
                                                                              .black),
                                                                    )),
                                                              ),
                                                              Icon(
                                                                Icons.arrow_back,
                                                                size: 13,
                                                                color: primaryColor,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  // ExperienceListShow(context: context,index: index,),
                                                )),
                                            index == (loaderController.clinicsList.length - 1)
                                                ? SizedBox()
                                                : Divider(
                                              color: Colors.grey
                                                  .withOpacity(0.3),
                                            ),
                                          ],
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                widget.changeView(5);
              });
            },
          ),
        ),
      ),
    );
  }
}