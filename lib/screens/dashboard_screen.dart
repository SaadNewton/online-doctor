//@dart=2.9
import 'dart:async';

import 'package:dio/dio.dart' as dio_instance;
import 'package:doctoworld_doctor/Auth/log_in_data/login_ui.dart';
import 'package:doctoworld_doctor/Auth/phone_auth_ui.dart';
import 'package:doctoworld_doctor/BottomNavigation/Appointment/my_appointments.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/check_doctor_status_repo.dart';
import 'package:doctoworld_doctor/screens/education_form.dart';
import 'package:doctoworld_doctor/screens/experience%20_form.dart';
import 'package:doctoworld_doctor/screens/speciality_form.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:doctoworld_doctor/storage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  List<dynamic> dashboard = [{'text1': '0 PKR', 'text2': 'Total Online Earn', 'image': 'assets/orange.png', 'icon': Icons.credit_card},
    {'text1': '0 PKR', 'text2': 'Total Cash Earn', 'image': 'assets/blue.png', 'icon': Icons.account_balance_wallet_outlined},
    {'text1': '0', 'text2': 'New Appointment', 'image': 'assets/orange.png', 'icon': Icons.group_rounded},
    {'text1': '0', 'text2': 'Appointment Done', 'image': 'assets/blue.png', 'icon': Icons.check_circle_outline}];

// final List<Color> colors = <Color>[customOrangeColor, primaryColor, Colors.red, Colors.green];
  final List<Color>  color1 = <Color>[Color(0xff8E54E9), Color(0xff3A7BD5), Color(0xff2948FF), Color(0xff38EF7D)];
  final List<Color>  color2 = <Color>[Color(0xff4776E6), Color(0xff00D2FF), Color(0xff396AFC), Color(0xff11998E)];

  List<dynamic> drawerDetail = [
    {'leading': Icons.home, 'title': 'Dashboard', 'go': Dashboard()},
    {'leading': Icons.assignment, 'title': 'Appointments', 'go': MyAppointmentsBody()},
    {'leading': Icons.person_rounded, 'title': 'Speciality', 'go': SpecialityForm()},
    {'leading': Icons.account_circle_outlined, 'title': 'Profile', 'go': Dashboard()},
    {'leading': Icons.announcement, 'title': 'About You', 'go': Dashboard()},
    {'leading': Icons.school, 'title': 'Education', 'go': Dashboard()},
    {'leading': Icons.format_align_center, 'title': 'Experience', 'go': Dashboard()},
    {'leading': Icons.logout, 'title': 'Logout', 'go': Dashboard()},
  ];

  viewChange(int index){
    switch(index){
      case 0:
        return {};
        break;
      case 1:
        return {};
        break;
      case 2:
        return {
          Get.to(MyAppointmentsBody())
        };
        break;
      case 3:
        return {};
        break;
    }
  }

  viewChangeOfDrawer(int index){
    switch(index){
      case 0:
        return {
          Navigator.pop(context)
        };
        break;
      case 1:
        return {
          Get.to(MyAppointmentsBody())
        };
        break;
      case 2:
        return {
          Navigator.pop(context)
        };
        break;
      case 3:
        return {
          Navigator.pop(context)
        };
        break;
      case 4:
        return {
          Navigator.pop(context)
        };
        break;
      case 5:
        return {
          Navigator.pop(context)
        };
        break;
      case 6:
        return {
          Navigator.pop(context)
        };
        break;
      case 7:
        return {
          storageBox.remove('session'),
          storageBox.remove('approved'),
          Get.offAll(LoginUI()),
        };
        break;
    }
  }

  checkDoctorStatus() {
    if (!Get.find<LoaderController>().checkDoctorStatusLoader)  {
      print('aaa');
      getMethod(
          context,
          checkDoctorStatusService,
          {'doctor_id': storageBox.read('doctor_id')},
          true,
          doctorStatusRepo);
    }
  }
  @override
  void initState() {
    // storageBox.remove('approved');
    // TODO: implement initState
    super.initState();
    if (!storageBox.hasData('approved')){
      Timer.periodic(
          Duration(seconds: 2),
              (Timer t){
            checkDoctorStatus();
          });
    }else{
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.find<LoaderController>().updateCheckDoctorStatusLoader(true);

      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoaderController>(
      builder: (loaderController)=> !loaderController.checkDoctorStatusLoader
          ? Scaffold(
        backgroundColor: backgroundColor,
          body: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/doctor_logo.png',width: MediaQuery.of(context).size.width*.4,),
                  SizedBox(height: 30,),
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    radius: 150,
                    child: Text(
                      'Please wait\n Your request has been sent for approval.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    )
                  ),
                ],
              )
            ),
          )
      )
          :Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
          title: Text('Dashboard',
            style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
        ),
        drawer: Drawer(
          child: Container(
            width: 250,
            child: Column(
              children: [
                Container(
                  height: 160,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color(0xff8E54E9),
                        Color(0xff4776E6),

                      ],
                    ),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                  ),
                  child: Image.asset('assets/splash-logo.png'),
                ),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: drawerDetail.length,
                  itemBuilder: (context, index){
                    return  ListTile(
                      leading: Icon(drawerDetail[index]['leading']),
                      title: InkWell(child: Text(drawerDetail[index]['title']),
                        onTap: (){
                          viewChangeOfDrawer(index);
                        },
                      ),

                    );

                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 1.0,
                    color: Colors.black.withOpacity(0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Container(
          color: Color(0xffF4F7F8),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child:  Container(
            child: ListView.builder(
              itemCount: dashboard.length ,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: (){
                    viewChange(index);
                  },
                  child: Container(
                    child:  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: SizedBox(
                        height: 159,
                        child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5
                                        )]
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      height: double.infinity,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(dashboard[index]['image']),
                                              fit: BoxFit.fill),
                                          //  color: Colors.white,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [BoxShadow(
                                              color: Colors.grey.withOpacity(0.2),
                                              spreadRadius: 2,
                                              blurRadius: 5
                                          )],
                                          gradient: LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                              color1[index],
                                              color2[index],
                                            ],
                                          )
                                      ),
                                      child:Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //   SvgPicture.asset('assets/doctor icon.svg',
                                            // height: 40,),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  Icon(dashboard[index]['icon'],
                                                    color: Colors.white38,
                                                    size: 65,
                                                  ),
                                                ]
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(dashboard[index]['text2'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                Text(dashboard[index]['text1'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
