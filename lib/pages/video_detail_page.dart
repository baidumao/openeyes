import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutteropenyes/config/string.dart';
import 'package:flutteropenyes/model/issue_model.dart';
import 'package:flutteropenyes/provider/video_detail_page_model.dart';
import 'package:flutteropenyes/util/date_util.dart';
import 'package:flutteropenyes/util/navigator_manager.dart';
import 'package:flutteropenyes/widget/loading_caontainer.dart';
import 'package:flutteropenyes/widget/provider_widget.dart';
import 'package:flutteropenyes/widget/video_relate_widget_item.dart';
import 'package:video_player/video_player.dart';

const VIDEO_SMALL_CARD_TYPE = 'videoSmallCard';

const VIDEO_HIGH = 'high';
class VideoDetailPage extends StatefulWidget {
  final Data data;

  VideoDetailPage({this.data});

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> with WidgetsBindingObserver {
  VideoPlayerController _videoPlayerController;
  ChewieController _cheWieController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initController();
    WidgetsBinding.instance.addObserver(this); //监听页面可见与不可见状态

  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //AppLifecycleState当前页面的状态(是否可见)
    if (state == AppLifecycleState.paused) {
      //页面不可见时,暂停视频
      _cheWieController.pause();
    }
  }
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoDetailPageModel>(
      model: VideoDetailPageModel(),
      onModelInit: (model){
        model.loadVideoRelateData(widget.data.id);
      },
      builder: (context,model,child){
        return AnnotatedRegion(
            child: Scaffold(
              body: Container(
               decoration: BoxDecoration(
                image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.data.cover.blurred),
                     fit: BoxFit.cover
                )
               ),
                child: Column(
                  children: <Widget>[
                 Hero(tag: '${widget.data.id}${widget.data.time}',
                     child: Chewie(
                   controller: _cheWieController,
                     )),
                    Expanded(child: LoadContainer(
                      loading: model.loading,
                      child: CustomScrollView(
                         slivers: <Widget>[
                             SliverToBoxAdapter(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: <Widget>[
                                   Container(
                                     margin: EdgeInsets.only(left: 10,top: 10),
                                       child: Text(
                                         widget.data.title,
                                         style: TextStyle(
                                             fontSize: 18,
                                             color: Colors.white,
                                             fontWeight:
                                             FontWeight.bold),
                                       )
                                   ),
                                   Container(
                                       margin: EdgeInsets.only(left: 10,top: 10),
                                       child: Text(
                                         '#${widget.data.category} / ${DateUtils.formatDateMsByYMDHM(widget.data.author.latestReleaseTime)}',
                                         style: TextStyle(
                                             fontSize: 12,
                                             color: Colors.white,
                                            ),
                                       )
                                   ),
                                   Container(
                                       margin: EdgeInsets.only(left: 10,top: 10),
                                       child: Text(
                                         widget.data.description,
                                         style: TextStyle(
                                           fontSize: 14,
                                           color: Colors.white,
                                         ),
                                       )
                                   ),
                                   Container(
                                     margin: EdgeInsets.only(
                                         left: 10, top: 10),
                                       child: Row(
                                         children: <Widget>[
                                           Row(
                                             children: <Widget>[
                                               Image.asset(
                                                 'images/icon_like.png',
                                                 height: 22,
                                                 width: 22,
                                               ),
                                               Padding(
                                                 padding:
                                                 EdgeInsets.only(
                                                     left: 3),
                                                 child: Text(
                                                   '${widget.data.consumption.collectionCount}',
                                                   style: TextStyle(
                                                       color: Colors
                                                           .white,
                                                       fontSize: 13),
                                                 ),
                                               )
                                             ],
                                           ),
                                           Padding(
                                             padding: EdgeInsets.only(
                                                 left: 30),
                                             child: Row(
                                               children: <Widget>[
                                                 Image.asset(
                                                   'images/ic_share_white.png',
                                                   height: 22,
                                                   width: 22,
                                                 ),
                                                 Padding(
                                                   padding:
                                                   EdgeInsets.only(
                                                       left: 3),
                                                   child: Text(
                                                     '${widget.data.consumption.shareCount}',
                                                     style: TextStyle(
                                                         color: Colors
                                                             .white,
                                                         fontSize: 13),
                                                   ),
                                                 )
                                               ],
                                             ),
                                           ),
                                           Padding(
                                             padding: EdgeInsets.only(
                                                 left: 30),
                                             child: Row(
                                               children: <Widget>[
                                                 Image.asset(
                                                   'images/icon_comment.png',
                                                   height: 22,
                                                   width: 22,
                                                 ),
                                                 Padding(
                                                   padding:
                                                   EdgeInsets.only(
                                                       left: 3),
                                                   child: Text(
                                                     '${widget.data.consumption.replyCount}',
                                                     style: TextStyle(
                                                         color: Colors
                                                             .white,
                                                         fontSize: 13),
                                                   ),
                                                 )
                                               ],
                                             ),
                                           )
                                         ],
                                       )

                                   ),
                                   Container(
                                     margin: EdgeInsets.only(top: 10),
                                     child: Divider(
                                       height: 0.5,
                                       color: Colors.white,
                                     )
                                   ),
                                   Row(
                                     children: <Widget>[
                                       Padding(padding: EdgeInsets.all(10),
                                         child: ClipOval(
                                           child: CachedNetworkImage(imageUrl: widget
                                               .data.author.icon,
                                           width: 40,
                                             height: 40,
                                             errorWidget: (context,url,erro)=>Image.asset(
                                                 'images/img_load_fail.png'),
                                           ),

                                         ),
                                       ),
                                       Expanded(
                                           flex: 1,
                                           child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text(
                                                   widget
                                                       .data.author.name,
                                                   style: TextStyle(
                                                       fontSize: 15,
                                                       color: Colors
                                                           .white)),
                                               Padding(
                                                   padding:
                                                   EdgeInsets.only(
                                                       top: 3),
                                                   child: Text(
                                                       widget.data.author
                                                           .description,
                                                       style: TextStyle(
                                                           fontSize: 13,
                                                           color: Colors
                                                               .white)))

                                             ],
                                           )),
                                       Padding(padding: EdgeInsets.only(right: 10),
                                         child: Container(
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius:
                                                 BorderRadius
                                                     .circular(5)),
                                             padding: EdgeInsets.all(5),
                                             child: Text(
                                                 DString.add_follow,
                                                 style: TextStyle(
                                                     fontWeight:
                                                     FontWeight.bold,
                                                     color: Colors.grey,
                                                     fontSize: 12))),
                                       )
                                     ],
                                   ),
                                   Divider(
                                     height: 0.5,
                                     color: Colors.white,
                                   )

                                 ],

                               ),
                             ),
                           SliverList(delegate: SliverChildBuilderDelegate((context,index){
                             if (model.itemList[index].type ==
                                 VIDEO_SMALL_CARD_TYPE) {
                               return VideoRelateWidgetItem(
                                   data: model.itemList[index].data,
                                   callBack: () {
                                     _videoPlayerController.pause();
                                     NavigatorManager.to(
                                         VideoDetailPage(
                                             data: model
                                                 .itemList[index]
                                                 .data));
                                   });
                             }
                             return Padding(
                                 padding: EdgeInsets.all(10),
                                 child: Text(
                                   model.itemList[index].data.text,
                                   style: TextStyle(
                                       color: Colors.white,
                                       fontWeight: FontWeight.bold,
                                       fontSize: 16),
                                 ));
                           },childCount: model.itemList.length))
                         ],
                      ),
                    ),
                        flex: 1
                    )
                  ],
                ),
              ),
            ),
            value: SystemUiOverlayStyle.light
        );

      },
    );
  }


  void initController() {
    List<PlayInfo> playInfoList = widget.data.playInfo;
    if (playInfoList.length > 1) {
      for (var playInfo in playInfoList) {
        if (playInfo.type == VIDEO_HIGH) {
          _videoPlayerController = VideoPlayerController.network(playInfo.url);
          _cheWieController = ChewieController(
              videoPlayerController: _videoPlayerController, autoPlay: true);
          break;
        }
      }
    } else {
      //若无高清视频，则取默认视频地址
      _videoPlayerController =
          VideoPlayerController.network(widget.data.playUrl);
      _cheWieController = ChewieController(
          videoPlayerController: _videoPlayerController, autoPlay: true);
    }
  }
}
