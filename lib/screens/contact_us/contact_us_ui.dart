// @dart=2.9
import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/screens/contact_us/contact_us_repo.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ContactUs extends StatefulWidget {

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {

  GlobalKey<FormState> _contactUsKey = GlobalKey();
  TextEditingController _contactNameController = TextEditingController();
  TextEditingController _contactEmailController = TextEditingController();
  TextEditingController _contactSubjectController = TextEditingController();
  TextEditingController _contactMessageController = TextEditingController();




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
            title: Text('Contact Us',
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
                key: _contactUsKey,
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
                              ///...........Name....................///
                              EntryField(
                                textInputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                                controller: _contactNameController,
                                color: Colors.grey.withOpacity(0.2),
                                hint: 'Name',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),

                              SizedBox(height: 20),

                              ///...........Email....................///
                              EntryField(
                                controller: _contactEmailController,
                                color: Colors.grey.withOpacity(0.2),
                                hint: 'Email',
                                validator: (value) {
                                  if (GetUtils.isEmail(_contactEmailController.text)) {
                                    return null;
                                  } else {
                                    return 'Please enter valid email';
                                  }
                                },
                              ),

                              SizedBox(height: 20.0),
                              ///...........Subject....................///
                              EntryField(
                                controller: _contactSubjectController,
                                color: Colors.grey.withOpacity(0.2),
                                hint: 'Subject',
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Field is Required';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              ///...........Message....................///
                              EntryField(
                                maxLines: 6,
                                controller: _contactMessageController,
                                color: Colors.grey.withOpacity(0.2),
                                hint: 'Message',
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
                                onTap: (){
                                  FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  if (_contactUsKey.currentState.validate()){

                                    Get.find<LoaderController>().updateFormController(true);
                                    postMethod(
                                      context,
                                      contactUsService,
                                      {
                                        'user_id': storageBox.read('doctor_id'),
                                       'name': _contactNameController.text,
                                        'email': _contactEmailController.text,
                                        'subject': _contactSubjectController.text,
                                        'message': _contactMessageController.text
                                      },
                                      true,
                                      contactUsRepo,
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


