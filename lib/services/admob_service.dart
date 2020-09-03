import 'dart:io';

class AdMobService {

//  String getAdMobAppId() {
//    if (Platform.isIOS) {
//      return 'ca-app-pub-9596845007514109~9319120150';
//    } else if (Platform.isAndroid) {
//      return 'ca-app-pub-9596845007514109~3711570259';
//    }
//    return null;
//  }
//
//  String getBannerAdId() {
//    if (Platform.isIOS) {
//      return 'ca-app-pub-9596845007514109/5379875145';
//    } else if (Platform.isAndroid) {
//      return 'ca-app-pub-9596845007514109/3279599068';
//    }
//    return null;
//  }

  String getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544~1458002511';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544~3347511713';
    }
    return null;
  }

  String getBannerAdId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    }
    return null;
  }

}