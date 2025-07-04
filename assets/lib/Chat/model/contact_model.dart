import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mighty_fitness/utils/app_constants.dart';

class ContactModel {
  String? uid;
  Timestamp? addedOn;
  int? lastMessageTime;

  ContactModel({
    this.uid,
    this.addedOn,
    this.lastMessageTime,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      uid: json[KEY_UID],
      addedOn: json[KEY_ADDED_ON],
      lastMessageTime: json[KEY_LAST_MESSAGE_TIME],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[KEY_UID] = uid;
    data[KEY_ADDED_ON] = addedOn;
    data[KEY_LAST_MESSAGE_TIME] = lastMessageTime;

    return data;
  }
}
