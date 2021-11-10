// @dart = 2.9
import 'package:doctoworld_doctor/Auth/log_in_data/login_ui.dart';
import 'package:doctoworld_doctor/Routes/routes.dart';
import 'package:doctoworld_doctor/Theme/colors.dart';
import 'package:doctoworld_doctor/call/join_channel_video.dart';
import 'package:doctoworld_doctor/controllers/auth_controller.dart';
import 'package:doctoworld_doctor/controllers/loading_controller.dart';
import 'package:doctoworld_doctor/data/global_data.dart';
import 'package:doctoworld_doctor/screens/all_appointment_screen.dart';
import 'package:doctoworld_doctor/screens/dashboard_screen.dart';
import 'package:doctoworld_doctor/screens/education_form.dart';
import 'package:doctoworld_doctor/screens/profie_wizard.dart';
import 'package:doctoworld_doctor/screens/splash.dart';
import 'package:doctoworld_doctor/services/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'Auth/Verification/UI/verification_ui.dart';
import 'Locale/language_cubit.dart';
import 'Locale/locale.dart';
import 'Theme/style.dart';


Future<void> backgroundHandler(RemoteMessage message) async {
  String route,channelName,channelToken;
  if(message.data['channel']!=null){
    Get.find<LoaderController>().updateCallerType(1);
    channelName=message.data['channel'];
    channelToken=message.data['channel_token'];
    Get.find<LoaderController>().agoraModelDefault.channelName = message.data['channel'];
    Get.find<LoaderController>().agoraModelDefault.token = message.data['channel_token'];
    Get.find<LoaderController>().updateAgoraModelDefault(Get.find<LoaderController>().agoraModelDefault);
  }
  if(message.data['routeApp']!=null){
    route=message.data['routeApp'];
    Get.toNamed(route);

  }

  LocalNotificationService.display(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: transparentColor));
  Get.put(AuthController());
  Get.put(TokenController());
  Get.put(LoaderController());
  runApp(DoctoWorldDoctor());
}

class DoctoWorldDoctor extends StatefulWidget {
  @override
  _DoctoWorldDoctorState createState() => _DoctoWorldDoctorState();
}

class _DoctoWorldDoctorState extends State<DoctoWorldDoctor> {
  @override
  void initState() {
    // TODO: implement initState
    LocalNotificationService.initialize(context);
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      String route,channelName,channelToken;
      if(message.data['channel']!=null){
        Get.find<LoaderController>().updateCallerType(1);
        channelName=message.data['channel'];
        channelToken=message.data['channel_token'];
        Get.find<LoaderController>().agoraModelDefault.channelName = message.data['channel'];
        Get.find<LoaderController>().agoraModelDefault.token = message.data['channel_token'];
        Get.find<LoaderController>().updateAgoraModelDefault(Get.find<LoaderController>().agoraModelDefault);
      }
      if(message.data['routeApp']!=null){
        route=message.data['routeApp'];
        Get.toNamed(route);

      }

      // if (message.data['channel'] != null) {
      //   channelName = message.data['channel'];
      //
      //   // Get.toNamed(route,
      //   //     arguments: JoinChannelVideo(
      //   //       channelId: channelName,
      //   //     ));
      // } else {
      //   Get.toNamed(route);
      // }
    });


    ///forground messages
    FirebaseMessaging.onMessage.listen((message) {
      print('foreground messages----->>');
      print(message.notification.toString());

      if (message.notification != null) {
        print(message.notification.body.toString());
        print(message.notification.title);
      }
      String route,channelName,channelToken;
      if(message.data['channel']!=null){
        Get.find<LoaderController>().updateCallerType(1);
        channelName=message.data['channel'];
        channelToken=message.data['channel_token'];
        Get.find<LoaderController>().agoraModelDefault.channelName = message.data['channel'];
        Get.find<LoaderController>().agoraModelDefault.token = message.data['channel_token'];
        Get.find<LoaderController>().updateAgoraModelDefault(Get.find<LoaderController>().agoraModelDefault);

      }
      if(message.data['routeApp']!=null){
        route=message.data['routeApp'];
        Get.toNamed(route);

      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      String route,channelName,channelToken;
      if(message.data['channel']!=null){
        Get.find<LoaderController>().updateCallerType(1);
        channelName=message.data['channel'];
        channelToken=message.data['channel_token'];
        Get.find<LoaderController>().agoraModelDefault.channelName = message.data['channel'];
        Get.find<LoaderController>().agoraModelDefault.token = message.data['channel_token'];
        Get.find<LoaderController>().updateAgoraModelDefault(Get.find<LoaderController>().agoraModelDefault);
      }
      if(message.data['routeApp']!=null){
        route=message.data['routeApp'];
        Get.toNamed(route);

      }

      // if (message.data['channel'] != null) {
      //   channelName = message.data['channel'];
      //   // Get.toNamed(route,
      //   // );
      // } else {
      //   // Get.toNamed(route);
      // }
      LocalNotificationService.display(message);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageCubit>(
      create: (context) => LanguageCubit(),
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (_, locale) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('ar'),
              const Locale('pt'),
              const Locale('fr'),
              const Locale('id'),
              const Locale('es'),
              const Locale('it'),
              const Locale('tr'),
              const Locale('sw'),
            ],
            locale: locale,
            theme: lightTheme,
            // home: ProfileWizard(),
            // home: VerificationUI(),
            home: SplashScreen(),
             routes: {
              '/allAppointments':(context)=>AllAppointmentScreen(),
              '/joinVideo':(context)=>JoinChannelVideo(),
              '/dashboard':(context)=>Dashboard(),
             },
             // routes: PageRoutes().routes(),
          );
        },
      ),
    );
  }
}
