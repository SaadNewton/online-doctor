// @dart=2.9
import 'dart:io';
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
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
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio_instance;
import 'dart:async';
import 'dart:developer';
import 'package:http_parser/http_parser.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class DrawerDoctorProfile extends StatefulWidget {
  final Function changeView;
  DrawerDoctorProfile({this.changeView});

  @override
  _DrawerDoctorProfileState createState() => _DrawerDoctorProfileState();
}

class _DrawerDoctorProfileState extends State<DrawerDoctorProfile> {
  GlobalKey<FormState> educationKey = GlobalKey();
  // final TextEditingController _instituteController = TextEditingController();
  // final TextEditingController _disciplineController = TextEditingController();
  // final TextEditingController _periodController = TextEditingController();
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

  GlobalKey<FormState> updateFormKey = GlobalKey();

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder: (loaderController) => ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Doctor Profile',
             style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          resizeToAvoidBottomInset: false,
          body: loaderController.dataLoader
              ?Center(child: CircularProgressIndicator())
              :FadedSlideAnimation(
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: updateFormKey,
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
                                      child: Image.network(
                                        '$mediaUrl${getDoctorProfileModal.data.imagePath}',
                                        fit: BoxFit.cover,
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
                              SizedBox(height: 20.0),
                              /// Email
                              EntryField(
                                controller: updateEmailController,
                                color: Colors.grey.withOpacity(0.2),
                                prefixIcon: Icons.mail,
                                textInputType: TextInputType.emailAddress,
                                hint: 'Email',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else if (!GetUtils.isEmail(updateEmailController.text)) {
                                    return 'Please Enter Valid Email';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              /// address
                              TextFormField(
                                controller: updateLocationController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    child: Icon(
                                      Icons.add_location,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onTap: () {
                                      getCurrentLocation(context);
                                    },
                                  ),
                                  hintText: 'Location',
                                  filled: true,
                                  fillColor: Colors.grey.withOpacity(0.2),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),


                              SizedBox(height: 35),
                              CustomButton(
                                label: 'Update',
                                onTap: () {
                                  if (updateFormKey.currentState.validate()
                                      && _image != null) {
                                    setState(() {
                                      _imageChecker = false;
                                    });
                                    Get.find<LoaderController>()
                                        .updateFormController(true);
                                    uploadImage(_image);
                                  } else{
                                    setState(() {
                                      _imageChecker = true;
                                    });
                                  }
                                  // else if (updateFormKey.currentState.validate()){
                                  //   Get.find<LoaderController>()
                                  //       .updateFormController(true);
                                  //   postMethod(
                                  //       context,
                                  //       getDoctorUpdateProfileService,
                                  //       {
                                  //         'doctor_id': storageBox.read('doctor_id'),
                                  //         'email':updateEmailController.text,
                                  //         'address':updateLocationController.text,
                                  //       },
                                  //       true,
                                  //       updateDoctorPersonalProfileRepo
                                  //   );
                                  //   // setState(() {
                                  //   //   _imageChecker = true;
                                  //   // });
                                  // }
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

        ),
      ),
    );
  }

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio_instance.FormData formData =
    dio_instance.FormData.fromMap(<String, dynamic>{
      'doctor_id': storageBox.read('doctor_id'),
      'email':updateEmailController.text,
      'address':updateLocationController.text,
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
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        Get.snackbar(
            'Success',
            'Successfully Uploaded',
            backgroundColor: Colors.black.withOpacity(0.5),
            colorText: Colors.white
        );
        setState(() {
          profileList = [];
          profileList.add({'image': _image});
        });
        Get.find<LoaderController>().updateFormController(false);
        Get.snackbar('Success','Updated Successfully');
        _image = null;
        log('LocalList---->> ${profileList}');

        setState(() {});
      }
    } on dio_instance.DioError catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      log('putResponseError---->> ${e}');
    }
  }

  var currentPosition;

  getCurrentLocation(BuildContext context) {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        longitude = currentPosition.longitude;
        latitude = currentPosition.latitude;

        print("longitude : $longitude");
        print("latitude : $latitude");
        print("address : $currentPosition");
      });

      getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  getAddressFromLatLng() async {
    try {
      // var currentPosition;
      List<Placemark> p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
        '${place.name}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
        // var signUpAddressController;
        // if (signUpAddressController.text.isEmpty) {
        //   signUpAddressController.text = currentAddress;
        // }
        print(currentAddress + ' yes');
        print(place.administrativeArea.toString());
        print(place.subAdministrativeArea.toString());
        print(place.thoroughfare.toString());
        print(place.toJson().toString());
        // FocusScope.of(context).unfocus();
        updateLocationController.text = place.name.toString();
      });
    } catch (e) {
      print(e);
    }
  }
}
