import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_preview/photo_preview_export.dart';
import 'package:photo_preview/src/delegate/photo_preview_image_delegate.dart';
import 'package:photo_preview/src/delegate/photo_preview_video_delegate.dart';
import 'package:photo_preview/src/photo_preview_page/photo_preview_state.dart';
import 'package:photo_preview/src/utils/photo_callback.dart';
import 'package:photo_preview/src/vo/photo_preview_data_source.dart';
import 'package:photo_preview/src/vo/photo_preview_quality_type.dart';

///图片浏览器页面
class PhotoPreviewPage extends StatefulWidget {
  ///传入数据源
  final PhotoPreviewDataSource dataSource;
  final ExtendedSlideDelegate extendedSlideDelegate;
  final PhotoPreviewImageDelegate imageDelegate;
  final PhotoPreviewVideoDelegate videoDelegate;
  final int totalAmount;
  const PhotoPreviewPage(
      {Key key,
      this.dataSource,
      this.extendedSlideDelegate,
      this.imageDelegate,
      this.videoDelegate,
      @required this.totalAmount})
      : super(key: key);

  @override
  PhotoPreviewState createState() =>
      PhotoPreviewState(totalAmount: totalAmount);

  ///跳转到
  static navigatorPush(BuildContext context, PhotoPreviewDataSource dataSource,
      {PhotoPreviewCallback callback,
      ExtendedSlideDelegate extendedSlideDelegate,
      PhotoPreviewImageDelegate imageDelegate,
      PhotoPreviewVideoDelegate videoDelegate,
      @required int totalAmount}) {
    if (dataSource == null ||
        dataSource.imgVideoFullList == null ||
        dataSource.imgVideoFullList.isEmpty) {
      callback?.onError("数据为空");
      return;
    }
    Route _route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => PhotoPreviewPage(
          dataSource: dataSource,
          extendedSlideDelegate: extendedSlideDelegate,
          imageDelegate: imageDelegate,
          videoDelegate: videoDelegate,
          totalAmount: totalAmount),
      opaque: false,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeUpwardsPageTransitionsBuilder().buildTransitions<dynamic>(
            null, context, animation, secondaryAnimation, child);
      },
    );
    Navigator.push<dynamic>(context, _route).then((value) {
      callback?.onSuccess(value);
    });
  }

//  ///返回带有统一hero的组件
//  static Widget heroWidget({Widget child,String tag,bool isUserHero = true}){
//    if(isUserHero == null || isUserHero == false){
//      return child ?? Container();
//    }
//    return Hero(
//      tag: tag ?? "",
//      child: child ?? Container(),
//      transitionOnUserGestures: true,
//      placeholderBuilder: (BuildContext ctx,Size size,Widget result){
//        return result;
//      },
//    );
//  }
}
