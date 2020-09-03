import 'package:flutter/material.dart';
import 'package:liondnafx/common/routing_constants.dart';
import 'package:liondnafx/pages/splash.dart';


Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenRoute:
      return MaterialPageRoute(builder: (context) => Splash());
  }
}