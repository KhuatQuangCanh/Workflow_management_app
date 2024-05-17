import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:workflow_management_app/app.dart';
import 'package:workflow_management_app/features/tasks/screens/personal_tasks/db/db_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  runApp(const App());
}
