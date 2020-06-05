import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';
import 'package:flutteropenyes/navigator/tab_navigation.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  //安卓设置沉浸式状态栏
  if(Platform.isAndroid){
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //解决启动白屏
    hideSplashscreen();
    return MaterialApp(
     navigatorKey: Get.key,home: TabNavigation(),
    );
  }

 Future<void> hideSplashscreen() async{
  Future.delayed(Duration(microseconds: 2000),()=>FlutterSplashScreen.hide());
 }

}






