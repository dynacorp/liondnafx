import 'package:flutter/foundation.dart';

class NotificationsModel {
  final String signalTitle;
  final String conclusion;
  final Object signalType;
  final String documentId;
  final String categoryType;

  NotificationsModel({
    this.signalTitle,
    this.conclusion,
    this.signalType,
    @required this.documentId,
    this.categoryType
  });

  factory NotificationsModel.fromMap(Map<String, dynamic> data, documentID) {
    if(data == null) {
      return null;
    }
    final String signalTitle = data['signalTitle'];
    final String conclusion = data['conclusion'];
    final Object signalType = data['signalType'];
    final String documentId = data['documentId'];
    final String categoryType = data['categoryType'];
    return NotificationsModel(
      signalTitle: signalTitle,
      conclusion: conclusion,
      signalType: signalType,
      documentId: documentId,
      categoryType: categoryType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'signalTitle': signalTitle,
      'conclusion': conclusion,
      'signalType': signalType,
      'documentId': documentId,
      'categoryType': categoryType,
    };
  }
}