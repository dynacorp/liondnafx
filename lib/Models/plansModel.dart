import 'package:flutter/foundation.dart';

class PlansModel {
    final int price;
    final int duration;
    final int signals;
    final String title;
    final String documentId;

    PlansModel({
        @required this.price,
        @required this.signals,
        @required this.duration, 
        this.title,
        @required this.documentId
    });

    factory PlansModel.fromMap(Map<String, dynamic> data, documentID) {
        if(data == null) {
            return null;
        }
        final int price = data['price'];
        final int duration = data['duration'];
        final int signals = data['signals'];
        final String title = data['title'];
        final String documentId = data['documentId'];
        return PlansModel(
            price: price,
            duration: duration,
            title: title,
            signals: signals,
            documentId: documentId,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'price': price,
            'duration': duration,
            'title': title,
            'signals': signals,
            'documentId': documentId,
        };
    }
}