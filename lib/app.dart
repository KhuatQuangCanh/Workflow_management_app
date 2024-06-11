import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/bindings/general_bindings.dart';
import 'package:workflow_management_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';
import 'package:workflow_management_app/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: CAppTheme.lightTheme,
      darkTheme: CAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      home: const Scaffold(backgroundColor: CColors.primary, body: Center(child: CircularProgressIndicator(color: CColors.white,),),),
    );
  }
}