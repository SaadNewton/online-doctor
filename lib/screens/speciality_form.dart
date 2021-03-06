// @dart = 2.9
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/speciality_repo.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SpecialityForm extends StatefulWidget {
  final Function changeView;
  SpecialityForm({this.changeView});

  @override
  _SpecialityFormState createState() => _SpecialityFormState();
}

class _SpecialityFormState extends State<SpecialityForm> {
  GlobalKey<FormState> specialityKey = GlobalKey();
  final TextEditingController _specialityController = TextEditingController();
  String specialityType;
  final slidableController = SlidableController();
  final _scrollController = ScrollController();
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
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
                key: specialityKey,
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
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
                                        getSpeciality);
                                    Get.snackbar(
                                        'Success',
                                        'Successfully Uploaded',
                                        backgroundColor: Colors.black.withOpacity(0.5),
                                        colorText: Colors.white
                                    );
                                    print(loaderController.specialityList);
                                    _specialityController.clear();
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        loaderController.specialityList.length == 0
                            ? SizedBox()
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
                                        Wrap(
                                          children: List.generate(
                                              loaderController.specialityList.length, (index) {
                                            return Column(
                                              children: [
                                                Slidable(
                                                  closeOnScroll: true,
                                                  controller:
                                                      slidableController,
                                                  actionPane:
                                                      SlidableDrawerActionPane(),
                                                  actionExtentRatio: 0.2,
                                                  secondaryActions: <Widget>[
                                                    IconSlideAction(
                                                      color: Colors.blue,
                                                      icon: Icons.edit,
                                                      onTap: () {
                                                        setState(() {
                                                          _specialityController
                                                                  .text =
                                                          loaderController.specialityList[
                                                                      index][
                                                                  'speciality'];

                                                          _scrollController
                                                              .animateTo(
                                                            _scrollController
                                                                .position
                                                                .minScrollExtent,
                                                            curve:
                                                                Curves.easeOut,
                                                            duration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        500),
                                                          );

                                                          loaderController.specialityList
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                    IconSlideAction(
                                                      color: Colors.red,
                                                      icon: Icons.delete,
                                                      onTap: () {
                                                        setState(() {
                                                          loaderController.specialityList
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                  child: Builder(
                                                    builder: (BuildContext
                                                            contextS) =>
                                                        InkWell(
                                                      onTap: () {
                                                        print('CLICK ${index}');
                                                        Slidable.of(contextS)
                                                            .open();
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child: Row(
                                                            children: [
                                                              Expanded(
                                                                child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerLeft,
                                                                  child: Text(
                                                                    'Speciality',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            11,
                                                                        color:
                                                                            primaryColor),
                                                                  ),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Align(
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      '${loaderController.specialityList[index]['speciality']}',
                                                                      softWrap:
                                                                          true,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          color:
                                                                              Colors.black),
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                index ==
                                                        (loaderController.specialityList.length -
                                                            1)
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
          floatingActionButton: loaderController.specialityList.length == 0
              ? SizedBox()
              : FloatingActionButton(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.changeView(4);
                    });
                  },
                ),
        ),
      ),
    );
  }
}
