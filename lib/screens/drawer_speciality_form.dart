// @dart = 2.9
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/repositories/get_speciality_list_repo.dart';
import 'package:doctoworld_doctor/repositories/speciality_repo.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DrawerSpecialityForm extends StatefulWidget {
  final Function changeView;
  DrawerSpecialityForm({this.changeView});

  @override
  _DrawerSpecialityFormState createState() => _DrawerSpecialityFormState();
}

class _DrawerSpecialityFormState extends State<DrawerSpecialityForm> {
  GlobalKey<FormState> specialityKey = GlobalKey();
  final TextEditingController _specialityController = TextEditingController();
  String specialityType;
  final slidableController = SlidableController();
  final _scrollController = ScrollController();
  @override

  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(
        context, specialitiesListService, null, true, getSpecialityListRepo);
    getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
        getDoctorProfileRepo);
    super.initState();
  }
  void dispose() {
    super.dispose();
  }
  bool addChecker = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Speciality',
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
                key: specialityKey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        addChecker
                            ?Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
                              child: Column(
                                children: [
                                  /// speciality
                                  ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField<String>(
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 17.0, horizontal: 10.0),
                                          fillColor: Colors.grey.withOpacity(0.2),
                                          filled: true,
                                          hintText: 'Select',
                                          hintStyle: TextStyle(
                                              color: Colors.black, fontSize: 17),
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
                                            color: Colors.black, fontSize: 17),
                                        iconEnabledColor: Colors.black,
                                        value: specialityType,
                                        items: getSpecialitiesList
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 17),
                                                ),
                                              );
                                            }).toList(),
                                        onChanged: (String value) {
                                          print(value);
                                          setState(() {
                                            specialityType = value;
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

                                  CustomButton(
                                    label: 'Submit',
                                    onTap: () {
                                      if (specialityKey.currentState.validate()) {
                                        Get.find<LoaderController>()
                                            .updateFormController(true);
                                        setState(() {
                                          loaderController.specialityList
                                              .add({'speciality': specialityType});
                                        });
                                        postMethod(
                                            context,
                                            specialityStoreService,
                                            {
                                            'doctor_id': storageBox.read('doctor_id'),
                                            'speciality': loaderController.specialityList.length ==
                                            0
                                            ? [specialityType]
                                                : List.generate(
                                            loaderController.specialityList.length,
                                            (index) {
                                            return loaderController.specialityList[index]
                                            ['speciality'];
                                            })
                                            },
                                            true,
                                            updateSpeciality
                                        );
                                        Get.snackbar(
                                            'Success',
                                            'Successfully Uploaded',
                                            backgroundColor: Colors.black.withOpacity(0.5),
                                            colorText: Colors.white
                                        );
                                        setState(() {
                                          addChecker = false;
                                        });
                                        print(loaderController.specialityList);
                                        _specialityController.clear();
                                      }
                                    },
                                  ),
                                  SizedBox(height: 20.0),
                                ],
                              ),
                            ),
                          ],
                        )
                            :SizedBox(),
                        Wrap(
                          children: List.generate(loaderController.specialityList.length, (index){
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
                                    '${loaderController.specialityList[index]['speciality']}',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: loaderController.specialityList.length == 1
                                      ?SizedBox()
                                      :InkWell(
                                    onTap: (){
                                      showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext context) {
                                            return CustomDialogBox(
                                              titleColor:
                                              customDialogQuestionColor,
                                              descriptions:
                                              'Are you sure You want to delete this speciality?',
                                              text: 'Remove',
                                              functionCall: () {
                                                Get.find<LoaderController>()
                                                    .updateFormController(true);
                                                setState(() {
                                                  loaderController.specialityList.removeAt(index);
                                                });
                                                postMethod(
                                                    context,
                                                    specialityStoreService,
                                                    {
                                                      'doctor_id': storageBox.read('doctor_id'),
                                                      'speciality':  loaderController.specialityList.length == 0
                                                          ?[]
                                                          :List.generate(
                                                    loaderController.specialityList.length,
                                                              (index) {
                                                            return loaderController.specialityList[index]
                                                            ['speciality'];
                                                          })
                                                    },
                                                    true,
                                                    updateSpeciality
                                                );
                                                Get.snackbar(
                                                    'Success',
                                                    'Successfully Deleted',
                                                    backgroundColor: Colors.black.withOpacity(0.5),
                                                    colorText: Colors.white
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
                                    child: Icon(
                                      Icons.delete,
                                      size: 25,
                                      color: Colors.red,
                                    ),
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
