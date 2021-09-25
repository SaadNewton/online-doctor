import 'package:doctoworld_doctor/screens/experience%20_form.dart';

///  Base Url

// String baseUrl = 'http://192.168.88.43:8000/api/';
String baseUrl = 'http://192.168.88.77:7000/api/';
String mediaUrl = 'http://192.168.88.77:7000/';

// String baseUrl = 'https://onlinedoctor.softwaresbranding.com/api/';
// String mediaUrl = 'https://onlinedoctor.softwaresbranding.com/';

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
String experienceStoreUpdateService = baseUrl + 'experience-update';
String experienceStoreDeleteService = baseUrl + 'delete-experience';

///  speciality store

String specialityStoreService = baseUrl + 'speciality-update';
String specialitiesListService = baseUrl + 'get-list-speciality';

/// get_all_Appointments

String getAllAppointmentsService = baseUrl + 'get-appointment-request';
String getDoneAppointmentsService = baseUrl + 'get-appointment-done';

///   Doctor profile

String getDoctorUpdateProfileService = baseUrl + 'update-profile';
String getDoctorProfileService = baseUrl + 'get-doctor-profile';

///  Approve Appointment

String approveAppointmentService = baseUrl + 'approve-appointment';

///  RemoveAppointment

String removeAppointmentService = baseUrl + 'appointment-remove';

///  checkDoctorStatusService

String checkDoctorStatusService = baseUrl + 'get-doctor-status';

///  scheduleStatusService

String scheduleSetService = baseUrl + 'schedule-manage';

///  doctorArticles

String getAllArticlesService = baseUrl + 'get-all-article';
String addArticlesService = baseUrl + 'article-store';
String deleteArticlesService = baseUrl + 'article-delete';
String updateArticlesService = baseUrl + 'article-update';
String allDoctorsArticlesService = baseUrl + 'get-all-articles';


///  Change Password

String changePasswordService = baseUrl + 'change-password';

///  clinic

String clinicStoreService = baseUrl + 'clinic-store';


