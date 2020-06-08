import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutteropenyes/config/string.dart';
import 'package:flutteropenyes/plugin/speech_plugin.dart';
import 'package:flutteropenyes/provider/video_search_model.dart';
import 'package:flutteropenyes/util/navigator_manager.dart';
import 'package:flutteropenyes/widget/loading_caontainer.dart';
import 'package:flutteropenyes/widget/provider_widget.dart';
import 'package:flutteropenyes/widget/serach_video_widget_item.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
 class VideoSerachPage extends StatelessWidget {
   //用于TextField焦点的监听
   final focusNode = FocusNode();
   @override
   Widget build(BuildContext context) {
     return Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
         child: SafeArea(
             child: ProviderWidget<VideoSearchModel>(
               model: VideoSearchModel(),
               onModelInit: (model){return model.getKeyWords();},
               builder: (context,model,child){
                return Column(
                  children: <Widget>[
                    _searchBar(model, context),
                    Expanded(
                        flex: 1,
                        child: Stack(
                            children: <Widget>[
                              _keyWordWidget(model),
                              _searchVideoWidget(model),
                              _emptyWidget(model)
                            ],
                        ))
                  ],
                );
               },
             )

         ),

        ),
     );
   }

 Widget _searchBar(VideoSearchModel model, BuildContext context) {
     return Padding(padding: EdgeInsets.only(top: 10,right: 16),
     child: Row(
         children: <Widget>[
           IconButton(
               icon: Icon(
                 Icons.arrow_back,
                 size: 20,
                 color: Colors.black26,
               ),
               onPressed: () => NavigatorManager.back()),
           Expanded(child: ConstrainedBox(
            //通过ConstrainedBox修改TextField的高度
             constraints: BoxConstraints(maxHeight: 30),
            child: TextField(
             autofocus: true,
              focusNode: focusNode,

               textInputAction: TextInputAction.search,
              onSubmitted: (value){
                model.query = value;
                model.loadMore(loadMore: false);
              },
              decoration: InputDecoration(
           hintText: DString.interest_video,
           hintStyle: TextStyle(fontSize: 13),
                contentPadding: EdgeInsets.only(top: 15),
                prefixIcon: Icon(
                  Icons.search,
                  size: 20,
                  color: Colors.black26,
                ),
                fillColor: Color(0x0D000000),
                filled: true,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),

           )),
   Offstage(
   offstage: !Platform.isAndroid,
   child: IconButton(
   icon: Icon(Icons.keyboard_voice, color: Colors.black26),
   onPressed: () {
   _showSpeechDialog(model);
   }))
       ],
     ),
     );
     
 }

   _showSpeechDialog(VideoSearchModel model) {
     SpeechPlugin.start().then((result) {
       print("mao"+result);
       if (result.isNotEmpty) {
         focusNode.unfocus();
         model.query = result;
         model.loadMore(loadMore: false);
       }
     });
   }

 Widget _keyWordWidget(VideoSearchModel model) {
     return Offstage(
       offstage: model.hideKeyWord,
       child: Column(
         children: <Widget>[
           Padding(padding: EdgeInsets.only(top: 25),
             child: Center(
               child: Text(
                 DString.hot_key_word,
                 style: TextStyle(fontSize: 16, color: Colors.black),
               ),
             ),
           ),
           Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
           child: Wrap(
               alignment: WrapAlignment.center,
               spacing: 6,
               runSpacing: 10,
               children: _keyWordWidgets(model)
           ),
           )


         ],
       ),
     );
     
 }

  Widget _searchVideoWidget(VideoSearchModel model) {
    return Offstage(
        offstage: model.dataList == null || model.dataList.length == 0,
        child: LoadContainer(
            loading: model.loading,
            child: Column(children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: Text('— 「${model.query}」搜索结果共${model.total}个 —',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ))),
              Expanded(
                  flex: 1,
                  child: SmartRefresher(
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: model.loadMore,
                      controller: model.refreshController,
                      child: ListView.builder(
                          itemCount: model.dataList.length,
                          itemBuilder: (context, index) {
                            return SearchVideoWidgetItem(
                                item: model.dataList[index]);
                          })))
            ])));

  }

  _emptyWidget(VideoSearchModel model) {
   return Offstage(
     offstage: model.hideEmpty,
    child: Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.sentiment_dissatisfied,
            size: 60, color: Colors.black54),
        Padding(
            padding: EdgeInsets.only(top: 5),
            child: Text(
              DString.no_data,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ))
      ],
    ),
    ),
   );
  }

   List<Widget>  _keyWordWidgets(VideoSearchModel model) {
     return model.keyWords.map((keyword){
       return GestureDetector(
         onTap: (){
           focusNode.unfocus();
           model.query = keyword;
           model.loadMore(loadMore: false);
         },
           child: Container(
               padding: EdgeInsets.fromLTRB(14, 8, 14, 8),
               decoration: BoxDecoration(
                 color: Color(0x1A000000),
                 borderRadius: BorderRadius.circular(20),
               ),
               child: Text(
                 keyword,
                 style: TextStyle(fontSize: 12, color: Colors.black45),
               ))
       );

     }).toList();

  }
 }




 