
import 'package:get/get.dart';
import 'package:workflow_management_app/data/repositories/user_group/userGroup_repository.dart';
import 'package:workflow_management_app/features/tasks/models/user_group_model.dart';

class GroupUserController extends GetxController {
  static GroupUserController get instance => Get.find();

  final GroupUserRepository _groupUserRepo = Get.put(GroupUserRepository());
  // Danh sách userId của nhóm cụ thể
  final RxList<String> groupUserIds = <String>[].obs;

  // Lấy danh sách userId của một nhóm từ Firestore
  Future<void> fetchGroupUserIds(String groupId) async {
    try {
      final List<GroupUserModel> groupUsers = await _groupUserRepo.fetchGroupUsersByGroupId(groupId);
      final List<String> userIds = groupUsers.map((groupUser) => groupUser.userId).toList();
      groupUserIds.assignAll(userIds);
    } catch (e) {
      print("Error fetching group user ids: $e");
    }
  }
}