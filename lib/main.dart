import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:liondnafx/common/router.dart' as router;
import 'package:liondnafx/services/database.dart';
import 'package:provider/provider.dart';
import 'common/routing_constants.dart';

void main() {
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  String device;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Future<String> getId(context) async {
      Firebase.initializeApp();
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
//        print(androidDeviceInfo.androidId);
        return androidDeviceInfo.androidId; // unique ID on Android
      }
    }
    getId(context).then((id) {
      device = id;
    });
    return Provider<Database>(
      create: (_) => FirestoreDatabase(deviceId: device),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lion DNA Forex Signals',
        onGenerateRoute: router.generateRoute,
        initialRoute: SplashScreenRoute,
        theme: ThemeData(
          canvasColor: Colors.white,
//        primarySwatch: Colors.black,
          fontFamily: 'Eina03',
          primaryColor: Color(0xFF192832),
//        primaryColor: Color(0xFF2e2270),
          backgroundColor: Color(0xFFF6F9FF),

        ),

      ),
    );
  }
}
