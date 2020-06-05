import 'package:flutter/material.dart';
import 'package:flutteropenyes/model/issue_model.dart';

class HomePageModel extends ChangeNotifier{
  List<Item> bannerList = [];
  List<Item> itemList = [];
  int currentIndex = 0;
  String nextPageUrl;
  bool loading = true;


}