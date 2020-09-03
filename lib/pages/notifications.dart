import 'package:flutter/material.dart';
import 'package:liondnafx/Models/notifications.dart';
import 'package:liondnafx/services/database.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color(0xFF192832),
        leading: Container(
            child: Center(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(.3),
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      "L",
                      style: TextStyle(
                          color: Colors.white.withOpacity(.8),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )))),
        title: Column(
          children: <Widget>[
            Text(
              'LionDNA Forex Signals',
              style: TextStyle(fontSize: 13, letterSpacing: 1, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '0',
                  style: TextStyle(fontSize: 11, letterSpacing: 3),
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'Premium Signals',
                  style: TextStyle(fontSize: 11, letterSpacing: 1),
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[Icon(Icons.style)],
        automaticallyImplyLeading: false,
        elevation: 5,
      ),
      body: Column(
        children: <Widget>[
          new Container(
              decoration: new BoxDecoration(color: Color(0xFF192832)),
              padding: EdgeInsets.only(left: 10, right: 0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Container(
                    child: Text('You have 0 premium signal',
                        style:
                            new TextStyle(color: Colors.white, fontSize: 14)),
                  ),
                  new FlatButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 14,
                        ),
                        Text(
                          'ADD PREMIUM',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        )
                      ],
                    ),
                    padding: EdgeInsets.only(
                        top: 16, bottom: 16, left: 10, right: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    color: Color(0xFFb8891f),
                  )
                ],
              ),
            ),
          Expanded(
            child: StreamBuilder<List<NotificationsModel>>(
              stream: database.notificationsStream(),
              builder: (context, snapshot) {
                if(snapshot.hasData) {
                  final notificatoinsData = snapshot.data;
                  final children =
                  notificatoinsData.map((notif) => notifs(
                    title: notif.signalTitle,
                    conclusion: notif.conclusion,
                    signalType: notif.signalType,
                    categoryType: notif.categoryType,
                  )).toList();
                  return ListView.builder(
//              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: children,
                        ),
                      );
                    },
                  );
                }

                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class notifs extends StatelessWidget {
  final String title;
  final String categoryType;
  final String conclusion;
  final List signalType;

  const notifs({
    Key key, this.title, this.categoryType, this.conclusion, this.signalType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(signalType.contains('Freemium'));
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: <Widget>[
              Icon(Icons.notifications_none, size: 17, color: Color(0xFFb8891f),),
              SizedBox(width: 5,),
              Row(
                children: <Widget>[
                  Text('$title: '),
                  Text('$conclusion!'),
                  SizedBox(width: 10,),
                  signalType.contains('Freemium') ? Container() : Container(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      color: Color(0xFFb8891f),
                      borderRadius: BorderRadius.all(Radius.circular(5),),
                    ),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5),),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Text('premium', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Divider()
      ],
    );
  }
}
