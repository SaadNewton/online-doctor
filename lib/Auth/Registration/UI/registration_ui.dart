import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Auth/Verification/UI/verification_ui.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/services/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';



class RegistrationUI extends StatefulWidget {



  @override
  _RegistrationUIState createState() => _RegistrationUIState();
}

class _RegistrationUIState extends State<RegistrationUI> {

  GlobalKey<FormState> numberKey  = GlobalKey();



  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: theme.primaryColorLight,
        body: FadedSlideAnimation(
          SingleChildScrollView(
            child: Container(
              height: size.height + 50,
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.65,
                    color: theme.backgroundColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Form(
                      key: numberKey,
                      child: Column(
                        children: [
                          SizedBox(height: size.height * 0.595),
                          EntryField(
                            hint: locale.enterMobileNumber,
                            textInputType: TextInputType.phone,
                            prefixIcon: Icons.phone_iphone,
                            color: theme.scaffoldBackgroundColor,
                            controller: numberController,
                            validator: (value){
                              if(value!.isEmpty){
                                return 'Field Required';
                              }else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20.0),
                          CustomButton(
                              onTap: () {
                               if(numberKey.currentState!.validate()){

                                 if(numberController.text.contains('+92')){
                                   print('NUMBER--->>${numberController.text}');
                                 otpFunction(
                                       numberController.text,
                                       context
                                   );
                                   Get.to(VerificationUI(number:  numberController));
                                 }else{
                                   if(numberController.text.startsWith('0'))
                                   setState(() {
                                     numberController.text = numberController.text.replaceFirst('0', '+92');
                                   });
                                   print('NUMBER--->>${numberController.text}');

                                   otpFunction(
                                       numberController.text,
                                       context
                                   );
                                   Get.to(VerificationUI(number:  numberController));
                                 }

                               }
                              }

                                  ),
                          Spacer(flex: 2),
                          Text(
                            locale.orQuickContinueWith!,
                            style: theme.textTheme.subtitle1,
                          ),

                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: CustomButton(
                          //         icon: Image.asset('assets/icons/ic_fb.png',
                          //             scale: 2),
                          //         color: facebookButtonColor,
                          //         label: locale.facebook,
                          //         onTap: () =>
                          //             widget.loginInteractor.loginWithFacebook(),
                          //       ),
                          //     ),
                          //     SizedBox(width: 20.0),
                          //     Expanded(
                          //       child: CustomButton(
                          //         label: locale.gmail,
                          //         icon: Image.asset(
                          //           'assets/icons/ic_ggl.png',
                          //           scale: 3,
                          //         ),
                          //         color: theme.scaffoldBackgroundColor,
                          //         textColor: theme.hintColor,
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
                ],
              ),
            ),
          ),
          beginOffset: Offset(0, 0.3),
          endOffset: Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }

}
