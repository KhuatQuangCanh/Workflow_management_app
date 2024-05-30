

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String email;
  String phoneNumber;
  String profilePicture;

  // Constructor for UserModel
  UserModel(
      {required this.id,
        required this.firstName,
        required this.lastName,
        required this.email,
        required this.phoneNumber,
        required this.profilePicture});

  // Helper function to get the full name
  String get fullName => '$firstName $lastName';

// Helper function to format phone number
  String get formattedPhoneNo => CFormatter.formatPhoneNumber(phoneNumber);

// Static function to split full name into  first and last name.
  static List<String> nameParts(fullName) => fullName.split(" ");

  // Static function to generate a username from the full name.
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1? nameParts[1].toLowerCase() : "";

    String camelCaseUsername = "$firstName$lastName";
    return camelCaseUsername;
  }
// static function to create on empty user model.
  static UserModel empty() => UserModel(id: '', firstName: '', lastName: '', email: '', phoneNumber: '', profilePicture: '');

// Convert model to JSON structure for Staring data in Firebase.
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,

    };
  }

  factory UserModel.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null) {
      final data = document.data()!;
      return UserModel(
          id: document.id,
          firstName: data["FirstName"]?? '',
          lastName: data["LastName"] ?? '',
          email: data["Email"] ?? '',
          phoneNumber: data["PhoneNumber"] ?? '',
          profilePicture: data["ProfilePicture"]?? '');
    }else {
      return UserModel(
        id: document.id,
        firstName: '',
        lastName: '',
        email: '',
        phoneNumber: '',
        profilePicture: '',
      );
    }

  }

  @override
  String toString() {
    return 'UserModel{id: $id, firstName: $firstName, lastName: $lastName,  email: $email, phoneNumber: $phoneNumber, profilePicture: $profilePicture}';
  }
}
