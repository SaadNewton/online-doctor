// @dart=2.9

import 'package:doctoworld_doctor/Auth/log_in_data/login_ui.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/screens/all_appointment_screen.dart';
import 'package:doctoworld_doctor/screens/articles_screen.dart';
import 'package:doctoworld_doctor/screens/contact_us/contact_us_ui.dart';
import 'package:doctoworld_doctor/screens/customer_change_password.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/drawer_clinic_screen.dart';
import 'package:doctoworld_doctor/screens/drawer_education_form.dart';
import 'package:doctoworld_doctor/screens/drawer_experience_form.dart';
import 'package:doctoworld_doctor/screens/drawer_profile.dart';
import 'package:doctoworld_doctor/screens/drawer_schedule_form.dart';
import 'package:doctoworld_doctor/screens/drawer_speciality_form.dart';
import 'package:doctoworld_doctor/screens/experience%20_form.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ClipRRect(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          child: Drawer(
              child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
              color: Color(0xff3D464D),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(17, 25, 0, 0),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Doctor ${storageBox.read('user_detail')['data']['name']}',
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                onTap: () {
                                  Get.offAll(Dashboard());
                                },
                                leading: Icon(
                                  Icons.home_outlined,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Dashboard',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(DrawerDoctorProfile());
                                },
                                leading: Icon(
                                  Icons.person_outline,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Profile',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(DrawerEducationForm());
                                },
                                leading: Icon(
                                  Icons.school_outlined,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Education',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(DrawerExperienceForm());
                                },
                                leading: Icon(
                                  Icons.assignment_ind_outlined,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Experience',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(DrawerSpecialityForm());
                                },
                                leading: Icon(
                                  Icons.assignment_outlined,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Speciality',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(DrawerClinicScreen());
                                },
                                leading: Icon(
                                  Icons.add_chart,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Clinics',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(DrawerScheduleForm());
                                },
                                leading: Icon(
                                  Icons.access_time_outlined,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Schedule',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(ChangePassword());
                                },
                                leading: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Change Password',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                              Container(
                                height: 0.5,
                                color: Colors.white.withOpacity(0.5),
                              ),
                              ListTile(
                                onTap: () {
                                  Get.to(ContactUs());
                                },
                                leading: Icon(
                                  Icons.contact_page,
                                  color: Colors.white,
                                ),
                                title: Text(
                                  'Contact Us',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    storageBox.remove('session');
                    storageBox.remove('approved');
                    storageBox.remove('profile');
                    storageBox.erase();
                    Get.offAll(LoginUI());
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Container(
                      height: 38,
                      width: MediaQuery.of(context).size.width * .3,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
