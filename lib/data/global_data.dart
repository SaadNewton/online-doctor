//@dart=2.9
import 'package:doctoworld_doctor/Auth/registration_data/signup_userdata_model.dart';
import 'package:doctoworld_doctor/Model/add_speciality_model.dart';
import 'package:doctoworld_doctor/Model/approve_appointment_model.dart';
import 'package:doctoworld_doctor/Model/check_status_model.dart';
import 'package:doctoworld_doctor/Model/education_model.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Model/remove_appointment_model.dart';
import 'package:doctoworld_doctor/Model/sign_up_model.dart';
import 'package:doctoworld_doctor/Model/user_detail_model.dart';
import 'package:doctoworld_doctor/repositories/check_doctor_status_repo.dart';
import 'package:flutter/material.dart';


UserDetailModel userDetailModel = UserDetailModel() ;
SignUpModel signUpModel = SignUpModel();
EducationModel educationModel = EducationModel();
GetAllAppointmentsModel getAllAppointmentsModel = GetAllAppointmentsModel();
CheckStatusModel checkStatusModel = CheckStatusModel();
ApproveAppointmentModel approveAppointmentModel = ApproveAppointmentModel();
RemoveAppointmentModel removeAppointmentModel = RemoveAppointmentModel();
DoctorStatusModel doctorStatusModel = DoctorStatusModel();
final TextEditingController nameController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController locationController = TextEditingController();
final TextEditingController numberController = TextEditingController();

AddSpecialityModel addSpecialityModel;

SignupUserdataModel signupUserdataModel;

final TextEditingController addressController = TextEditingController();

var longitude;
var latitude;
var currentAddress;