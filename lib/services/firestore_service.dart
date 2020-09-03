import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
    FirestoreService._();
    static final instance = FirestoreService._();

    Future<void> addData({String path, Map<String, dynamic> data}) async {
        final reference = FirebaseFirestore.instance.collection(path);
        await reference.add(data);
    }

    Future<void> setData({String path, Map<String, dynamic> data}) async {
        final reference = FirebaseFirestore.instance.document(path);
        await reference.set(data);
    }

    Future<void> updateData({String path, Map<String, dynamic> data}) async {
        final reference = FirebaseFirestore.instance.document(path);
        await reference.update(data);
    }

    Stream<List<T>> collectionStreamFilter<T>({
        @required String path,
        @required String where,
        @required String isEqualTo,
        @required T builder(Map<String, dynamic> data, documentId),
    }) {
        print(isEqualTo);
        final reference = FirebaseFirestore.instance.collection(path);
        final snapshots = reference.where(where.toString(), isEqualTo: isEqualTo.toString()).snapshots();
        return snapshots.map((snapshot) => snapshot.docs.map((snapshot) =>
            builder(snapshot.data(), snapshot.id),
        ).toList());
    }

    Stream<List<T>> collectionStream<T>({
        @required String path,
        @required T builder(Map<String, dynamic> data, documentId),
    }) {
        final reference = FirebaseFirestore.instance.collection(path);
        final snapshots = reference.snapshots();
        return snapshots.map((snapshot) => snapshot.docs.map((snapshot) =>
            builder(snapshot.data(), snapshot.id),
        ).toList());
    }

    Stream<T> documentStream<T>({
        @required String path,
        @required T builder(Map<String, dynamic> data),
    }) {
        final reference = FirebaseFirestore.instance.document(path);
        final snapshots = reference.snapshots();
        return snapshots.map((snapshot) =>
            builder(snapshot.data()),
        );
    }
}