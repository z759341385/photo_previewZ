import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:photo_preview/src/constant/photo_preview_quality_type_constant.dart';
import 'package:photo_preview/src/vo/photo_preview_quality_type.dart';
import 'package:photo_preview/src/vo/photo_preview_type.dart';

import '../../photo_preview_export.dart';

///图片工具类
class PhotoPreviewToolUtils {
  ///转化数据源
  static List<PhotoPreviewInfoVo> transDataToPhotoPreviewList(
      List<String> dataSourceList) {
    if (dataSourceList == null || dataSourceList.isEmpty) {
      return null;
    }
    List<PhotoPreviewInfoVo> _photoPreviewList = List();
    dataSourceList.forEach((element) {
      if (element == null || element.isEmpty) {
        return;
      }
      _photoPreviewList
          ?.add(PhotoPreviewInfoVo(url: element));
    });
    return _photoPreviewList;
  }

  ///初始化计算缩放
  static double initScale({Size imageSize, Size size, double initialScale}) {
    final double n1 = imageSize.height / imageSize.width;
    final double n2 = size.height / size.width;
    //todo：强制宽
    final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
    //final Size sourceSize = fittedSizes.source;
    final Size destinationSize = fittedSizes.destination;
    return size.width / destinationSize.width;
    if (n1 > n2) {
      final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.width / destinationSize.width;
    } else if (n1 / n2 < 1 / 4) {
      final FittedSizes fittedSizes = applyBoxFit(BoxFit.contain, imageSize, size);
      //final Size sourceSize = fittedSizes.source;
      final Size destinationSize = fittedSizes.destination;
      return size.height / destinationSize.height;
    }

    return initialScale;
  }

  ///判断是否是网络路径
  static bool isNetUrl(String url){
    if(url == null || url.isEmpty){
      return false;
    }
    if(url.startsWith("http://") || url.contains("https://")){
      return true;
    }
    return false;
  }

  ///路径类型
  static PhotoPreviewType getType(String url) {
    if (url == null || url.isEmpty) {
      return PhotoPreviewType.unknow;
    }
    if (isImage(url)) {
      return PhotoPreviewType.image;
    }
    if (isVideo(url)) {
      return PhotoPreviewType.video;
    }
    return PhotoPreviewType.unknow;
  }

  ///是否是图片类型
  static bool isImage(String path) {
    if (path == null || path.isEmpty) {
      return false;
    }
    List<String> typeList = ["jpg", "jpeg", "png", "bmp", "webp"];
    int index = path.lastIndexOf(".");
    String suffix = path.substring(index + 1);
    if (suffix == null || suffix.isEmpty) {
      return false;
    }
    return typeList.indexOf(suffix) != -1 ||
        typeList.indexOf(suffix.toLowerCase()) != -1;
  }

  ///是否是视频类型
  static bool isVideo(String path) {
    if (path == null || path.isEmpty) {
      return false;
    }
    List<String> typeList = [
      "mpeg",
      "mpg",
      "mp4",
      "mov",
      "3gp",
      "mkv",
      "webm",
      "ts",
      "avi",
      "3gpp",
      "3gpp2",
      "3g2",
      "m4u"
    ];
    int index = path.lastIndexOf(".");
    String suffix = path.substring(index + 1);
    if (suffix == null || suffix.isEmpty) {
      return false;
    }
    return typeList.indexOf(suffix) != -1 ||
        typeList.indexOf(suffix.toLowerCase()) != -1;
  }

  ///拼接质量类型路径
  static String getAppendQualityTypeUrl(String url,PhotoPreviewQualityType qualityType){
    if(url == null || url.isEmpty){
      return null;
    }
    if(qualityType == null){
      return url;
    }
    StringBuffer buffer = StringBuffer(url);
    buffer.write(PhotoPreviewQualityTypeConstant.getQualityTypeStr(qualityType) ?? "");
    return buffer.toString();
  }
}
