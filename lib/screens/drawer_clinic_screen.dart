//@dart=2.9

import 'package:animation_wrappers/Animations/faded_slide_animation.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/clinic_repo.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DrawerClinicScreen extends StatefulWidget {
  @override
  _DrawerClinicScreenState createState() => _DrawerClinicScreenState();
}

class _DrawerClinicScreenState extends State<DrawerClinicScreen> {


  final slidableController = SlidableController();
  final _scrollController = ScrollController();

  GlobalKey<FormState> clinicFormKey = GlobalKey();
  final TextEditingController _clinicNameController = TextEditingController();
  final TextEditingController _clinicAddressController = TextEditingController();

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
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Clinics',
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
                key: clinicFormKey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        addChecker
                            ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),

                                  ///...........institute....................///
                                  EntryField(
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


                                  CustomButton(
                                    label: 'Submit',
                                    onTap: () {
                                      FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (clinicFormKey.currentState.validate()) {

                                        Get.find<LoaderController>()
                                            .updateFormController(true);
                                        postMethod(
                                            context,
                                            clinicStoreService,
                                            {
                                              'doctor_id': storageBox.read('doctor_id'),
                                              'name': _clinicNameController.text,
                                              'address': _clinicAddressController.text
                                            },
                                            true,
                                            deleteClinic
                                        );
                                        _clinicNameController.clear();
                                        _clinicAddressController.clear();
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                            ),
                            SizedBox(height: 20.0),
                          ],
                        )
                            :SizedBox(),
                        Wrap(
                          children: List.generate(getDoctorProfileModal.data.clinics.length, (index){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.4),
                                          blurRadius: 9,
                                          spreadRadius: 2
                                      )
                                    ]
                                ),
                                child: ListTile(
                                  title: Text(
                                    '${getDoctorProfileModal.data.clinics[index].name}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${getDoctorProfileModal.data.clinics[index].address}',
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.withOpacity(0.8)
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  trailing: InkWell(
                                      onTap: (){
                                        showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext context) {
                                              return CustomDialogBox(
                                                titleColor:
                                                customDialogQuestionColor,
                                                descriptions:
                                                'Are you sure You want to delete this education?',
                                                text: 'Remove',
                                                functionCall: () {

                                                  Get.find<LoaderController>()
                                                      .updateFormController(true);
                                                  postMethod(
                                                      context,
                                                      clinicDeleteService,
                                                      {
                                                        'clinic_id': getDoctorProfileModal.data.clinics[index].id,
                                                      },
                                                      true,
                                                      deleteClinic
                                                  );

                                                  Navigator.pop(context);
                                                  setState(() {
                                                    addChecker = false;
                                                  });
                                                },
                                                img:
                                                'assets/dialog_Question Mark.svg',
                                              );
                                            });
                                      },
                                      child: Icon(Icons.delete,color: Colors.red,)
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 20,)
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
}
