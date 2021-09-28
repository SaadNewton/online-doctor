// @dart = 2.9
import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/BottomNavigation/bottom_navigation.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/screens/speciality_form.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'dart:async';
import 'dart:developer';
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ExperienceForm extends StatefulWidget {
  final Function changeView;
  ExperienceForm({this.changeView});

  @override
  _ExperienceFormState createState() => _ExperienceFormState();
}

class _ExperienceFormState extends State<ExperienceForm> {
  GlobalKey<FormState> experienceKey = GlobalKey();
  final TextEditingController _instituteExperienceController =
      TextEditingController();
  final TextEditingController _disciplineExperienceController =
      TextEditingController();
  final TextEditingController _periodExperienceController =
      TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  File _image;
  bool _imageChecker = false;

  Future getImage() async {
    final photo = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      imageQuality: 80
    );
    setState(() {
      if (photo != null) {
        _image = File(photo.path);
      } else {
        print('No image selected.');
      }
    });
  }

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
                key: experienceKey,
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
                              _image == null
                                  ? InkWell(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            shape: BoxShape.circle),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.photo,
                                                size: 18,
                                              ),
                                              Text(
                                                'Upload Certificate',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        getImage();
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey.withOpacity(0.2),
                                            shape: BoxShape.circle),
                                        height: 80,
                                        width: 80,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            child: Image.file(
                                              _image,
                                            )),
                                      ),
                                    ),
                              _imageChecker
                                  ? Text(
                                      'Image Required',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.red),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 20),

                              /// institution
                              EntryField(
                                color: Colors.grey.withOpacity(0.2),
                                controller: _instituteExperienceController,
                                hint: 'Institution',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              /// Discipline

                              EntryField(
                                color: Colors.grey.withOpacity(0.2),
                                controller: _disciplineExperienceController,
                                hint: 'Discipline',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              /// period
                              EntryField(
                                color: Colors.grey.withOpacity(0.2),
                                controller: _periodExperienceController,
                                hint: 'Period',
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
                                  if (experienceKey.currentState.validate() &&
                                      _image != null) {
                                    setState(() {
                                      _imageChecker = false;
                                    });
                                    Get.find<LoaderController>()
                                        .updateFormController(true);
                                    uploadImage(_image);
                                  } else {
                                    setState(() {
                                      _imageChecker = true;
                                    });
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        loaderController.experienceList.length == 0
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
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      'Certificate',
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
                                                      'Institution',
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
                                                      'Discipline',
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
                                                      'Period',
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          color: primaryColor),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Divider(
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                        Wrap(
                                          children: List.generate(
                                              loaderController.experienceList.length, (index) {
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
                                                          _instituteExperienceController
                                                                  .text =
                                                          loaderController.experienceList[
                                                                      index][
                                                                  'institution'];
                                                          _disciplineExperienceController
                                                                  .text =
                                                          loaderController.experienceList[
                                                                      index][
                                                                  'discipline'];
                                                          _periodExperienceController
                                                                  .text =
                                                          loaderController.experienceList[
                                                                      index]
                                                                  ['period'];
                                                          _image =
                                                          loaderController.experienceList[
                                                                      index]
                                                                  ['image'];

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

                                                          loaderController.experienceList
                                                              .removeAt(index);
                                                        });
                                                      },
                                                    ),
                                                    IconSlideAction(
                                                      color: Colors.red,
                                                      icon: Icons.delete,
                                                      onTap: () {
                                                        setState(() {
                                                          loaderController.experienceList
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
                                                        child: Row(
                                                          children: [
                                                            Expanded(
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    Image.file(
                                                                      loaderController.experienceList[
                                                                          index]
                                                                      ['image'],
                                                                  width: 20,
                                                                ),
                                                              ),
                                                            ),
                                                            Expanded(
                                                              child: Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  child: Text(
                                                                    '${loaderController.experienceList[index]['institution']}',
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
                                                                    '${loaderController.experienceList[index]['discipline']}',
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
                                                                    '${loaderController.experienceList[index]['period']}',
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
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                index ==
                                                        (loaderController.experienceList.length -
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
          floatingActionButton: loaderController.experienceList.length == 0
              ? SizedBox()
              : FloatingActionButton(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.changeView(3);
                    });
                  },
                ),
        ),
      ),
    );
  }

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio_instance.FormData formData =
        dio_instance.FormData.fromMap(<String, dynamic>{
      'doctor_id': storageBox.read('doctor_id'),
      'institution': _instituteExperienceController.text,
      'discipline': _disciplineExperienceController.text,
      'period': _periodExperienceController.text,
      'image': await dio_instance.MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: new MediaType('image', 'jpeg'), //important
      )
    });
    dio_instance.Dio dio = dio_instance.Dio();
    // setCustomHeader(dio, 'Authorization', 'Bearer ${storageBox.read('accessToken')}');
    dio_instance.Response<dynamic> response;
    try {
      response = await dio.post(experienceStoreService, data: formData);
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        Get.snackbar(
            'Success',
            'Successfully Uploaded',
            backgroundColor: Colors.black.withOpacity(0.5),
            colorText: Colors.white
        );
        Get.find<LoaderController>().updateExperienceList(
            {
              'id': response.data['data']['id'],
              'institution': _instituteExperienceController.text,
              'discipline': _disciplineExperienceController.text,
              'period': _periodExperienceController.text,
              'image': _image
            }
        );
        // experienceList.add({
        //   'institution': _instituteExperienceController.text,
        //   'discipline': _disciplineExperienceController.text,
        //   'period': _periodExperienceController.text,
        //   'image': _image
        // });
        Get.find<LoaderController>().updateFormController(false);

        _instituteExperienceController.clear();
        _disciplineExperienceController.clear();
        _periodExperienceController.clear();
        _image = null;
        log('LocalList---->> ${Get.find<LoaderController>().experienceList}');
        setState(() {});
      }
      else{
        Get.find<LoaderController>().updateFormController(false);
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(
                title: 'FAILED!',
                titleColor: customDialogErrorColor,
                descriptions: 'Try Again',
                text: 'Ok',
                functionCall: () {
                  Navigator.pop(context);
                },
                img: 'assets/dialog_error.svg',
              );
            });
      }
    } on dio_instance.DioError catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox(
              title: 'FAILED!',
              titleColor: customDialogErrorColor,
              descriptions: 'Try Again',
              text: 'Ok',
              functionCall: () {
                Navigator.pop(context);
              },
              img: 'assets/dialog_error.svg',
            );
          });
      log('putResponseError---->> ${e}');
    }
  }
}
