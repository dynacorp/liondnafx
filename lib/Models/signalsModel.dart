import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class SignalsModel {
    final String signalTitle;
    final String buySell;
    final String conclusion;
    final String date;
    final String result;
    final Object signalType;
    final String stopLoss;
    final String takeProfit;
    final String tradeClosedAt;
    final Timestamp tradeOpened;
    final tradeClosed;
    final String documentId;
    final String categoryType;

    SignalsModel({
        this.signalTitle,
        this.buySell,
        this.conclusion,
        this.date,
        this.result,
        this.signalType,
        this.stopLoss,
        this.takeProfit,
        this.tradeClosedAt,
        this.tradeOpened,
        this.tradeClosed,
        @required this.documentId,
        this.categoryType
    });

    factory SignalsModel.fromMap(Map<String, dynamic> data, documentID) {
        if(data == null) {
            return null;
        }
        final String signalTitle = data['signalTitle'];
        final String buySell = data['buySell'];
        final String conclusion = data['conclusion'];
        final String date = data['date'];
        final String result = data['result'];
        final Object signalType = data['signalType'];
        final String stopLoss = data['stopLoss'];
        final String takeProfit = data['takeProfit'];
        final String tradeClosedAt = data['tradeClosedAt'];
        final Timestamp tradeOpened = data['tradeOpened'];
        final tradeClosed = data['tradeClosed'];
        final String documentId = data['documentId'];
        final String categoryType = data['categoryType'];
        return SignalsModel(
            signalTitle: signalTitle,
            buySell: buySell,
            conclusion: conclusion,
            date: date,
            result: result,
            signalType: signalType,
            stopLoss: stopLoss,
            takeProfit: takeProfit,
            tradeClosedAt: tradeClosedAt,
            tradeOpened: tradeOpened,
            tradeClosed: tradeClosed,
            documentId: documentId,
            categoryType: categoryType,
        );
    }

    Map<String, dynamic> toMap() {
        return {
            'signalTitle': signalTitle,
            'buySell': buySell,
            'conclusion': conclusion,
            'date': date,
            'result': result,
            'signalType': signalType,
            'stopLoss': stopLoss,
            'takeProfit': takeProfit,
            'tradeClosedAt': tradeClosedAt,
            'tradeOpened': tradeOpened,
            'tradeClosed': tradeClosed,
            'documentId': documentId,
            'categoryType': categoryType,
        };
    }
}