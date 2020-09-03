import 'package:flutter/material.dart';
import 'package:liondnafx/pages/Tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:liondnafx/common/routing_constants.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> {
  updateTab() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('currentTab', 0);
  }


@override
void initState() {
    updateTab();
  super.initState();
  new Future.delayed(
      const Duration(seconds: 3),
          () => Navigator.push(context, MaterialPageRoute(builder: (context) => TabHome())));
}


@override
Widget build(BuildContext context) {
  return Scaffold(
//    backgroundColor: Color.fromRGBO(3, 26, 110, 1),
    backgroundColor: Theme.of(context).primaryColor,
    body: Container(
      decoration: BoxDecoration(
//        image: DecorationImage(
//          image: AssetImage("assets/images/Onboarding.png"),
//          fit: BoxFit.cover,
//        ),
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child:Column(
              children: <Widget>[
                Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.3),
                        borderRadius: BorderRadius.all(Radius.circular(20.0))
                    ),
                    child: Center(child: Text("S", style: TextStyle(color: Colors.white.withOpacity(.8), fontSize: 60, fontWeight: FontWeight.bold),)
                    )
                ),
                SizedBox(height: 15,),
                Text("STIPEE", style: TextStyle(color: Colors.white.withOpacity(.9), fontSize: 22, fontWeight: FontWeight.bold, fontFamily: "Roboto"),)
              ],
            ),
            ),
          ],
        ),
      ),
    ),
  );
}
}