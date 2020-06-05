import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_splash_screen/flutter_splash_screen.dart';

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
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Center(
        child: Text("莎莎还是生活上"),
      ),
    );
  }

 Future<void> hideSplashscreen() async{
  Future.delayed(Duration(microseconds: 2000),()=>FlutterSplashScreen.hide());
 }

}






