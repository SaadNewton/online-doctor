//@dart=2.9
import 'package:doctoworld_doctor/Auth/registration_data/signup_userdata_model.dart';
import 'package:doctoworld_doctor/Model/add_speciality_model.dart';
import 'package:doctoworld_doctor/Model/agora_model.dart';
import 'package:doctoworld_doctor/Model/approve_appointment_model.dart';
import 'package:doctoworld_doctor/Model/change_password_model.dart';
import 'package:doctoworld_doctor/Model/check_status_model.dart';
import 'package:doctoworld_doctor/Model/clinic_store_model.dart';
import 'package:doctoworld_doctor/Model/education_model.dart';
import 'package:doctoworld_doctor/Model/get_all_appointments_model.dart';
import 'package:doctoworld_doctor/Model/get_all_doctors_articles.dart';
import 'package:doctoworld_doctor/Model/get_articles_model.dart';
import 'package:doctoworld_doctor/Model/get_doctor_profile_modal.dart';
import 'package:doctoworld_doctor/Model/get_notify_token_model.dart';
import 'package:doctoworld_doctor/Model/get_speciality_list_model.dart';
import 'package:doctoworld_doctor/Model/remove_appointment_model.dart';
import 'package:doctoworld_doctor/Model/sign_up_model.dart';
import 'package:doctoworld_doctor/Model/user_detail_model.dart';
import 'package:doctoworld_doctor/repositories/check_doctor_status_repo.dart';
import 'package:doctoworld_doctor/screens/contact_us/contact_us_model.dart';
import 'package:doctoworld_doctor/screens/forgot_password/forget_password_email_model.dart';
import 'package:doctoworld_doctor/screens/forgot_password/forget_password_email_verify_model.dart';
import 'package:doctoworld_doctor/screens/forgot_password/forget_password_model.dart';
import 'package:flutter/material.dart';

UserDetailModel userDetailModel = UserDetailModel();
SignUpModel signUpModel = SignUpModel();
EducationModel educationModel = EducationModel();
GetAllAppointmentsModel getAllAppointmentsModel = GetAllAppointmentsModel();
GetAllAppointmentsModel getDoneAppointmentsModel = GetAllAppointmentsModel();
CheckStatusModel checkStatusModel = CheckStatusModel();
ApproveAppointmentModel approveAppointmentModel = ApproveAppointmentModel();
RemoveAppointmentModel removeAppointmentModel = RemoveAppointmentModel();
GetSpecialityListModel getSpecialityListModel = GetSpecialityListModel();
DoctorStatusModel doctorStatusModel = DoctorStatusModel();
GetArticlesModel getArticlesModel = GetArticlesModel();
GetAllDoctorsArticles getAllDoctorsArticles = GetAllDoctorsArticles();
GetDoctorProfileModal getDoctorProfileModal = GetDoctorProfileModal();
ChangePasswordModel changePasswordModel = ChangePasswordModel();
ClinicStoreModel clinicStoreModel = ClinicStoreModel();
ContactUsModel contactUsModel = ContactUsModel();
ForgetPasswordEmailVerifyModel forgetPasswordEmailVerifyModel = ForgetPasswordEmailVerifyModel();
ForgetPasswordEmailModel forgetPasswordEmailModel = ForgetPasswordEmailModel();
ForgetPasswordModel forgetPasswordModel = ForgetPasswordModel();

final TextEditingController nameController = TextEditingController();
final TextEditingController usernameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passController = TextEditingController();
final TextEditingController confirmPassController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController locationController = TextEditingController();
final TextEditingController numberController = TextEditingController();


final TextEditingController forgetEmailController = TextEditingController();

TextEditingController updateEmailController = TextEditingController();
TextEditingController updateLocationController = TextEditingController();


AddSpecialityModel addSpecialityModel;

SignupUserdataModel signupUserdataModel;

final TextEditingController addressController = TextEditingController();

var longitude;
var latitude;
var currentAddress;

GetNotifyTokenModel getNotifyTokenModel=GetNotifyTokenModel();