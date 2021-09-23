// @dart=2.9
import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/education_store_repo.dart';
import 'package:doctoworld_doctor/screens/experience%20_form.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
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

class DoctorProfile extends StatefulWidget {
  final Function changeView;
  DoctorProfile({this.changeView});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  GlobalKey<FormState> educationKey = GlobalKey();
  // final TextEditingController _instituteController = TextEditingController();
  // final TextEditingController _disciplineController = TextEditingController();
  // final TextEditingController _periodController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File _image;
  bool _imageChecker = false;

  Future getImage() async {
    final photo = await _picker.pickImage(source: ImageSource.gallery);
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
    // _nameController.dispose();
    // _emailController.dispose();
    super.dispose();
  }

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
                key: educationKey,
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
                              SizedBox(height: 30),

                              ///............. image.............///
                              if (_image == null)
                                InkWell(
                                  onTap: () {
                                    getImage();
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: profileList.length != 0
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            child: Image.file(
                                              profileList[0]['image'],
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(80),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    Icons.photo,
                                                    size: 18,
                                                  ),
                                                  Text(
                                                    'Upload Profile',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                  ),
                                )
                              else
                                InkWell(
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
                                      borderRadius: BorderRadius.circular(80),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              _imageChecker
                                  ? Text(
                                      'Image Required',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.red),
                                    )
                                  : SizedBox(),
                              SizedBox(height: 35),
                              CustomButton(
                                label: 'Submit',
                                onTap: () {
                                  if (_image != null) {
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
          floatingActionButton: profileList.length == 0
              ? SizedBox()
              : FloatingActionButton(
                  backgroundColor: primaryColor,
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      widget.changeView(1);
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
      response = await dio.post(getDoctorUpdateProfileService, data: formData);
      Get.find<LoaderController>().updateFormController(false);

      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        setState(() {
          profileList = [];
          profileList.add({'image': _image});
        });
        Get.find<LoaderController>().updateFormController(false);

        _image = null;
        log('LocalList---->> ${profileList}');

        setState(() {});
      }
    } on dio_instance.DioError catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      log('putResponseError---->> ${e}');
    }
  }
}
