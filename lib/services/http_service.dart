import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import 'package:provider/provider.dart';
//import 'package:rave_flutter/rave_flutter.dart';
import 'package:liondnafx/services/config.dart';

import 'database.dart';

abstract class HttpBase {
//    Future<List<BanksModel>> getDebitBanks();
    Future<void> startPayment(context, payload);
}

class HttpService implements HttpBase {
    bool acceptCardPayment = true;
    bool acceptAccountPayment = true;
    bool acceptMpesaPayment = false;
    bool shouldDisplayFee = true;
    bool acceptAchPayments = false;
    bool acceptGhMMPayments = false;
    bool acceptUgMMPayments = false;
    bool acceptMMFrancophonePayments = false;
    bool live = true;
    bool preAuthCharge = false;
    bool addSubAccounts = false;
//    List<SubAccount> subAccounts = [];
    String email;
    String publicKey = "FLWPUBK_TEST-6d5bce48bb0aedc0a9fd4b031089bf76-X";
    String encryptionKey = "FLWSECK_TEST9e6b3d793a2e";
    String txRef;
    String orderRef;
    String narration;
    String currency;
    String country;
    String firstName;
    String lastName;
    Map<String,String> headers = {
        'Content-type' : 'application/json',
        'Accept': 'application/json',
        "charset":"utf-8"
    };
    Map<String,String> flutterHeaders = {
        "Authorization": secretKey
    };
    String _randomString(int length) {
        var rand = new Random();
        var codeUnits = new List.generate(
            length,
                (index){
                return rand.nextInt(33)+89;
            }
        );

        return new String.fromCharCodes(codeUnits);
    }

    @override
    Future startPayment(context, payload) async {
        final database = Provider.of<Database>(context, listen: false);
        print(payload['ref']);
//        final signalAmount = payload['signals'];
//        final price = double.parse(payload['price']);
//        var initializer = RavePayInitializer(
//            amount: price,
//            meta: payload['ref'],
//            publicKey: publicKey,
//            encryptionKey: encryptionKey,
////            redirectUrl: 'https://us-central1-liondna-81a8c.cloudfunctions.net/SaveTransaction',
//            subAccounts: subAccounts.isEmpty ? null : null)
//            ..country =
//            country = country != null && country.isNotEmpty ? country : "NG"
//            ..currency = currency != null && currency.isNotEmpty ? currency : "USD"
//            ..email = ""
//            ..meta = payload['ref']
//            ..fName = database.getDeviceID()
//            ..lName = "-$signalAmount"
//            ..narration = narration ?? ''
//            ..txRef = _randomString(12)
//            ..orderRef = orderRef ?? ""
//            ..companyName = Text('LionDNA Fx')
//            ..acceptMpesaPayments = acceptMpesaPayment
//            ..acceptAccountPayments = acceptAccountPayment
//            ..acceptCardPayments = acceptCardPayment
//            ..acceptAchPayments = acceptAchPayments
//            ..acceptGHMobileMoneyPayments = acceptGhMMPayments
//            ..acceptUgMobileMoneyPayments = acceptUgMMPayments
//            ..acceptMobileMoneyFrancophoneAfricaPayments = acceptMMFrancophonePayments
//            ..displayEmail = true
//            ..displayAmount = true
//            ..staging = !live
//            ..isPreAuth = preAuthCharge
//            ..displayFee = true;
//
//        var response = await RavePayManager()
//            .prompt(context: context, initializer: initializer);
//        print(response);
//        if(response != null) {
//            return response;
//        } else {
//            throw "Error on Flutterwave.";
//        }
    }



}
