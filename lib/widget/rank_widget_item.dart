import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutteropenyes/model/issue_model.dart';
import 'package:flutteropenyes/util/date_util.dart';
import 'package:flutteropenyes/util/share_util.dart';
class RankWidgetItem extends StatelessWidget {
  final Item item;
  final bool showCategory;
  final bool showDivder;


  RankWidgetItem({this.item, this.showCategory=true, this.showDivder=true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: (){},
          child: Padding(padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
          child: Stack(
            children: <Widget>[
              ClipRRect(
                child: Hero(tag: '${item.data.id}${item.data.time}',
                    child: CachedNetworkImage(imageUrl: item.data.cover.feed,
                    width: MediaQuery.of(context).size.width,
                      height: 200,
                      errorWidget: (context,ur,error)=>Image.asset('images/img_load_fail.png'),
                      fit: BoxFit.cover,
                    )
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              Positioned(
                  left: 15,
                  top: 10,
                  child: Opacity(
                      opacity: showCategory? 1.0:0.0 ,//处理控件显示隐藏
                      child: ClipOval(
                        child: Container(
                          width: 44,
                          height: 44,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(color: Colors.white54
                          ),
                          child: Text(item.data.category,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white
                          ),
                          ),
                        ),
                      ),
                  )),
              Positioned(
                  right: 15,
                  bottom: 10,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                          decoration: BoxDecoration(color: Colors.black54),
                          padding: EdgeInsets.all(5),
                          child: Text(
                            DateUtils.formatDateMsByMS(
                                item.data.duration * 1000),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ))))
              
            ],
          ),
          ),
        ),
         Container(
           decoration: BoxDecoration(
             color: Colors.white
           ),
           padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
           child: Row(
             children: <Widget>[
               ClipOval(
                   child: CachedNetworkImage(
                     width: 40,
                     height: 40,
                     imageUrl: item.data.author.icon,
                   )),
               Expanded(child: Container(
                 child: Column(
                   children: <Widget>[
                     Text(item.data.title,
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         color: Colors.black,
                         fontSize: 14,
                         fontWeight: FontWeight.bold,
                       ),
                     ),
                     Padding(
                         padding: EdgeInsets.only(top: 2),
                         child: Text(item.data.author.name,
                             style: TextStyle(
                                 color: Color(0xff9a9a9a), fontSize: 12)))
                   ],
                 ),
               ),
                 flex: 1,
               ),
               IconButton(
                   icon: Icon(Icons.share, color: Colors.black38),
                   onPressed: () =>
                       ShareUtil.share(item.data.title, _getShareVideoUrl()))
             ],
           ),
         )
      ],
    );
  }


  String _getShareVideoUrl() {
    var videoUrl;
    List<PlayInfo> playInfoList = item.data.playInfo;
    if (playInfoList.length > 1) {
      for (var playInfo in playInfoList) {
        if (playInfo.type == 'high') {
          videoUrl = playInfo.url;
          break;
        }
      }
    } else {
      videoUrl = item.data.playUrl;
    }
    return videoUrl;
  }
}
