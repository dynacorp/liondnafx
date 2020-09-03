//import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:liondnafx/Models/plansModel.dart';
import 'package:liondnafx/common/utils.dart';
import 'package:liondnafx/services/admob_service.dart';
import 'package:liondnafx/services/database.dart';
import 'package:liondnafx/services/http_service.dart';
import 'package:provider/provider.dart';
import 'package:liondnafx/services/admob_service.dart';

class Packages extends StatefulWidget {
  @override
  _PackagesState createState() => _PackagesState();
}

class _PackagesState extends State<Packages> {
//  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
//    Admob.initialize(ams.getAdMobAppId());
  }

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context, listen: false);
    final packageData = ['', '', ''];
    return StreamBuilder<List<PlansModel>>(
      stream: database.plansStream(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final plansData = snapshot.data;
          plansData.map((plans) =>{print(plans.toString())});
          final children =
          plansData.map((plans) => packageCard(cardTitle: plans.signals,
            price: plans.price.toString(),
            planDuration: plans.duration.toString(),
            cardColor: Color(0xFF192832),
            icon: Icons.add_shopping_cart,
            color: Color(0xFFb8891f),)).toList();
          return Scaffold(
            appBar: new AppBar(
              backgroundColor: Color(0xFF192832),
              leading: Container(
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
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
                    style: TextStyle(fontSize: 13,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
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
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
//                    AdmobBanner(
//                      adUnitId: ams.getBannerAdId(),
//                      adSize: AdmobBannerSize.BANNER,
//                    ),
                    SizedBox(height: 10,),
                    Text('Purchase a Premium Package', style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),),
                  ],
                ),
                SizedBox(height: 40,),
                Expanded(
                  flex: 2,
                  child: ListView.builder(
//              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: children,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: new AppBar(
              backgroundColor: Color(0xFF192832),
              leading: Container(
                  child: Center(
                      child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 7, horizontal: 10),
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
                    style: TextStyle(fontSize: 13,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
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
              elevation: 0,
            ),
            body: Column(
              children: <Widget>[
                SizedBox(height: 20,),
                Column(
                  children: <Widget>[
                    Text('Purchase a Premium Package', style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),),
                  ],
                ),
                SizedBox(height: 40,),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xFF192832),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

      }
    );
  }
}

class packageCard extends StatelessWidget {
//  _signalCard({
//    @required this.kids,
//    @required this.database,
//    @required this.cardBackground,
//  }) : assert(kids != null);
//
//  final KidsModel kids;
//  final Database database;
//  final String cardBackground;

  final int cardTitle;
  final String price;
  final String planDuration;
  final IconData icon;
  final Color color;
  final Color cardColor;

  const packageCard(
      {Key key,
        @required this.cardTitle,
        @required this.price,
        @required this.planDuration,
        this.icon,
        this.cardColor,
        @required this.color})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
//    final formatter = new NumberFormat("#,###");

    return Stack(
      children: <Widget>[
        Container(
          child: Column(
            children: <Widget>[
              Container(
                width: screenWidth(context),
                height: 140,
                margin: EdgeInsets.symmetric(horizontal:25),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.18),
                        blurRadius: 20,
                        spreadRadius: 3.5,
                        offset: Offset(0, 13)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(cardTitle.toString() ?? '0', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                                  Text(' Premium Signals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(cardTitle.toString() ?? '0', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, color: Colors.grey),),
                                  Text(' Premium Signals + free signals', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11, color: Colors.grey),),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Row(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Plan Duration',
                                style: TextStyle(
                                  color: Colors.white,),
                              ),
                              const YMargin(2),
                            ],
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              RichText(
                                text: TextSpan(
                                  text: "$planDuration days",
                                  style: TextStyle(
                                    color: Colors.white,),
                                ),
                              ),
                              const YMargin(2),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(left:20),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 30,
                            margin: EdgeInsets.only(bottom: 5),
                            padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(5),),
                            child: RichText(
                              text:
                              TextSpan(
                                text: "USD $price.00"
                                    .toUpperCase(),
                                style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.bold),
                              ),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Column(
            children: <Widget>[
              const YMargin(94),
              InkWell(
                onTap: () {
                  final database = Provider.of<Database>(context, listen: false);
                  print(database.getDeviceID());
                  final payload = {
                    'price': price,
                    'signals': cardTitle.toString(),
                    'ref': {
                      'planDuration': planDuration.toString(),
                      'signals': cardTitle.toString()
                    },

                  };
                  _showMyDialog(context, payload);
                },
                child: Container(
                  width: 180,
                  height: 38,
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 30,
                          spreadRadius: 3.5,
                          offset: Offset(0, 13)),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 3,),
                      Icon(icon, color: color, size: 15),
                      SizedBox(width: 5,),
                      Text(
                        "Purchase Package",
                        style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _showMyDialog(context, payload) async {
    return showDialog<void>(
      context: context,
//      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment Method'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('This is a demo alert dialog.'),
                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('BTC Transfer'),
              onPressed: () {
                Navigator.of(context).pop();
                final HttpService httpService = HttpService();
                httpService.startPayment(context, payload)
                    .then((value) => print(value))
                    .catchError((error) {
                  print(error.toString());
                });
              },
            ),
            FlatButton(
              child: Text('Credit Card'),
              onPressed: () {
                Navigator.of(context).pop();
                final HttpService httpService = HttpService();
                httpService.startPayment(context, payload)
                    .then((value) => print(value))
                    .catchError((error) {
                  print(error.toString());
                });
              },
            ),
          ],
        );
      },
    );
  }
}
