import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workflow_management_app/app.dart';
import 'package:workflow_management_app/data/repositories/authentication/authentication_repository.dart';
import 'package:workflow_management_app/features/tasks/controllers/group/group_controller.dart';
import 'package:workflow_management_app/features/tasks/controllers/group_task/task_controller.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/db/db_helper.dart';
import 'package:workflow_management_app/services/notification_services.dart';

import 'firebase_options.dart';

void main() async{


  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();

//Widgets Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // -- GetX Local Storage
  await GetStorage.init();

  // Await Splash until other items Load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,).then(
          (FirebaseApp value) => Get.put(AuthenticationRepository()));

  Get.put(TaskController(), permanent: true);
  final NotifyHelper notifyHelper = NotifyHelper();
  await notifyHelper.initializeNotification();
  runApp(const App());
}
