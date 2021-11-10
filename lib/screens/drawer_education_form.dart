// @dart=2.9
import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/education_store_repo.dart';
import 'package:doctoworld_doctor/repositories/getDoctorProfileRepo.dart';
import 'package:doctoworld_doctor/screens/experience%20_form.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
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

class DrawerEducationForm extends StatefulWidget {
  final Function changeView;
  DrawerEducationForm({this.changeView});

  @override
  _DrawerEducationFormState createState() => _DrawerEducationFormState();
}

class _DrawerEducationFormState extends State<DrawerEducationForm> {
  GlobalKey<FormState> educationKey = GlobalKey();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _disciplineController = TextEditingController();
  final TextEditingController _periodController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File _image;
  bool _imageChecker = false;

  Future getImage() async {
    final photo = await _picker.pickImage(source: ImageSource.gallery,
        imageQuality: 80);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateDataController(true);
    });
    getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
        getDoctorProfileRepo);
  }
  @override
  void dispose() {
    // _nameController.dispose();
    // _emailController.dispose();
    super.dispose();
  }

  bool addChecker = false;
  bool updateChecker = false;
  int updateIndex = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Education',
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
                      updateChecker = false;
                      _instituteController.clear();
                      _disciplineController.clear();
                      _periodController.clear();
                      _image = null;
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
                key: educationKey,
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
                                  ///............. image.............///
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

                                  ///...........institute....................///
                                  EntryField(
                                    color: Colors.grey.withOpacity(0.2),
                                    controller: _instituteController,
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

                                  ///...............discipline................///
                                  EntryField(
                                    color: Colors.grey.withOpacity(0.2),
                                    controller: _disciplineController,
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

                                  ///..........period................///

                                  EntryField(
                                    color: Colors.grey.withOpacity(0.2),
                                    controller: _periodController,
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
                                      if (educationKey.currentState.validate() &&
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
                            SizedBox(height: 20.0),
                          ],
                        )
                            :SizedBox(),
                        updateChecker
                            ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                children: [
                                  ///............. image.............///
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
                                      child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(80),
                                          child: Image.network(
                                            '$mediaUrl${getDoctorProfileModal.data.educationDetails[updateIndex].imagePath}',
                                          )),
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
                                  SizedBox(height: 20),

                                  ///...........institute....................///
                                  EntryField(
                                    color: Colors.grey.withOpacity(0.2),
                                    controller: _instituteController,
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

                                  ///...............discipline................///
                                  EntryField(
                                    color: Colors.grey.withOpacity(0.2),
                                    controller: _disciplineController,
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

                                  ///..........period................///

                                  EntryField(
                                    color: Colors.grey.withOpacity(0.2),
                                    controller: _periodController,
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
                                    label: 'Update',
                                    onTap: () {
                                      FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                      if (educationKey.currentState.validate() &&
                                          _image != null) {
                                        Get.find<LoaderController>()
                                            .updateFormController(true);
                                        updateImage(_image);
                                        setState(() {
                                          addChecker =false;
                                          updateChecker =false;
                                        });
                                      } else if (educationKey.currentState.validate()){
                                        Get.find<LoaderController>()
                                            .updateFormController(true);
                                        postMethod(
                                            context,
                                            educationStoreUpdateService,
                                            {
                                              'update_id':getDoctorProfileModal.data.educationDetails[updateIndex].id,
                                              'doctor_id':storageBox.read('doctor_id'),
                                              'institution': _instituteController.text,
                                              'discipline': _disciplineController.text,
                                              'period': _periodController.text,
                                            }, true,
                                            deleteEducationStoreData
                                        );
                                        setState(() {
                                          addChecker =false;
                                          updateChecker =false;
                                        });
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
                          children: List.generate(getDoctorProfileModal.data.educationDetails.length, (index){
                            return Padding(
                              padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 30),
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
                                        leading: Container(
                                          width: 40,
                                          height: double.infinity,
                                          child: Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(5),
                                              child: Image.network(
                                                '$mediaUrl${getDoctorProfileModal.data.educationDetails[index].imagePath}',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          '${getDoctorProfileModal.data.educationDetails[index].discipline}',
                                          style: TextStyle(
                                            fontSize: 17,
                                            color: Colors.black
                                          ),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${getDoctorProfileModal.data.educationDetails[index].institution}',
                                                softWrap: true,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.grey.withOpacity(0.8)
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerRight,
                                                child: Text(
                                                  '${getDoctorProfileModal.data.educationDetails[index].period}',
                                                  softWrap: true,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    color: Colors.grey.withOpacity(0.8)
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      bottom: 0,
                                      child: Row(
                                        children: [
                                          InkWell(
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

                                                        Get.find<LoaderController>().updateDataController(true);
                                                        postMethod(
                                                            context,
                                                            educationStoreDeleteService,
                                                            {
                                                              'delete_id':getDoctorProfileModal.data.educationDetails
                                                              [index].id
                                                            },
                                                            true,
                                                            deleteEducationStoreData
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
                                            child: Container(
                                              height: 30,
                                              width: 40,
                                              color: Colors.red,
                                              child: Center(child: Icon(Icons.delete,
                                              color: Colors.white,),),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: (){
                                              setState(() {
                                                addChecker = false;
                                                _instituteController.text =
                                                    getDoctorProfileModal.data.educationDetails[index].institution.toString();
                                                _disciplineController.text =
                                                    getDoctorProfileModal.data.educationDetails[index].discipline.toString();
                                                _periodController.text =
                                                    getDoctorProfileModal.data.educationDetails[index].period.toString();
                                                updateIndex = index;
                                                updateChecker = true;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Theme.of(context).primaryColor,
                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(10))
                                              ),
                                              height: 30,
                                              width: 40,
                                              child: Center(child: Icon(Icons.edit,
                                              color: Colors.white,)),
                                            ),
                                          )
                                        ],
                                      ))
                                ],
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

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio_instance.FormData formData =
    dio_instance.FormData.fromMap(<String, dynamic>{
      'doctor_id': storageBox.read('doctor_id'),
      'institution': _instituteController.text,
      'discipline': _disciplineController.text,
      'period': _periodController.text,
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
      response = await dio.post(educationStoreService, data: formData);
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        Get.snackbar(
            'Success',
            'Successfully Uploaded',
            backgroundColor: Colors.black.withOpacity(0.5),
            colorText: Colors.white
        );
        getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
            getDoctorProfileRepo);

        _instituteController.clear();
        _disciplineController.clear();
        _periodController.clear();
        _image = null;

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
      log('putResponseError---->> ${e}');
    }
  }
  updateImage(File file) async {
    String fileName = file.path.split('/').last;
    dio_instance.FormData formData =
    dio_instance.FormData.fromMap(<String, dynamic>{
      'update_id':getDoctorProfileModal.data.educationDetails[updateIndex].id,
      'doctor_id': storageBox.read('doctor_id'),
      'institution': _instituteController.text,
      'discipline': _disciplineController.text,
      'period': _periodController.text,
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
      response = await dio.post(educationStoreUpdateService, data: formData);
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        Get.snackbar(
            'Success',
            'Successfully Uploaded',
            backgroundColor: Colors.black.withOpacity(0.5),
            colorText: Colors.white
        );
        getMethod(context, getDoctorProfileService, {'doctor_id': storageBox.read('doctor_id')}, true,
            getDoctorProfileRepo);

        _instituteController.clear();
        _disciplineController.clear();
        _periodController.clear();
        _image = null;

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
      log('putResponseError---->> ${e}');
    }
  }
}
