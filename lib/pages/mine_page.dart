import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  var _imageFile;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        child: Container(
          color: Colors.white,
          child: SafeArea(
              child: Column(
            children: <Widget>[
              GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 44,
                    backgroundImage: AssetImage('images/ic_img_avatar.png')
//                    AssetImage('images/ic_img_avatar.png')
//                        : FileImage(_imageFile),
                  ),
                ),
                //头像点击
                onTap: () {},
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsetsDirectional.only(top: 20),
                child: Text(
                  "fmtjava",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsetsDirectional.only(top: 20),
                child: Text(
                  "查看个人主页>",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    _operateWidget('images/icon_like_grey.png', '收藏'),
                    Container(
                      width: 0.5,
                      height: 40,
                      color: Colors.grey,
                    ),
                    _operateWidget('images/icon_comment_grey.png', '评论'),
                  ],
                ),
              ),
             Container(
               margin: EdgeInsets.only(top: 20),
               height: 0.5,
               color: Colors.grey,
             ),
              _settingWidget('我的消息'),
              _settingWidget('我的记录'),
              _settingWidget('我的缓存'),
              _settingWidget('观看记录', callback: () {

              }),
              _settingWidget('意见反馈')
            ],
          )),
        ),
        value: SystemUiOverlayStyle.dark);
  }

  Widget _operateWidget(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(image, width: 20, height: 20),
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            text,
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        )
      ],
    );
  }

  Widget _settingWidget(String text, {VoidCallback callback}) {
    return GestureDetector(
      onTap: callback,
      child: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }
}
