
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:workflow_management_app/features/tasks/models/user_group_model.dart';

class GroupUserRepository extends GetxController {
  static GroupUserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveGroupUser(GroupUserModel groupUser) async {
    try {
      await _db.collection("GroupUsers").doc(groupUser.id).set(groupUser.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error saving group-user relation: $e');
    }
  }

  Future<GroupUserModel> fetchGroupUserDetail(String groupUserId) async {
    try {
      final documentSnapshot = await _db.collection("GroupUsers").doc(groupUserId).get();
      if (documentSnapshot.exists) {
        return GroupUserModel.fromSnapshot(documentSnapshot);
      } else {
        throw Exception('GroupUser not found');
      }
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching group-user relation: $e');
    }
  }

  Future<void> updateGroupUser(GroupUserModel groupUser) async {
    try {
      await _db.collection("GroupUsers").doc(groupUser.id).update(groupUser.toJson());
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error updating group-user relation: $e');
    }
  }

  Future<void> deleteGroupUser(String groupUserId) async {
    try {
      await _db.collection("GroupUsers").doc(groupUserId).delete();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting group-user relation: $e');
    }
  }
  Future<List<GroupUserModel>> fetchGroupUsersByGroupId(String groupId) async {
    try {
      final querySnapshot = await _db.collection("GroupUsers").where('groupId', isEqualTo: groupId).get();
      return querySnapshot.docs.map((doc) => GroupUserModel.fromSnapshot(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('FirebaseException: ${e.message}');
    } catch (e) {
      throw Exception('Error fetching group users by groupId: $e');
    }
  }
  Future<List<GroupUserModel>> fetchGroupUsersByUserId(String userId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot = await _db
          .collection("GroupUsers")
          .where('userId', isEqualTo: userId)
          .get();
      final List<GroupUserModel> groupUsers = querySnapshot.docs
          .map((doc) => GroupUserModel.fromSnapshot(doc))
          .toList();
      return groupUsers;
    } catch (e) {
      print("Error fetching group users by user id: $e");
      throw e;
    }
  }
}