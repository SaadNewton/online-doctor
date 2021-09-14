//@dart=2.9
import 'dart:async';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/services/otp_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class VerificationUI extends StatefulWidget {
  final number;
  final bool fromSignUpForm;
  VerificationUI({this.number,this.fromSignUpForm});

  @override
  _VerificationUIState createState() => _VerificationUIState();

}

class _VerificationUIState extends State<VerificationUI> {
  final TextEditingController _OtpController = TextEditingController();
  int _counter = 55;
   Timer _timer;

  _startTimer() {
    _counter = 55; //time counter
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _counter > 0 ? _counter-- : _timer.cancel();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();

  }

  @override
  void dispose() {
    _OtpController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    return GetBuilder<LoaderController>(
      builder: (loaderController)=>ModalProgressHUD(
        inAsyncCall: loaderController.formLoader,
        child: Scaffold(
          appBar: AppBar(
            title: Text(locale.phoneVerification),
            centerTitle: true,
          ),
          body: FadedSlideAnimation(
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      locale.weveSentAnOTP,
                      style: Theme.of(context).textTheme.bodyText1,
                      textAlign: TextAlign.center,
                    ),
                    Spacer(flex: 2),
                    EntryField(
                      controller: _OtpController,
                      hint: "Enter 6 Digit Otp",
                      textAlign: TextAlign.center,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 20.0),
                    CustomButton(
                      onTap: () {
                        Get.find<LoaderController>().updateFormController(true);
                        verifyOTP(
                          context,
                          _OtpController.text,
                          widget.fromSignUpForm
                        );
                      },
                      label: locale.submit,
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      children: <Widget>[
                        Text(
                          '$_counter' + locale.secLeft,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Spacer(
                          flex: 2,
                        ),
                        Expanded(
                          child: CustomButton(
                              label: locale.resend,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              textColor: _counter < 1
                                  ?Theme.of(context).hintColor
                                  :Colors.grey.withOpacity(0.5),
                              padding: 0.0,
                              onTap: _counter < 1
                                  ? () {
                                        otpFunction(
                                            numberController.text,
                                            context);
                                      _startTimer();
                                    }
                                  : null),
                        ),
                      ],
                    ),
                    Spacer(flex: 12),
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
    );
  }
}
