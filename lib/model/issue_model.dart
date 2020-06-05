
import 'dart:collection';

import 'package:flutteropenyes/model/paging_model.dart';

class IssueEntity{
  int nextPublishTime;
  String newestIssueType;
  String nextPageUrl;
  List<Issue> issueList;

  IssueEntity({this.nextPublishTime, this.newestIssueType, this.nextPageUrl,
      this.issueList});
  factory IssueEntity.fromjson(HashMap<String,dynamic> json){
    return IssueEntity(
      newestIssueType: json["newestIssueType"],
      nextPublishTime: json["nextPublishTime"],
      nextPageUrl: json[""]

    );
  }


}

class Issue extends PagingModel<Item>{
   int count;
   int date;
   int publishTime;
   int releaseTime;
   String type;

   Issue({this.count, this.date, this.publishTime, this.releaseTime, this.type});
   factory Issue.fromjson(HashMap<String,dynamic> json){
     return
   }




}

class Item {

}