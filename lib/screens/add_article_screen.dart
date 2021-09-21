//@dart=2.9

import 'dart:io';

import 'package:dio/dio.dart' as dio_instance;
import 'dart:async';
import 'dart:developer';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/getArticlesRepo.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http_parser/http_parser.dart';

class AddArticleScreen extends StatefulWidget {
  @override
  _AddArticleScreenState createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  GlobalKey<FormState> articleKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
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
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      init: LoaderController(),
      builder:(loaderController)=> ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: GestureDetector(
          onTap: (){
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              title: Text(
                'Write Articles',
              ),
              textTheme: Theme.of(context).textTheme,
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),

            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Form(
                        key: articleKey,
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
                                        'Upload Photo',
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
                              onTap: () {},
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
                              controller: titleController,
                              hint: 'Title',
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
                              controller: descriptionController,
                              hint: 'Description',
                              maxLines: 5,
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
                                if (articleKey.currentState.validate() && _image != null ) {
                                  Get.find<LoaderController>()
                                      .updateFormController(true);
                                  uploadImage(_image);
                                } else if (articleKey.currentState.validate()){
                                  postMethod(
                                      context,
                                      addArticlesService,
                                      {
                                        'doctor_id':storageBox.read('doctor_id'),
                                        'title':titleController.text,
                                        'description':descriptionController.text
                                      }, true,
                                      addArticlesRepo
                                  );
                                }
                              },
                            ),
                            SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio_instance.FormData formData =
    dio_instance.FormData.fromMap(<String, dynamic>{
      'doctor_id':storageBox.read('doctor_id'),
      'title':titleController.text,
      'description':descriptionController.text,
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
      response = await dio.post(addArticlesService, data: formData);
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        Get.find<LoaderController>().updateFormController(false);
        Get.find<LoaderController>().updateDataController(true);
        getMethod(
            context,
            getAllArticlesService,
            {'doctor_id': storageBox.read('doctor_id')},
            true,
            getAllLArticlesRepo);
        Navigator.pop(context);

        _image = null;

        setState(() {});
      }
    } on dio_instance.DioError catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      log('putResponseError---->> ${e}');
    }
  }

}
