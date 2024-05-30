


import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/utils/popups/loaders.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List< ConnectivityResult>> _connectivitySubscription;
  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    // Đăng ký lắng nghe sự kiện thay đổi kết nối và xử lý danh sách các kết quả
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // Lấy kết quả đầu tiên từ danh sách để cập nhật trạng thái kết nối
      _updateConnectionStatus(results.first);
    });
  }

  // Hàm cập nhật trạng thái kết nối dựa trên kết quả đầu tiên trong danh sách
  void _updateConnectionStatus(ConnectivityResult result) {
    _connectionStatus.value = result;
    if (_connectionStatus.value == ConnectivityResult.none) {
      CLoaders.customToast(message: 'No Internet Connection');
    }
  }

  // Kiểm tra trạng thái kết nối internet
  // Trả về true nếu có kết nối, ngược lại trả về false.
  Future<bool> isConnected() async {
    try {
      final result = await _connectivity.checkConnectivity();
      // return result != ConnectivityResult.none;
      if(result == ConnectivityResult.none) {
        return false;
      }else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  // Hủy đăng ký và đóng luồng kết nối đang hoạt động khi controller bị đóng.
  @override
  void onClose() {
    super.onClose();
    _connectivitySubscription.cancel();
  }
}