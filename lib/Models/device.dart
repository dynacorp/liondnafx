import 'package:flutter/foundation.dart';

class DeviceModel {
  final int remaining;
  final String deviceID;
  final String plan;
  final String documentId;

  DeviceModel({
    @required this.remaining,
    @required this.plan,
    this.deviceID,
    @required this.documentId
  });

  factory DeviceModel.fromMap(Map<String, dynamic> data, documentID) {
    if(data == null) {
      return null;
    }
    final String plan = data['plan'];
    final int remaining = data['remaining'];
    final String deviceID = data['deviceID'];
    final String documentId = data['documentId'];
    return DeviceModel(
      plan: plan,
      deviceID: deviceID,
      remaining: remaining,
      documentId: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'plan': plan,
      'deviceID': deviceID,
      'remaining': remaining,
      'documentId': documentId,
    };
  }
}