import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Auth/registration_data/registration_ui.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'login_repo.dart';
// ignore: import_of_legacy_library_into_null_safe

class LoginUI extends StatefulWidget {
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  GlobalKey<FormState> loginKey = GlobalKey();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  late final String? selected = '';
  List<String> items = [
    'Customer',
    'Doctor',
  ];

  // @override
  // void dispose() {
  //   _numberController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: GetBuilder<LoaderController>(
        init: LoaderController(),
        builder: (_) => ModalProgressHUD(
          inAsyncCall: _.formLoader,
          child: Scaffold(
            backgroundColor: theme.primaryColorLight,
            body: FadedSlideAnimation(
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        height: size.height * 0.55,
                        color: theme.backgroundColor,
                        // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        // child: Column(
                        //   crossAxisAlignment: CrossAxisAlignment.stretch,
                        //   children: [
                        //     Spacer(),
                        //     Expanded(
                        //         flex: 3,
                        //         child: Image.asset('assets/icons/doctor_logo.png')),
                        //     Spacer(),
                        //     Expanded(
                        //         flex: 3, child: Image.asset('assets/hero_image.png')),
                        //   ],
                        // ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Form(
                            key: loginKey,
                            child: Column(
                              children: [
                                // SizedBox(height: size.height * 0.51),
                                // Spacer(),
                                Expanded(
                                  child: Container(
                                    height: size.height * 0.55,
                                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        Spacer(),
                                        Expanded(
                                            flex: 3,
                                            child: Image.asset('assets/icons/doctor_logo.png')),
                                        Spacer(),
                                        Expanded(
                                            flex: 3, child: Image.asset('assets/hero_image.png')),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: EntryField(
                                    validator: (value) {
                                      if (GetUtils.isEmail(_emailController.text)) {
                                        return null;
                                      } else {
                                        return 'Please enter valid email';
                                      }
                                    },
                                    hint: 'Email',
                                    prefixIcon: Icons.email,
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    controller: _emailController,
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: EntryField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter valid password';
                                      }
                                      return null;
                                    },
                                    hint: 'Password',
                                    prefixIcon: Icons.remove_red_eye_outlined,
                                    obSecure: true,
                                    suffixIcon: Icons.remove_red_eye_outlined,
                                    color:
                                        Theme.of(context).scaffoldBackgroundColor,
                                    controller: _passController,
                                  ),
                                ),
                                SizedBox(height: 30.0),

                                CustomButton(onTap: () {
                                  if (loginKey.currentState!.validate()) {
                                    //    .loginWithEmail('', _emailController.text);
                                    _.updateFormController(true);
                                    postMethod(
                                        context,
                                        loginService,
                                        {
                                          'email': _emailController.text,
                                          'password': _passController.text,
                                          'role': 'doctor',
                                          'login_type': 'login_email'
                                        },
                                        false,
                                        getLoginData);
                                  }
                                }),
                                SizedBox(height: 60.0),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Don\'t Have an Account?  ',
                                        style:
                                            Theme.of(context).textTheme.subtitle1,
                                      ),
                                      TextSpan(
                                        text: 'Create new one',
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1!
                                            .copyWith(
                                                color:
                                                    Theme.of(context).primaryColor,
                                                decoration:
                                                    TextDecoration.underline),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RegistrationUIOld()));
                                            print('CREATE ACCOUNT');
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 15.0),

                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: CustomButton(
                                //         icon: Image.asset('assets/Icons/ic_fb.png',
                                //             scale: 2),
                                //         color: Color(0xff3b45c1),
                                //         label: locale.facebook,
                                //         onTap: () =>
                                //             widget.loginInteractor.loginWithFacebook(),
                                //       ),
                                //     ),
                                //     SizedBox(width: 20.0),
                                //     Expanded(
                                //       child: CustomButton(
                                //         label: locale.gmail,
                                //         icon: Image.asset('assets/Icons/ic_ggl.png',
                                //             scale: 3),
                                //         color: Theme.of(context).scaffoldBackgroundColor,
                                //         textColor: Theme.of(context).hintColor,
                                //         onTap: () =>
                                //             widget.loginInteractor.loginWithGoogle(),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              beginOffset: Offset(0, 0.3),
              endOffset: Offset(0, 0),
              slideCurve: Curves.linearToEaseOut,
            ),
          ),
        ),
      ),
    );
  }
}
