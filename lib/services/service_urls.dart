import 'package:doctoworld_doctor/screens/experience%20_form.dart';

///  Base Url

String baseUrl = 'http://192.168.88.43:8000/api/';
String mediaUrl = 'http://192.168.88.43:8000/';

// String baseUrl = 'http://192.168.88.77:7000/api/';
// String mediaUrl = 'http://192.168.88.77:7000/';

// String baseUrl = 'https://onlinedoctor.softwaresbranding.com/api/';
// String mediaUrl = 'https://onlinedoctor.softwaresbranding.com/';
String fcmService = 'https://fcm.googleapis.com/fcm/send';



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
String scheduleDeleteService = baseUrl + 'schedule-delete';

///  doctorArticles

String getAllArticlesService = baseUrl + 'get-all-article';
String addArticlesService = baseUrl + 'article-store';
String deleteArticlesService = baseUrl + 'article-delete';
String updateArticlesService = baseUrl + 'article-update';
String allDoctorsArticlesService = baseUrl + 'get-all-articles';


///  Change Password

String changePasswordService = baseUrl + 'change-password';

///  contact us

String contactUsService = baseUrl + 'contact-us';

///  forgot

String forgotEmailService = baseUrl + 'forgot-password-email';
String forgotEmailVerifyService = baseUrl + 'forgot-password-email-verify';
String resetPasswordService = baseUrl + 'reset-password';

///  clinic

String clinicStoreService = baseUrl + 'clinic-store';
String clinicDeleteService = baseUrl + 'clinic-delete';


/// get-notify-token-by-user
///
String getNotifyTokenService=baseUrl+'get-notify-token-by-user';

/// create-notify-user
///
String createNotifyUserService=baseUrl+'create-notify-user';