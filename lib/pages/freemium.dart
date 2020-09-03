import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:jiffy/jiffy.dart';
import 'package:liondnafx/Models/signalsModel.dart';
import 'package:liondnafx/common/utils.dart';
import 'package:liondnafx/pages/signal-details.dart';
import 'package:liondnafx/services/database.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter/cupertino.dart';

class Freemium extends StatefulWidget {
  @override
  _FreemiumState createState() => _FreemiumState();
}

class _FreemiumState extends State<Freemium> {
  List<String> labels = ["New Signal", "Old Signal"];
  int currentIndex = 0;
  RefreshController refresherController = new RefreshController();

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);

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
        child: new Column(
          children: [
//            new Container(
//              decoration: new BoxDecoration(color: Colors.black87),
//              padding: EdgeInsets.only(left: 10, right: 0),
//              child: new Row(
//                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                children: [
//                  new Container(
//                    child: Text('You have 0 premium signal',
//                        style:
//                            new TextStyle(color: Colors.white, fontSize: 15)),
//                  ),
//                  new FlatButton(
//                    onPressed: () {},
//                    child: Row(
//                      children: [
//                        Icon(
//                          Icons.add,
//                          color: Colors.white,
//                          size: 14,
//                        ),
//                        Text(
//                          'ADD PREMIUM',
//                          style: TextStyle(color: Colors.white),
//                        )
//                      ],
//                    ),
//                    padding: EdgeInsets.only(
//                        top: 16, bottom: 16, left: 10, right: 10),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(0),
//                    ),
//                    color: Colors.orange,
//                  )
//                ],
//              ),
//            ),
            Flexible(
              child: Container(
                child: DefaultTabController(
                  length: 2,
                  child: new Column(
                    children: [
                      new Container(
                        decoration: new BoxDecoration(color: Colors.black87),
                        child: TabBar(
                          tabs: [
                            Tab(
                              child: Text('New signals'),
                            ),
                            Tab(
                              child: Text('Old signals'),
                            )
                          ],
                          unselectedLabelColor: Colors.white,
                          indicatorColor: Colors.orange,
                        ),
                      ),
                      new Flexible(
                          child: new TabBarView(children: [
                            new SmartRefresher(
                              enablePullDown: false,
                              controller: refresherController,
                              child: StreamBuilder<List<SignalsModel>>(
                                  stream: database.newSignalsStream(),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      final sigs = snapshot.data;
                                      print(sigs.length);
                                      return GroupedListView(
                                        elements: sigs,
                                        groupBy: (SignalsModel element) =>
                                        element.date,
                                        groupSeparatorBuilder:
                                            (String groupByValue) => Container(
                                          padding: EdgeInsets.only(
                                              top: 20,
                                              bottom: 10,
                                              left: 15,
                                              right: 20),
                                          width: MediaQuery.of(context).size.width,
                                          color: Colors.grey.withOpacity(0.2),
                                          child: Table(
                                            columnWidths: {
                                              0: FlexColumnWidth(1.0),
                                              1: FlexColumnWidth(0.5),
                                            },
                                            children: [
                                              TableRow(children: [
                                                TableCell(
                                                  child: Text(
                                                    Jiffy(groupByValue).yMMMMd + ' | ' + Jiffy(groupByValue).format("EEEE"),
                                                    style: new TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.w400),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Text(
                                                    '90',
                                                    style: new TextStyle(
                                                        color: Colors.green,
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 17),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                                )
                                              ], decoration: new BoxDecoration())
                                            ],
                                          ),
                                        ),
                                        itemBuilder:
                                            (context, SignalsModel element) =>
                                            SignalDayData(element),
                                        order: GroupedListOrder.ASC,
                                      );
//                                  SignalsModel lastPlug;
//                                  for (var i = 0; i < snapshot.data.length; i++) {
//                                    var plug = snapshot.data[i];
//                                    if (lastPlug?.date != plug.date) {
//                                      print("It's a new day, yes it is: "+plug.date);
//                                      lastPlug = plug;
//                                      print("  "+plug.result);
////                                                return  Column(
////                                                      children: <Widget>[
//////                                              lastPlug?.date != plug.date
////                                                        Container(
////                                                          padding: EdgeInsets.only(
////                                                              top: 20,
////                                                              bottom: 10,
////                                                              left: 15,
////                                                              right: 20),
////                                                          width: MediaQuery.of(context).size.width,
////                                                          color: Colors.grey.withOpacity(0.2),
////                                                          child: Table(
////                                                            columnWidths: {
////                                                              0: FlexColumnWidth(1.0),
////                                                              1: FlexColumnWidth(0.5),
////                                                            },
////                                                            children: [
////                                                              TableRow(
////                                                                children: [
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.date',
////                                                                      style: new TextStyle(
////                                                                          fontSize: 15,
////                                                                          fontWeight: FontWeight.w400
////                                                                      ),
////                                                                    ),
////                                                                  ),
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.result',
////                                                                      style: new TextStyle(
////                                                                          color: Colors
////                                                                              .green,
////                                                                          fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                          fontSize:
////                                                                          17),
////                                                                      textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                    ),
////                                                                    verticalAlignment: TableCellVerticalAlignment.middle,
////                                                                  ),
////                                                                ],
////                                                                decoration: new BoxDecoration(),
////                                                              ),
////                                                            ],
////                                                          ),
////                                                        )
//////                                                  : Container(),
////                                                      ]);
//                                    }
////                                          Column(
////                                              children: <Widget>[
////                                            lastPlug?.date != plug.date
////                                                ? Container(
////                                                    padding: EdgeInsets.only(
////                                                        top: 20,
////                                                        bottom: 10,
////                                                        left: 15,
////                                                        right: 20),
////                                                    width: MediaQuery.of(context).size.width,
////                                                    color: Colors.grey.withOpacity(0.2),
////                                                    child: Table(
////                                                      columnWidths: {
////                                                        0: FlexColumnWidth(1.0),
////                                                        1: FlexColumnWidth(0.5),
////                                                      },
////                                                      children: [
////                                                        TableRow(
////                                                            children: [
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.date,
////                                                                  style: new TextStyle(
////                                                                      fontSize: 15,
////                                                                      fontWeight: FontWeight.w400
////                                                                  ),
////                                                                ),
////                                                              ),
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.result,
////                                                                  style: new TextStyle(
////                                                                      color: Colors
////                                                                          .green,
////                                                                      fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                      fontSize:
////                                                                          17),
////                                                                  textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                ),
////                                                                verticalAlignment: TableCellVerticalAlignment.middle,
////                                                              ),
////                                                            ],
////                                                            decoration: new BoxDecoration(),
////                                                        ),
////                                                      ],
////                                                    ),
////                                                  )
////                                                : Container(),
////                                          ]);
//                                  }

//                                  SignalsModel lastPlug;
//                                  final children =
//                                  sigs.map((sign) => {
//                                        if (lastPlug?.date != sign.date) {
//                                          print("It's a new day, yes it is: " +
//                                              sign.date);
//                                          lastPlug = plug;
//                                        },
//                                        print("  " + sign.result);
//                                    _kidsCard(kids: kids, database: database, cardBackground: backgrounds[Random().nextInt(max)],)
//                                  }).toList();
//                                  return new ListView.builder(
//                                      itemCount: snapshot.data.length,
//                                      // ignore: missing_return
//                                      itemBuilder: (context, index) {
////                                        Map signal = signals[index];
//                                        print('data');
//                                        // ignore: missing_return
//                                        SignalsModel lastPlug;
//                                        for (var i = 0; i < snapshot.data.length; i++) {
//                                          var plug = snapshot.data[i];
//                                                if (lastPlug?.date != plug.date) {
//                                                  print("It's a new day, yes it is: "+plug.date);
//                                                  lastPlug = plug;
//                                                  print("  "+plug.result);
////                                                  Column(
////                                                      children: <Widget>[
//////                                              lastPlug?.date != plug.date
////                                                        Container(
////                                                          padding: EdgeInsets.only(
////                                                              top: 20,
////                                                              bottom: 10,
////                                                              left: 15,
////                                                              right: 20),
////                                                          width: MediaQuery.of(context).size.width,
////                                                          color: Colors.grey.withOpacity(0.2),
////                                                          child: Table(
////                                                            columnWidths: {
////                                                              0: FlexColumnWidth(1.0),
////                                                              1: FlexColumnWidth(0.5),
////                                                            },
////                                                            children: [
////                                                              TableRow(
////                                                                children: [
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.date',
////                                                                      style: new TextStyle(
////                                                                          fontSize: 15,
////                                                                          fontWeight: FontWeight.w400
////                                                                      ),
////                                                                    ),
////                                                                  ),
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.result',
////                                                                      style: new TextStyle(
////                                                                          color: Colors
////                                                                              .green,
////                                                                          fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                          fontSize:
////                                                                          17),
////                                                                      textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                    ),
////                                                                    verticalAlignment: TableCellVerticalAlignment.middle,
////                                                                  ),
////                                                                ],
////                                                                decoration: new BoxDecoration(),
////                                                              ),
////                                                            ],
////                                                          ),
////                                                        )
//////                                                  : Container(),
////                                                      ]);
//                                                }
////                                          Column(
////                                              children: <Widget>[
////                                            lastPlug?.date != plug.date
////                                                ? Container(
////                                                    padding: EdgeInsets.only(
////                                                        top: 20,
////                                                        bottom: 10,
////                                                        left: 15,
////                                                        right: 20),
////                                                    width: MediaQuery.of(context).size.width,
////                                                    color: Colors.grey.withOpacity(0.2),
////                                                    child: Table(
////                                                      columnWidths: {
////                                                        0: FlexColumnWidth(1.0),
////                                                        1: FlexColumnWidth(0.5),
////                                                      },
////                                                      children: [
////                                                        TableRow(
////                                                            children: [
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.date,
////                                                                  style: new TextStyle(
////                                                                      fontSize: 15,
////                                                                      fontWeight: FontWeight.w400
////                                                                  ),
////                                                                ),
////                                                              ),
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.result,
////                                                                  style: new TextStyle(
////                                                                      color: Colors
////                                                                          .green,
////                                                                      fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                      fontSize:
////                                                                          17),
////                                                                  textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                ),
////                                                                verticalAlignment: TableCellVerticalAlignment.middle,
////                                                              ),
////                                                            ],
////                                                            decoration: new BoxDecoration(),
////                                                        ),
////                                                      ],
////                                                    ),
////                                                  )
////                                                : Container(),
////                                          ]);
//                                        }
//
////                                       return SignalDayData(
//////                                          title: plug.signalTitle,
//////                                          total: plug.conclusion,
////                                          signals: snapshot.data,
////                                        );
////                                               return new SignalDayData(
////                                                 title: signal['date'],
////                                                 total: signal['total'],
////                                                 signals: signal['signals'],
////                                               );
//                                      }
////                                                }
//                                      );
                                    } else {
                                      print('no data');
                                      return Container(
                                        height: MediaQuery.of(context).size.height,
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    }
                                  }),
                              footer: new CustomFooter(
                                builder: (BuildContext context, LoadStatus mode) {
                                  Widget body;
                                  if (mode == LoadStatus.idle &&
                                      mode != LoadStatus.noMore) {
                                    body = Text("pull up load");
                                  } else if (mode == LoadStatus.loading) {
                                    body = CupertinoActivityIndicator();
                                  } else if (mode == LoadStatus.failed) {
                                    body = Text("Load Failed!Click retry!");
                                  } else if (mode == LoadStatus.canLoading) {
                                    body = Text("release to load more");
                                  }
//               if(globalState.nextTimelines == null){
//                 body = Text("No more Data");
//               }
                                  return Container(
                                    height: 55.0,
                                    child: Center(child: body),
                                  );
                                },
                              ),
                              onRefresh: () {},
                            ),
                            new SmartRefresher(
                          enablePullDown: false,
                          controller: refresherController,
                          child: StreamBuilder<List<SignalsModel>>(
                              stream: database.oldSignalsStream(),
                              // ignore: missing_return
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final sigs = snapshot.data;
                                  print(sigs.length);
                                  return GroupedListView(
                                    elements: sigs,
                                    groupBy: (SignalsModel element) =>
                                        element.date,
                                    groupSeparatorBuilder:
                                        (String groupByValue) => Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 15,
                                          right: 20),
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.grey.withOpacity(0.2),
                                      child: Table(
                                        columnWidths: {
                                          0: FlexColumnWidth(1.0),
                                          1: FlexColumnWidth(0.5),
                                        },
                                        children: [
                                          TableRow(children: [
                                            TableCell(
                                              child: Text(
                                                Jiffy(groupByValue).yMMMMd + ' | ' + Jiffy(groupByValue).format("EEEE"),
                                                style: new TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                            TableCell(
                                              child: Text(
                                                '90',
                                                style: new TextStyle(
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 17),
                                                textAlign: TextAlign.center,
                                              ),
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                            )
                                          ], decoration: new BoxDecoration())
                                        ],
                                      ),
                                    ),
                                    itemBuilder:
                                        (context, SignalsModel element) =>
                                            SignalDayData(element),
                                    order: GroupedListOrder.ASC,
                                  );
//                                  SignalsModel lastPlug;
//                                  for (var i = 0; i < snapshot.data.length; i++) {
//                                    var plug = snapshot.data[i];
//                                    if (lastPlug?.date != plug.date) {
//                                      print("It's a new day, yes it is: "+plug.date);
//                                      lastPlug = plug;
//                                      print("  "+plug.result);
////                                                return  Column(
////                                                      children: <Widget>[
//////                                              lastPlug?.date != plug.date
////                                                        Container(
////                                                          padding: EdgeInsets.only(
////                                                              top: 20,
////                                                              bottom: 10,
////                                                              left: 15,
////                                                              right: 20),
////                                                          width: MediaQuery.of(context).size.width,
////                                                          color: Colors.grey.withOpacity(0.2),
////                                                          child: Table(
////                                                            columnWidths: {
////                                                              0: FlexColumnWidth(1.0),
////                                                              1: FlexColumnWidth(0.5),
////                                                            },
////                                                            children: [
////                                                              TableRow(
////                                                                children: [
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.date',
////                                                                      style: new TextStyle(
////                                                                          fontSize: 15,
////                                                                          fontWeight: FontWeight.w400
////                                                                      ),
////                                                                    ),
////                                                                  ),
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.result',
////                                                                      style: new TextStyle(
////                                                                          color: Colors
////                                                                              .green,
////                                                                          fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                          fontSize:
////                                                                          17),
////                                                                      textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                    ),
////                                                                    verticalAlignment: TableCellVerticalAlignment.middle,
////                                                                  ),
////                                                                ],
////                                                                decoration: new BoxDecoration(),
////                                                              ),
////                                                            ],
////                                                          ),
////                                                        )
//////                                                  : Container(),
////                                                      ]);
//                                    }
////                                          Column(
////                                              children: <Widget>[
////                                            lastPlug?.date != plug.date
////                                                ? Container(
////                                                    padding: EdgeInsets.only(
////                                                        top: 20,
////                                                        bottom: 10,
////                                                        left: 15,
////                                                        right: 20),
////                                                    width: MediaQuery.of(context).size.width,
////                                                    color: Colors.grey.withOpacity(0.2),
////                                                    child: Table(
////                                                      columnWidths: {
////                                                        0: FlexColumnWidth(1.0),
////                                                        1: FlexColumnWidth(0.5),
////                                                      },
////                                                      children: [
////                                                        TableRow(
////                                                            children: [
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.date,
////                                                                  style: new TextStyle(
////                                                                      fontSize: 15,
////                                                                      fontWeight: FontWeight.w400
////                                                                  ),
////                                                                ),
////                                                              ),
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.result,
////                                                                  style: new TextStyle(
////                                                                      color: Colors
////                                                                          .green,
////                                                                      fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                      fontSize:
////                                                                          17),
////                                                                  textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                ),
////                                                                verticalAlignment: TableCellVerticalAlignment.middle,
////                                                              ),
////                                                            ],
////                                                            decoration: new BoxDecoration(),
////                                                        ),
////                                                      ],
////                                                    ),
////                                                  )
////                                                : Container(),
////                                          ]);
//                                  }

//                                  SignalsModel lastPlug;
//                                  final children =
//                                  sigs.map((sign) => {
//                                        if (lastPlug?.date != sign.date) {
//                                          print("It's a new day, yes it is: " +
//                                              sign.date);
//                                          lastPlug = plug;
//                                        },
//                                        print("  " + sign.result);
//                                    _kidsCard(kids: kids, database: database, cardBackground: backgrounds[Random().nextInt(max)],)
//                                  }).toList();
//                                  return new ListView.builder(
//                                      itemCount: snapshot.data.length,
//                                      // ignore: missing_return
//                                      itemBuilder: (context, index) {
////                                        Map signal = signals[index];
//                                        print('data');
//                                        // ignore: missing_return
//                                        SignalsModel lastPlug;
//                                        for (var i = 0; i < snapshot.data.length; i++) {
//                                          var plug = snapshot.data[i];
//                                                if (lastPlug?.date != plug.date) {
//                                                  print("It's a new day, yes it is: "+plug.date);
//                                                  lastPlug = plug;
//                                                  print("  "+plug.result);
////                                                  Column(
////                                                      children: <Widget>[
//////                                              lastPlug?.date != plug.date
////                                                        Container(
////                                                          padding: EdgeInsets.only(
////                                                              top: 20,
////                                                              bottom: 10,
////                                                              left: 15,
////                                                              right: 20),
////                                                          width: MediaQuery.of(context).size.width,
////                                                          color: Colors.grey.withOpacity(0.2),
////                                                          child: Table(
////                                                            columnWidths: {
////                                                              0: FlexColumnWidth(1.0),
////                                                              1: FlexColumnWidth(0.5),
////                                                            },
////                                                            children: [
////                                                              TableRow(
////                                                                children: [
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.date',
////                                                                      style: new TextStyle(
////                                                                          fontSize: 15,
////                                                                          fontWeight: FontWeight.w400
////                                                                      ),
////                                                                    ),
////                                                                  ),
////                                                                  TableCell(
////                                                                    child: Text(
////                                                                      'plug.result',
////                                                                      style: new TextStyle(
////                                                                          color: Colors
////                                                                              .green,
////                                                                          fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                          fontSize:
////                                                                          17),
////                                                                      textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                    ),
////                                                                    verticalAlignment: TableCellVerticalAlignment.middle,
////                                                                  ),
////                                                                ],
////                                                                decoration: new BoxDecoration(),
////                                                              ),
////                                                            ],
////                                                          ),
////                                                        )
//////                                                  : Container(),
////                                                      ]);
//                                                }
////                                          Column(
////                                              children: <Widget>[
////                                            lastPlug?.date != plug.date
////                                                ? Container(
////                                                    padding: EdgeInsets.only(
////                                                        top: 20,
////                                                        bottom: 10,
////                                                        left: 15,
////                                                        right: 20),
////                                                    width: MediaQuery.of(context).size.width,
////                                                    color: Colors.grey.withOpacity(0.2),
////                                                    child: Table(
////                                                      columnWidths: {
////                                                        0: FlexColumnWidth(1.0),
////                                                        1: FlexColumnWidth(0.5),
////                                                      },
////                                                      children: [
////                                                        TableRow(
////                                                            children: [
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.date,
////                                                                  style: new TextStyle(
////                                                                      fontSize: 15,
////                                                                      fontWeight: FontWeight.w400
////                                                                  ),
////                                                                ),
////                                                              ),
////                                                              TableCell(
////                                                                child: Text(
////                                                                  plug.result,
////                                                                  style: new TextStyle(
////                                                                      color: Colors
////                                                                          .green,
////                                                                      fontWeight:
////                                                                          FontWeight
////                                                                              .w500,
////                                                                      fontSize:
////                                                                          17),
////                                                                  textAlign:
////                                                                      TextAlign
////                                                                          .center,
////                                                                ),
////                                                                verticalAlignment: TableCellVerticalAlignment.middle,
////                                                              ),
////                                                            ],
////                                                            decoration: new BoxDecoration(),
////                                                        ),
////                                                      ],
////                                                    ),
////                                                  )
////                                                : Container(),
////                                          ]);
//                                        }
//
////                                       return SignalDayData(
//////                                          title: plug.signalTitle,
//////                                          total: plug.conclusion,
////                                          signals: snapshot.data,
////                                        );
////                                               return new SignalDayData(
////                                                 title: signal['date'],
////                                                 total: signal['total'],
////                                                 signals: signal['signals'],
////                                               );
//                                      }
////                                                }
//                                      );
                                } else {
                                  print('no data');
                                  return Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                              }),
                          footer: new CustomFooter(
                            builder: (BuildContext context, LoadStatus mode) {
                              Widget body;
                              if (mode == LoadStatus.idle &&
                                  mode != LoadStatus.noMore) {
                                body = Text("pull up load");
                              } else if (mode == LoadStatus.loading) {
                                body = CupertinoActivityIndicator();
                              } else if (mode == LoadStatus.failed) {
                                body = Text("Load Failed!Click retry!");
                              } else if (mode == LoadStatus.canLoading) {
                                body = Text("release to load more");
                              }
//               if(globalState.nextTimelines == null){
//                 body = Text("No more Data");
//               }
                              return Container(
                                height: 55.0,
                                child: Center(child: body),
                              );
                            },
                          ),
                          onRefresh: () {},
                        )
                      ]))
                    ],
                  ),
                ),
              ),
            )
          ],
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
