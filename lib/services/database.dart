import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:liondnafx/Models/notifications.dart';
import 'package:liondnafx/Models/plansModel.dart';
import 'package:liondnafx/Models/signalCategoryModel.dart';
import 'package:liondnafx/Models/signalsModel.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_path.dart';
import 'firestore_service.dart';

abstract class Database {
    getDeviceID();
//    Future<String> getId(context);
    Future<void> addDevice(Map<String, dynamic> deviceData);
    Stream<List<PlansModel>> plansStream();
    Stream<List<NotificationsModel>> notificationsStream();
    Stream<List<SignalsModel>> signalsStream();
    Stream<List<SignalsModel>> oldSignalsStream();
    Stream<List<SignalsModel>> newSignalsStream();
    Stream<List<SignalCategoryModel>> signalCategoryStream();
//    Stream<List<KidsModel>> kidsStream();
//    Stream<List<NotificationsModel>> notificationStream();
}

class FirestoreDatabase implements Database {
    FirestoreDatabase({@required this.deviceId}) : assert(deviceId != null);
    final String deviceId;
    final _service = FirestoreService.instance;
    Map<String, dynamic> documentData;
    Future<SharedPreferences> prefs = SharedPreferences.getInstance();

    getDeviceID() {
        return deviceId;
    }

    Future<void> addDevice(Map<String, dynamic> deviceData) async => await _service.addData(
        path: APIPath.addDeviceID(),
        data: deviceData
    );
//
//    Future<void> setKid(Map<String, dynamic> kidData) async {
//      final path = APIPath.getKids();
//      final reference = Firestore.instance.collection(path);
//      final get = reference.where('username', isEqualTo: kidData['parent']).getDocuments();
//      await get
//          .then((value) => {
//           documentData = value.documents.single.data,
//              print(documentData["paymentRef"])
//          })
//          .catchError((onError) => print(onError));
//    }


//    Future<void> notificationSaver(String title) async {
//        var w = {'title': title};
//        prefs.then((SharedPreferences prefs) {
//            if(prefs.containsKey('notifications')) {
//                print('yes');
//                var deb = prefs.getString('notifications');
//                List q = json.decode(deb);
//                // TODO: tying to check if the notification already exist
//                var notifExist = q.firstWhere((notif) => notif['title'] == title, orElse: () => null);
//
//                if(notifExist == null) {
//                    q.add(w);
//                    prefs.setString('notifications', jsonEncode(q));
//                }
//
//            } else {
//                print('no');
//                List deb = [];
//                deb.add(w);
//                prefs.setString('notifications', json.encode(deb));
//            }
//        });
//    }

    Stream<List<PlansModel>> plansStream() => _service.collectionStream(
        path: APIPath.getPlans(),
        builder: (data, documentID) => PlansModel.fromMap(data, documentID),
    );

    Stream<List<NotificationsModel>> notificationsStream() => _service.collectionStream(
        path: APIPath.getNotifications(),
        builder: (data, documentID) => NotificationsModel.fromMap(data, documentID),
    );

    Stream<List<SignalCategoryModel>> signalCategoryStream() => _service.collectionStream(
        path: APIPath.getCategories(),
        builder: (data, documentID) => SignalCategoryModel.fromMap(data, documentID),
    );

    Stream<List<SignalsModel>> signalsStream() => _service.collectionStream(
        path: APIPath.getSignals(),
        builder: (data, documentID) => SignalsModel.fromMap(data, documentID),
    );

    Stream<List<SignalsModel>> oldSignalsStream() => _service.collectionStreamFilter(
        path: APIPath.getSignals(),
        builder: (data, documentID) => SignalsModel.fromMap(data, documentID),
        isEqualTo: 'Old',
        where: 'categoryType',
    );

    Stream<List<SignalsModel>> newSignalsStream() => _service.collectionStreamFilter(
        path: APIPath.getSignals(),
        builder: (data, documentID) => SignalsModel.fromMap(data, documentID),
        isEqualTo: 'New',
        where: 'categoryType',
    );

//    Stream<UserModel> profileStream() => _service.documentStream(
//        path: APIPath.getProfile(uid),
//        builder: (data) => UserModel.fromMap(data),
//    );

//    Stream<List<KidsModel>> kidsStream() {
//        final path = APIPath.getKids();
//        final reference = Firestore.instance.collection(path);
//        final snapshots = reference.where('parent', isEqualTo: uid).snapshots();
//        return snapshots.map((snapshot) => snapshot.documents.map((snapshot) =>
//            KidsModel.fromMap(snapshot.data, snapshot.documentID),
//        ).toList());
//    }

//    Stream<List<NotificationsModel>> notificationStream() => _service.collectionStream(
//        path: APIPath.getNotifications(),
//        builder: (data, documentID) => NotificationsModel.fromMap(data, documentID),
//    );


}
