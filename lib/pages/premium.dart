import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:liondnafx/Models/signalsModel.dart';
import 'package:liondnafx/common/list.dart';
import 'package:liondnafx/pages/signal-details.dart';

class Premium extends StatefulWidget {
  @override
  _PremiumState createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.black87,
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
              ),),),),
        title: Column(
          children: <Widget>[
            Text(
              'LionDNA Forex Signals',
              style: TextStyle(
                  fontSize: 13, letterSpacing: 1, fontWeight: FontWeight.bold),
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
        actions: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 10),
            child: Icon(Icons.style),
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('You currently have \n 0 premium signal', style: TextStyle(fontSize: 17),),
                SizedBox(height: 10,),
                FlatButton(
                  child: Text('Buy Premium', style: TextStyle(color: Color(0xFFb8891f),),),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SignalDayData extends StatelessWidget {
  final SignalsModel element;
//  final String total;
//  final List<SignalsModel> signals;

  SignalDayData(this.element);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: new Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
//              Container(
//                padding: EdgeInsets.only(top: 20,bottom: 10,left: 15,right: 20),
//                width: MediaQuery.of(context).size.width,
//                color: Colors.grey.withOpacity(0.2),
//                child: Table(
//                  columnWidths: {
//                    0:FlexColumnWidth(1.0),
//                    1:FlexColumnWidth(0.5),
//                  },
//                  children: [
//                    TableRow(
//                        children: [
//                          TableCell(
//                            child: Text('title',style: new TextStyle(fontSize: 15,fontWeight: FontWeight.w400),),
//                          ),
//                          TableCell(
//                            child: Text('90',style: new TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 17),textAlign: TextAlign.center,),
//                            verticalAlignment: TableCellVerticalAlignment.middle,
//                          )
//                        ],
//                        decoration: new BoxDecoration(
//
//                        )
//                    )
//                  ],
//                ),
//              ),
              new Container(
                padding: EdgeInsets.only(left: 15),
                decoration: new BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            color: Colors.black54.withOpacity(0.2)))),
                child: Table(
                  columnWidths: {
                    0: FlexColumnWidth(),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(0.40),
                    3: FlexColumnWidth(0.35),
                  },
                  children: [
                    TableRow(
                        decoration: new BoxDecoration(
                            border: new Border(
                                bottom: new BorderSide(
                                    color: Colors.grey.withOpacity(0.2)))),
                        children: [
                          TableCell(
                            child: new Container(
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(element.signalTitle,
                                      style: new TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500)),
                                  Container(
                                    margin: EdgeInsets.only(top: 2),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.alarm,
                                          color: Colors.grey,
                                          size: 18,
                                        ),
                                        Text(
                                          ' ' + Jiffy(element.tradeOpened.toDate()).jm,
                                          style: new TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                          ),
                          TableCell(
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(concFunc(element.conclusion),
                                    style: new TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54)),
                                Container(
                                  margin: EdgeInsets.only(top: 2),
                                  child: Text(element.conclusion.toUpperCase(),
                                      style: new TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: concCOLOR(element.conclusion))),
                                )
                              ],
                            ),
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                          ),
                          TableCell(
                            child: Container(
                              child: Text(
                                element.result,
                                style: new TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: concCOLOR(element.conclusion)),
                                textAlign: TextAlign.center,
                              ),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      left: BorderSide(
                                          color:
                                          Colors.grey.withOpacity(0.4)))),
                              height: 70,
                              padding: EdgeInsets.only(top: 24),
                            ),
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                          ),
                          TableCell(
                            child: Container(
                              child: Icon(Icons.chevron_right,
                                  color: Colors.black),
                              decoration: new BoxDecoration(
                                  border: new Border(
                                      left: BorderSide(
                                          color: Colors.black54
                                              .withOpacity(0.2)))),
                              height: 70,
                            ),
                            verticalAlignment:
                            TableCellVerticalAlignment.middle,
                          ),
                        ])
                  ],
                ),
              )
            ],
          )),
      onTap: () {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => new SignalDetails(element)));
      },
    );
  }

  String concFunc(String conclusion) {
    switch (conclusion) {
      case 'Take Profit':
        return 'EXPIRED';
      case 'Stop Loss':
        return 'EXPIRED';
      case 'Waiting':
        return 'ACTIVE';
      default :
        return 'ACTIVE';
    }
  }

  Color concCOLOR(String conclusion) {
    switch (conclusion) {
      case 'Take Profit':
        return Colors.green;
      case 'Stop Loss':
        return Colors.red;
      case 'Waiting':
        return Colors.grey;
      default :
        return Colors.grey;
    }
  }
}


