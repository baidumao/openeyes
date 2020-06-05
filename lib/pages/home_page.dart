
import 'package:flutter/material.dart';
import 'package:flutteropenyes/config/string.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBar(
           title: Text(DString.daily_paper,
             style: TextStyle(
               fontSize: 18,
                color: Colors.black,
                 fontWeight:FontWeight.bold
             ),
           ),
           brightness:  Brightness.light,
           elevation: 0,
           backgroundColor: Colors.white,
           centerTitle: true,
           actions: <Widget>[
             IconButton(icon: Icon(Icons.search,
               color: Colors.black87,
             ), onPressed: (){
               //搜索点击事件

             })
           ],
         ),
    );
  }
}
