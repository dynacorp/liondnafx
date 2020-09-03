//import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:liondnafx/Models/signalsModel.dart';
import 'package:liondnafx/services/admob_service.dart';

class SignalDetails extends StatefulWidget {
  final SignalsModel element;

  const SignalDetails(this.element);
  @override
  _SignalDetailsState createState() => _SignalDetailsState();
}

class _SignalDetailsState extends State<SignalDetails> {
//  final ams = AdMobService();

  @override
  void initState() {
    super.initState();
//    Admob.initialize(ams.getAdMobAppId());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF192832),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,),onPressed: (){
          Navigator.pop(context);
        },),
        title: Text(widget.element.signalTitle,style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.15)
          ),
//        padding: EdgeInsets.only(top: 30),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
//              AdmobBanner(
//                adUnitId: ams.getBannerAdId(),
//                adSize: AdmobBannerSize.BANNER,
//              ),
              Container(
                child: settingRow(l_icon: Icons.timer,text: widget.element.signalTitle,value: widget.element.buySell),
                margin: EdgeInsets.only(bottom: 15),
              ),
              Container(
                child: Column(
                  children: [
                    settingRow(text: 'Take Profit',value: widget.element.takeProfit,color: Colors.green,btm_border: true),
                    settingRow(text: 'Stop Loss',value: widget.element.stopLoss,color: Colors.red),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),
              Container(
                child: Column(
                  children: [
                    settingRow(text: 'Result',value: '${widget.element.result} pips')
                  ],
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),
              Container(
                child: Column(
                  children: [
                    settingRow(text: 'Take Closed At',value: widget.element.tradeClosedAt,btm_border: true),
                    settingRow(text: 'Take Opened',value: '${Jiffy(widget.element.tradeOpened.toDate()).jm} - ${Jiffy(widget.element.tradeOpened.toDate()).format("MMM do yy")}',btm_border: true),
                    settingRow(text: 'Take Closed',value: widget.element.tradeClosed == '-'? '-' : '${Jiffy(widget.element.tradeClosed.toDate()).jm} - ${Jiffy(widget.element.tradeClosed.toDate()).format("MMM do yy")}'),
                  ],
                ),
                margin: EdgeInsets.only(bottom: 15),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.element.conclusion.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25,color: concCOLOR(widget.element.conclusion)))
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color concCOLOR(String conclusion) {
    switch (conclusion) {
      case 'Take Profit':
        return Colors.green;
      case 'Stop Loss':
        return Colors.red;
      case 'Waiting':
        return Colors.blueGrey;
      default :
        return Colors.blueGrey;
    }
  }

  Widget settingRow({
        IconData l_icon,
        String text,
        String value,
        Color color,
        bool btm_border:false
  }){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 13,horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: btm_border ? Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))):Border()
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              l_icon != null ? Icon(l_icon,color: Colors.black.withOpacity(0.7),size: 25,):Container(),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(text,style: new TextStyle(fontSize: 16,color: Colors.black.withOpacity(0.7))),
              )
            ],
          ),
          Container(
            child: Text(value,style:TextStyle(color: color != null ? color:Colors.grey,fontSize: 16,fontWeight: FontWeight.w500),),
          )
        ],
      ),
    );
  }
}
