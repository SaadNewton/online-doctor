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
  GlobalKey<FormState> educationKey  = GlobalKey();
  // final TextEditingController _instituteController = TextEditingController();
  // final TextEditingController _disciplineController = TextEditingController();
  // final TextEditingController _periodController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File _image;
  bool _imageChecker = false;

  Future getImage() async{
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
      builder:(loaderController)=> ModalProgressHUD(
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

                    padding:  EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              ///............. image.............///
                              _image == null
                                  ? InkWell(
                                onTap: (){
                                  getImage();
                                },
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    child: Image.asset('assets/image_picker.png')
                                ),
                              )
                                  : InkWell(
                                onTap: (){},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  height: 60,
                                  width: 60,
                                  child: Center(child: Image.file(_image) ),
                                ),
                              ),
                              _imageChecker
                                  ?Text(
                                'Image Required',
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.red
                                ),
                              )
                                  :SizedBox(),
                              SizedBox(height: 35),

                              // ///...........institute....................///
                              // EntryField(
                              //   color: Colors.grey.withOpacity(0.2),
                              //   controller: _instituteController,
                              //   hint: 'profile',
                              //   validator: (value){
                              //     if(value.isEmpty){
                              //       return 'Field is Required';
                              //     }else{
                              //       return null;
                              //     }
                              //   },
                              // ),
                              // SizedBox(height: 20.0),
                              //
                              // ///...............discipline................///
                              // EntryField(
                              //   color: Colors.grey.withOpacity(0.2),
                              //   controller: _disciplineController,
                              //   hint: 'Discipline',
                              //   validator: (value){
                              //     if(value.isEmpty){
                              //       return 'Field is Required';
                              //     }else{
                              //       return null;
                              //     }
                              //   },
                              // ),
                              // SizedBox(height: 20.0),
                              //
                              // ///..........period................///
                              //
                              // EntryField(
                              //   color: Colors.grey.withOpacity(0.2),
                              //   controller: _periodController,
                              //   hint: 'Period',
                              //   validator: (value){
                              //     if(value.isEmpty){
                              //       return 'Field is Required';
                              //     }else{
                              //       return null;
                              //     }
                              //   },
                              // ),
                              // SizedBox(height: 20.0),


                              CustomButton(
                                label: 'Submit',
                                onTap: () {
                                  // FocusScopeNode currentFocus = FocusScope.of(context);
                                  // if (!currentFocus.hasPrimaryFocus) {
                                  //   currentFocus.unfocus();
                                  // }
                                  if(_image != null) {
                                    setState(() {
                                      _imageChecker = false;
                                    });
                                    Get.find<LoaderController>().updateFormController(true);
                                    uploadImage(_image);
                                  }else{
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
                        // if (educationList.length == 0) SizedBox() else Padding(
                        //   padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //         color: Colors.white,
                        //         borderRadius: BorderRadius.circular(5),
                        //         boxShadow: [
                        //           BoxShadow(
                        //               color: Colors.grey.withOpacity(0.4),
                        //               offset: Offset(0,1),
                        //               blurRadius: 9,
                        //               spreadRadius: 3
                        //           )
                        //         ]
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(5.0),
                        //       child: Column(
                        //         children: [
                        //           SizedBox(height: 8,),
                        //           Container(
                        //               decoration: BoxDecoration(
                        //                   color: Colors.white
                        //               ),
                        //               child: Row(
                        //                 children: [
                        //                   Expanded(
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Text(
                        //                         'Certificate',
                        //                         style: TextStyle(
                        //                             fontSize: 11,
                        //                             color: primaryColor
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Text(
                        //                         'Institution',
                        //                         style: TextStyle(
                        //                             fontSize: 11,
                        //                             color: primaryColor
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Text(
                        //                         'Discipline',
                        //                         style: TextStyle(
                        //                             fontSize: 11,
                        //                             color: primaryColor
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Expanded(
                        //                     child: Align(
                        //                       alignment: Alignment.center,
                        //                       child: Text(
                        //                         'Period',
                        //                         style: TextStyle(
                        //                             fontSize: 11,
                        //                             color: primaryColor
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   Icon(Icons.arrow_back,size: 13,color: Colors.white,)
                        //                 ],
                        //               )),
                        //           Divider(color: Colors.grey.withOpacity(0.8),),
                        //           Wrap(
                        //             children: List.generate(educationList.length, (index) {
                        //               return Column(
                        //                 children: [
                        //                   Slidable(
                        //                       closeOnScroll: true,
                        //                       controller: slidableController,
                        //                       actionPane: SlidableDrawerActionPane(),
                        //                       actionExtentRatio: 0.2,
                        //                       secondaryActions: <Widget>[
                        //                         IconSlideAction(
                        //                           color: Colors.blue,
                        //                           icon: Icons.edit,
                        //                           onTap: () {
                        //                             setState(() {
                        //                               _instituteController.text = educationList[index]['institution'];
                        //                               _disciplineController.text = educationList[index]['discipline'];
                        //                               _periodController.text = educationList[index]['period'];
                        //                               _image = educationList[index]['image'];
                        //
                        //                               _scrollController.animateTo(
                        //                                 _scrollController.position.minScrollExtent,
                        //                                 curve: Curves.easeOut,
                        //                                 duration: const Duration(milliseconds: 500),
                        //                               );
                        //
                        //                               educationList.removeAt(index);
                        //                             });
                        //                           },
                        //                         ),
                        //                         IconSlideAction(
                        //                           color: Colors.red,
                        //                           icon: Icons.delete,
                        //                           onTap: () {
                        //                             // postMethod(
                        //                             //     context,
                        //                             //     '$educationStoreDeleteService',
                        //                             //     null,
                        //                             //     true,
                        //                             //     deleteEducationStoreData
                        //                             // );
                        //                             setState(() {
                        //                               educationList.removeAt(index);
                        //                             });
                        //                           },
                        //                         ),
                        //                       ],
                        //                       child: Builder(
                        //                         builder: (BuildContext contextS)=>
                        //                             InkWell(
                        //                               onTap: (){
                        //                                 print('CLICK ${index}');
                        //                                 Slidable.of(contextS).open();
                        //                               },
                        //                               child: Container(
                        //                                 color: Colors.white,
                        //                                 height: 30,
                        //                                 child: Row(
                        //                                   children: [
                        //                                     Expanded(
                        //                                       child: Align(
                        //                                         alignment: Alignment.center,
                        //                                         child: Image.file(educationList[index]['image'],
                        //                                           width: 20,),
                        //                                       ),
                        //                                     ),
                        //                                     Expanded(
                        //                                       child: Align(
                        //                                           alignment: Alignment.center,
                        //                                           child: Text(
                        //                                             '${educationList[index]['institution']}',
                        //                                             softWrap: true,
                        //                                             overflow: TextOverflow.ellipsis,
                        //                                             style: TextStyle(
                        //                                                 fontSize: 11,
                        //                                                 color: Colors.black
                        //                                             ),
                        //                                           )
                        //                                       ),
                        //                                     ),
                        //                                     Expanded(
                        //                                       child: Align(
                        //                                           alignment: Alignment.center,
                        //                                           child: Text(
                        //                                             '${educationList[index]['discipline']}',
                        //                                             softWrap: true,
                        //                                             overflow: TextOverflow.ellipsis,
                        //                                             style: TextStyle(
                        //                                                 fontSize: 11,
                        //                                                 color: Colors.black
                        //                                             ),
                        //                                           )
                        //                                       ),
                        //                                     ),
                        //                                     Expanded(
                        //                                       child: Align(
                        //                                           alignment: Alignment.center,
                        //                                           child: Text(
                        //                                             '${educationList[index]['period']}',
                        //                                             softWrap: true,
                        //                                             overflow: TextOverflow.ellipsis,
                        //                                             style: TextStyle(
                        //                                                 fontSize: 11,
                        //                                                 color: Colors.black
                        //                                             ),
                        //                                           )
                        //                                       ),
                        //                                     ),
                        //
                        //                                     Icon(Icons.arrow_back,size: 13,color: primaryColor,)
                        //                                   ],
                        //                                 ),
                        //                               ),
                        //                             ),
                        //                         // ExperienceListShow(context: context,index: index,),
                        //                       )
                        //                   ),
                        //                   index == (educationList.length-1)
                        //                       ?SizedBox()
                        //                       :Divider(color: Colors.grey.withOpacity(0.3),),
                        //                 ],
                        //               );
                        //             }),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //   ),
                        // ),

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
          // floatingActionButton: educationList.length == 0
          //     ?SizedBox()
          //     :FloatingActionButton(
          //   backgroundColor: primaryColor,
          //   child: Icon(
          //     Icons.arrow_forward,
          //     color: Colors.white,
          //   ),
          //   onPressed: (){
          //     setState(() {
          //       widget.changeView(1);
          //     });
          //   },
          // ),
        ),
      ),
    );
  }

  uploadImage(File file) async {
    String fileName = file.path.split('/').last;
    dio_instance.FormData formData =
    dio_instance.FormData.fromMap(<String, dynamic>{
      'doctor_id': 49,
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
      response = await dio.post(
          getDoctorUpdateProfileService,
          data: formData);
      log('postStatusCode---->> ${response.statusCode}');
      log('postResponse---->> ${response.data}');
      if (response.statusCode.toString() == '200') {
        // setState(() {
        //   educationList.add(
        //       {
        //         // 'id':response.data['data']['id'],
        //         // 'institution': response.data['data']['institution'],
        //         // 'discipline': response.data['data']['discipline'],
        //         // 'period': response.data['data']['period'],
        //         'image': _image
        //       }
        //   );
        // });
        Get.find<LoaderController>().updateFormController(false);

        // _instituteController.clear();
        // _disciplineController.clear();
        // _periodController.clear();
        // _image = null;
        // log('LocalList---->> ${educationList}');

        setState(() {});
      }

    } on dio_instance.DioError catch (e) {
      Get.find<LoaderController>().updateFormController(false);
      log('putResponseError---->> ${e}');
    }
  }

}




