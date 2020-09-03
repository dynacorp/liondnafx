//import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:liondnafx/Models/signalCategoryModel.dart';
import 'package:liondnafx/services/admob_service.dart';
import 'package:liondnafx/services/database.dart';
import 'package:multiple_select/Item.dart';
import 'package:multiple_select/multi_filter_select.dart';
import 'package:multiple_select/multiple_select.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
//  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
//    Admob.initialize(ams.getAdMobAppId());
  }
  List<Item<num, String, String>> items = List.generate(
    150,
        (index) =>
        Item.build(
          value: index,
          display: '$index display',
          content: '$index content' * (index + 1),
        ),
  );

  List<num> _initValue = [1, 2, 6];


  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    print(MediaQuery.of(context).size.width.toInt());
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
              'LionDNA Fx Signals',
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
                  'You have',
                  style: TextStyle(fontSize: 11, letterSpacing: 1),
                ),
                SizedBox(
                  width: 3,
                ),
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
        children: [
//          AdmobBanner(
//            adUnitId: ams.getBannerAdId(),
//            adSize: AdmobBannerSize.BANNER,
//          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 5),
                          child: Text('ABOUT',style: TextStyle(color: Colors.grey,fontSize: 14)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              settingRow(l_icon: Icons.multiline_chart,text: 'Success Rate',btm_border: true),
                              settingRow(l_icon: Icons.info_outline,text: 'Information'),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 5),
                          child: Text('NOTIFICATION',style: TextStyle(color: Colors.grey,fontSize: 14)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              StreamBuilder<List<SignalCategoryModel>>(
                                  stream: database.signalCategoryStream(),
                                  builder: (context, snapshot) {
                                    return GestureDetector(
                                      child: settingRow(l_icon: Icons.notifications,text: 'Push Notifications',btm_border: true),
                                      onTap: () {
//                          MultiFilterSelect(
//                            allItems: items,
//                            initValue: _initValue,
//                            selectCallback: (List selectedValue) => print(selectedValue.length),
//                          );
                                        if(snapshot.hasData) {
                                          final categoryData = snapshot.data;
                                          final categories =
                                          categoryData.asMap().entries.map((e) => MultipleSelectItem.build(value: e.key, display: e.value.name, content: e.value.name)).toList();
                                          MultipleSelect.showMultipleSelector(
                                            context,
                                            title: 'Select Push Notification Signal',
                                            values: _initValue,
                                            elements: categories,
                                          ).then((selectedList) {
                                            if (selectedList != null) selectedList.forEach((
                                                item) => print(item));
                                          });
                                        } else {

                                        }
                                      },
                                    );
                                  }
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10,right: 10,top: 30,bottom: 5),
                          child: Text('THEME',style: TextStyle(color: Colors.grey,fontSize: 14)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 25),
                          child: Column(
                            children: [
                              settingRow(l_icon: Icons.refresh,text: 'Automatic',btm_border: true),
                              settingRow(l_icon: Icons.lightbulb_outline,text: 'Automatic',btm_border: true),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget settingRow({IconData l_icon,String text,bool btm_border:false}){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13),
      decoration: BoxDecoration(
          border: btm_border ? Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))):Border()
      ),
      child: Row(
        children: [
          Icon(l_icon,color: Colors.black.withOpacity(0.7),size: 25,),
          Container(
            margin: EdgeInsets.only(left: 10),
            child: Text(text,style: new TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.7))),
          )
        ],
      ),
    );
  }
}
