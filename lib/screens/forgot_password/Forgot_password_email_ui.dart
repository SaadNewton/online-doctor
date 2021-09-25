// @dart=2.9
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/change_password_repo.dart';
import 'package:doctoworld_doctor/screens/forgot_password/forgot_password_email_repo.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PasswordEmail extends StatefulWidget {

  @override
  _PasswordEmailState createState() => _PasswordEmailState();
}

class _PasswordEmailState extends State<PasswordEmail> {

  GlobalKey<FormState> _passwordEmailKey = GlobalKey();

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
          appBar: AppBar(
            title: Text('Send Email',
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
                key: _passwordEmailKey,
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
                              ///...........Email....................///
                              EntryField(
                                hint: 'Email',
                                prefixIcon: Icons.email,
                                color: Colors.grey.withOpacity(0.2),
                                controller: forgetEmailController,
                                validator: (value) {
                                  if (GetUtils.isEmail(forgetEmailController.text)) {
                                    return null;
                                  } else {
                                    return 'Please enter valid email';
                                  }
                                },

                              ),

                              SizedBox(height: 20),

                              SizedBox(height: 20.0),
                              CustomButton(
                                label: 'Submit',
                                onTap: (){
                                  FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (_passwordEmailKey.currentState.validate()){

                                    Get.find<LoaderController>().updateFormController(true);
                                    postMethod(
                                      context,
                                      forgotEmailService,
                                      {
                                        'email': forgetEmailController.text,
                                        'role': 'doctor'
                                      },
                                      true,
                                      forgotPasswordEmailRepo,
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


