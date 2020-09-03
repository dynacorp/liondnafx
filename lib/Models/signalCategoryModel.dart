import 'package:flutter/foundation.dart';

class SignalCategoryModel {
    final String name;
    final String documentId;

    SignalCategoryModel({
        @required this.name,
        @required this.documentId
    });

    factory SignalCategoryModel.fromMap(Map<String, dynamic> data, documentID) {
        if(data == null) {
            return null;
        }
        final String name = data['name'];
        final String documentId = data['documentId'];
        return SignalCategoryModel(
            name: name,
            documentId: documentId,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'name': name,
            'documentId': documentId,
        };
    }
}