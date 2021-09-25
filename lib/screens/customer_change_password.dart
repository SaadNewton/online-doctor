// @dart=2.9
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/change_password_repo.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePassword extends StatefulWidget {

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  GlobalKey<FormState> _changePasswordKey = GlobalKey();
  TextEditingController _currentPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


  final _scrollController = ScrollController();

  bool oldObscure = true;
  bool newObscure = true;
  bool confirmObscure = true;
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
            title: Text('Change Password',
              style: TextStyle(color: Colors.black),
            ),
            iconTheme: IconThemeData(color: Colors.black),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: false,
          body: FadedSlideAnimation(
            Container(
              height: MediaQuery.of(context).size.height,
              child: Form(
                key: _changePasswordKey,
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

                              SizedBox(height: 20),
                              ///...........Current Password....................///
                              EntryField(
                                controller: _currentPasswordController,
                                obSecure: oldObscure,
                                prefixIcon: Icons.lock,
                                suffixIcon: Icons.remove_red_eye_outlined,
                                hint: 'Current Password',
                                color: Colors.grey.withOpacity(0.2),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 20),


                              ///...........New Password....................///
                              EntryField(
                                controller: _newPasswordController,
                                obSecure: newObscure,
                                prefixIcon: Icons.lock,
                                suffixIcon: Icons.remove_red_eye_outlined,
                                hint: 'New Password',
                                color: Colors.grey.withOpacity(0.2),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else if(value.length < 6){
                                    return 'Password length must be greater than 6';
                                  }else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),

                              ///..........Confirm Password................///

                              EntryField(
                                controller: _confirmPasswordController,
                                obSecure: confirmObscure,
                                prefixIcon: Icons.lock,
                                suffixIcon: Icons.remove_red_eye_outlined,
                                hint: 'Confirm Password',
                                color: Colors.grey.withOpacity(0.2),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else if (_newPasswordController.text !=
                                      _confirmPasswordController.text) {
                                    return 'Password not match';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              CustomButton(
                                label: 'Submit',
                                onTap: (){
                                  FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if(_changePasswordKey.currentState.validate()){
                                    Get.find<LoaderController>().updateFormController(true);
                                    postMethod(
                                      context,
                                      changePasswordService,
                                      {
                                        'user_id': storageBox.read('doctor_id'),
                                        'curent_password': _currentPasswordController.text,
                                        'password': _newPasswordController.text,
                                        'confirm_password': _confirmPasswordController.text,
                                        'role': 'doctor'
                                      },
                                      true,
                                        changePasswordRepo,
                                    );

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

        ),
      ),
    );
  }

}


