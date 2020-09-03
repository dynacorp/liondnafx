import 'package:flutter/foundation.dart';

class KidsModel {
    final String image;
    final String schoolName;
    final String name;
    final String limit;
    final bool schoolStatus;
    final String parent;
    final String schoolCode;
    final int id;
    final String documentId;
    final String username;
    final bool schoolPermitStatus;
    final bool parentPermitStatus;
    final bool payment;
    final String category;
    final String card;

  KidsModel({
      this.schoolStatus,
      @required this.username,
      this.schoolPermitStatus,
      this.parentPermitStatus,
      this.payment,
      this.category,
      this.card,
      this.image,
      @required this.schoolName,
      @required this.name,
      this.limit,
      this.parent,
      @required this.schoolCode,
      @required this.id,
      @required this.documentId
  });

    factory KidsModel.fromMap(Map<String, dynamic> data, String documentId) {
        if(data == null) {
            return null;
        }
        final String name = data['name'];
        final String schoolName = data['schoolName'];
        final String image = data['image'];
        final String schoolCode = data['schoolCode'];
        final String limit = data['limit'];
        final bool schoolStatus = data['schoolStatus'];
        final bool schoolPermitStatus = data['schoolPermitStatus'];
        final bool parentPermitStatus = data['parentPermitStatus'];
        final bool payment = data['payment'];
        final String parent = data['parent'];
        final int id = data['id'];
        final String username = data['username'];
        final String category = data['category'];
        final String card = data['card'];
        return KidsModel(
            name: name,
            schoolName: schoolName,
            image: image,
            schoolCode: schoolCode,
            limit: limit,
            schoolStatus: schoolStatus,
            parent: parent,
            id: id,
            documentId: documentId,
            schoolPermitStatus: schoolPermitStatus,
            parentPermitStatus: parentPermitStatus,
            payment: payment,
            username: username,
            category: category,
            card: card
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'name': name,
            'schoolName': schoolName,
            'image': image,
            'limit': limit,
            'schoolStatus': schoolStatus,
            'parent': parent,
            'schoolCode': schoolCode,
            'id': id,
            'schoolPermitStatus': schoolPermitStatus,
            'parentPermitStatus': parentPermitStatus,
            'payment': payment,
            'username': username,
            'category': category,
            'card': card
        };
    }
}