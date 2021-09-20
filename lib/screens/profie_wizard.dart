// @dart=2.9
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/repositories/get_speciality_list_repo.dart';
import 'package:doctoworld_doctor/screens/doctor_profile-form.dart';
import 'package:doctoworld_doctor/screens/education_form.dart';
import 'package:doctoworld_doctor/screens/experience%20_form.dart';
import 'package:doctoworld_doctor/screens/schedule_form.dart';
import 'package:doctoworld_doctor/screens/speciality_form.dart';
import 'package:doctoworld_doctor/services/get_method_call.dart';
import 'package:doctoworld_doctor/services/service_urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

List profileList = [];
List educationList = [];
List experienceList = [];
List specialityList = [];
List scheduleList = [];
List<String> getSpecialitiesList = [];

class ProfileWizard extends StatefulWidget {
  @override
  _ProfileWizardState createState() => _ProfileWizardState();
}

class _ProfileWizardState extends State<ProfileWizard>
    with SingleTickerProviderStateMixin {
  TabController profileWizardTabController;
  int profileWizardTabIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<LoaderController>().updateFormController(true);
    });
    profileWizardTabController = new TabController(length: 5, vsync: this);
    getMethod(
        context, specialitiesListService, null, true, getSpecialityListRepo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Doctor Profile Wizard'),
          textTheme: Theme.of(context).textTheme,
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                height: 53,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(0, 1),
                          blurRadius: 9,
                          spreadRadius: 2)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: TabBar(
                  isScrollable: true,
                  controller: profileWizardTabController,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black,
                  labelStyle: Theme.of(context).textTheme.headline5.copyWith(
                      fontWeight: FontWeight.w600, color: Colors.white),
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: primaryColor),
                  tabs: [
                    Center(
                      child: new Text(
                        'Personal',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: new Text(
                        'Education',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: new Text(
                        'Experience',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: new Text(
                        'Speciality',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Center(
                      child: new Text(
                        'Schedule',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                  onTap: (v) {
                    print(v.toString());
                    setState(() {
                      profileWizardTabIndex = v;
                    });
                    switch (v) {
                      case 0:
                        return {};
                        break;
                      case 1:
                        return {};

                        break;
                      case 2:
                        return {};

                        break;
                      case 3:
                        return {};
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: viewSelectorMethod(profileWizardTabIndex))
            ],
          ),
        ),
      ),
    );
  }

  changeView(int index) {
    setState(() {
      profileWizardTabIndex = index;
      profileWizardTabController.index = index;
    });
  }

  viewSelectorMethod(int profileTab) {
    switch (profileTab) {
      case 0:
        {
          return DoctorProfile(
            changeView: changeView,
          );
        }
        break;
      case 1:
        {
          return EducationForm(
            changeView: changeView,
          );
        }
        break;
      case 2:
        {
          return ExperienceForm(changeView: changeView);
        }
        break;
      case 3:
        {
          return SpecialityForm(changeView: changeView);
        }
        break;
      case 4:
        {
          return ScheduleForm();
        }
        break;
    }
  }
}
