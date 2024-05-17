import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/utils/constants/colors.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();

  final carousalCurrentIndex = 0.obs;

  void updatePageIndicator(index) {
    carousalCurrentIndex.value = index;
  }



  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  var selectedDate = DateTime
      .now()
      .obs;

  chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate.value.isBefore(DateTime.now())? DateTime.now() : selectedDate.value,
        firstDate: DateTime.now(),
      lastDate: DateTime(2025),
      // initialEntryMode: DatePickerEntryMode.input,
      //   initialDatePickerMode: DatePickerMode.year,
      fieldHintText: 'Date/Month/Year',
    );
    if(pickedDate != null && pickedDate!=selectedDate.value) {
      selectedDate.value = pickedDate;
    }
  }

  bool disableDate(DateTime day) {
    if((day.isAfter(DateTime.now().subtract(Duration(days: 1))) && day.isBefore(DateTime.now().add(Duration(days: 5))))){
      return true;
    }
    return false;
  }




}