import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:doctoworld_doctor/Components/custom_button.dart';
import 'package:doctoworld_doctor/Components/custom_dialog.dart';
import 'package:doctoworld_doctor/Components/entry_field.dart';
import 'package:doctoworld_doctor/Locale/locale.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/repositories/phone_email_check_repo.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/screens/terms_and_conditions.dart';
import 'package:doctoworld_doctor/services/post_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter/services.dart';

class RegistrationUIOld extends StatefulWidget {
  @override
  _RegistrationUIOldState createState() => _RegistrationUIOldState();
}

class _RegistrationUIOldState extends State<RegistrationUIOld> {
  GlobalKey<FormState> signKey = GlobalKey();

  var currentPosition;
  bool? obSecureText = true;
  bool? confirmObSecureText = true;
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
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
            backgroundColor: Theme.of(context).backgroundColor,
            resizeToAvoidBottomInset: false,
            // appBar: AppBar(
            //   title: Text(locale.registerNow!),
            //   textTheme: Theme.of(context).textTheme,
            //   centerTitle: true,
            // ),
            body: SafeArea(
              child: FadedSlideAnimation(
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: Form(
                    key: signKey,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Column(
                          children: [
                            Center(
                                child: Image.asset(
                              'assets/icons/doctor_logo.png',
                              width: 100,
                            )),

                            SizedBox(height: 10),

                            /// name
                            EntryField(
                              textInputFormatter: FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
                              controller: nameController,
                              prefixIcon: Icons.person,
                              textInputType: TextInputType.name,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              hint: 'Name',
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            /// user-name

                            // EntryField(
                            //   controller: _usernameController,
                            //   prefixIcon: Icons.person,
                            //   hint: 'User Name',
                            //   validator: (value) {
                            //     if (value.isEmpty) {
                            //       return 'Field is Required';
                            //     } else {
                            //       return null;
                            //     }
                            //   },
                            // ),
                            // SizedBox(height: 20.0),

                            /// Email
                            EntryField(
                              controller: emailController,
                              prefixIcon: Icons.mail,
                              textInputType: TextInputType.emailAddress,
                              hint: locale.emailAddress,
                              color: Theme.of(context).scaffoldBackgroundColor,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field is Required';
                                } else if (!GetUtils.isEmail(emailController.text)) {
                                  return 'Please Enter Valid Email';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            /// phone
                            EntryField(
                              textInputFormatter: LengthLimitingTextInputFormatter(11),
                              controller: phoneController,
                              textInputType: TextInputType.phone,
                              prefixIcon: Icons.phone_iphone,
                              hint: 'Phone',
                              color: Theme.of(context).scaffoldBackgroundColor,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field is Required';
                                } else if (value.length != 11) {
                                  return 'Enter Valid Number';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            /// password
                            EntryField(
                              controller: passController,
                              obSecure: obSecureText,
                              prefixIcon: Icons.lock,
                              suffixIcon: Icons.remove_red_eye_outlined,
                              suffixIconShow: Icons.remove_red_eye_sharp,
                              hint: 'Password',
                              color: Theme.of(context).scaffoldBackgroundColor,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field is Required';
                                } else if(value.length < 8){
                                  return 'Password length must be greater than 8';
                                }else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            /// confirm pass
                            EntryField(
                              controller: confirmPassController,
                              obSecure: confirmObSecureText,
                              prefixIcon: Icons.lock,
                              suffixIcon: Icons.remove_red_eye_outlined,
                              suffixIconShow: Icons.remove_red_eye_sharp,
                              hint: 'Confirm Password',
                              color: Theme.of(context).scaffoldBackgroundColor,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Field is Required';
                                } else if (passController.text !=
                                    confirmPassController.text) {
                                  return 'Password not match';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            ///  Location
                            TextFormField(
                              controller: locationController,
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
                                hintStyle: TextStyle(color: Colors.grey),
                                filled: true,
                                fillColor: Theme.of(context).scaffoldBackgroundColor,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Field is Required';
                                } else {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(height: 20.0),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  icon: Icon( selected ? Icons.check_box : Icons.check_box_outline_blank, color: Colors.blue,),
                                  onPressed: () {
                                    setState(() {
                                      selected = !selected;
                                    });
                                  },
                                ),
                                SizedBox(width: 8),
                                RichText(
                                  text: TextSpan(
                                      text: 'I accept the',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 14),
                                      children: <TextSpan>[
                                        TextSpan(text: ' Terms and Conditions.',
                                            style: TextStyle(
                                                color: Colors.blueAccent, fontSize: 16),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TermsAndConditions()));
                                              }
                                        )
                                      ]
                                  ),
                                ),

                              ],
                            ),
                           SizedBox(height: 20),
                            CustomButton(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                if (signKey.currentState!.validate()) {
                                  if(selected == true){
                                    Get.find<LoaderController>()
                                        .updateFormController(true);
                                    postMethod(
                                        context,
                                        phoneEmailCheckService,
                                        {
                                          'phone': phoneController.text,
                                          'email': emailController.text,
                                          'role': 'doctor'
                                        },
                                        false,
                                        phoneEmailCheckRepo
                                    );
                                  }else{
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return CustomDialogBox(
                                            title: 'Failed',
                                            titleColor: customDialogErrorColor,
                                            descriptions: 'Please Accept Terms And Conditions.',
                                            text: 'Ok',
                                            functionCall: () {
                                              Navigator.pop(context);
                                            },
                                            img: 'assets/dialog_error.svg',
                                          );
                                        });
                                  }
                                }
                              },
                            ),
                            SizedBox(height: 10.0),
                            CustomButton(
                                label: locale.backToSignIn,
                                color: Theme.of(context).scaffoldBackgroundColor,
                                textColor: Theme.of(context).hintColor,
                                onTap: () {
                                  Navigator.pop(context);
                                }),

                            SizedBox(height: 10.0),

                            // CustomButton(
                            //     color: Theme.of(context).scaffoldBackgroundColor,
                            //     onTap: () {
                            //       Get.to(VerificationUI());
                            //     }),

                            Text(
                              locale.wellSendAnOTP!,
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Theme.of(context).disabledColor),
                            ),
                            SizedBox(height: 10.0),

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
        ),
      ),
    );
  }

  getCurrentLocation(BuildContext context) {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        longitude = currentPosition!.longitude;
        latitude = currentPosition!.latitude;

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
              currentPosition!.latitude, currentPosition!.longitude);
      Placemark place = p[0];
      setState(() {
        currentAddress =
            '${place.name}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}';
        // var signUpAddressController;
        // if (signUpAddressController.text.isEmpty) {
        //   signUpAddressController.text = currentAddress;
        // }
        print(currentAddress + ' yes');
        print(place.street.toString());
        print('locality ${place.locality.toString()}');
        print('near by ${place.subLocality}');
        print(place.administrativeArea.toString());
        print(place.subAdministrativeArea.toString());
        print(place.thoroughfare.toString());
        print(place.toJson().toString());
        // FocusScope.of(context).unfocus();
        locationController.text = currentAddress.toString();
      });
    } catch (e) {
      print(e);
    }
  }
}
