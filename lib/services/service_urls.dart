import 'package:doctoworld_doctor/screens/experience%20_form.dart';

///  Base Url

// String baseUrl = 'http://192.168.88.43:8000/api/';
String baseUrl = 'https://onlinedoctor.softwaresbranding.com/api/';

///  Doctor login

String loginService = baseUrl + 'login';

///   Doctor signup

String customerSignUpService = baseUrl + 'user-signup';

///  check email and phone status

String phoneEmailCheckService = baseUrl + 'check-phone-status';

///  Education store

String educationStoreService = baseUrl + 'education-store';
String educationStoreUpdateService = baseUrl + 'education-update';
String educationStoreDeleteService = baseUrl + 'delete-education';

///  Experience store

String experienceStoreService = baseUrl + 'experience-store';

///  speciality store

String specialityStoreService = baseUrl + 'speciality-update';
String specialitiesListService = baseUrl + 'get-list-speciality';

/// get_all_Appointments

String getAllAppointmentsService = baseUrl + 'get-appointment-request';

///   Doctor update profile

String getDoctorUpdateProfileService = baseUrl + 'update-profile';

///  Approve Appointment

String approveAppointmentService = baseUrl + 'approve-appointment';

///  RemoveAppointment

String removeAppointmentService = baseUrl + 'appointment-remove';

///  checkDoctorStatusService

String checkDoctorStatusService = baseUrl + 'get-doctor-status';
