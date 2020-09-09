import 'package:example/test/custom_delegate/custom_photo_preview_video_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:photo_preview/photo_preview_export.dart';

import 'custom_delegate/custom_photo_preview_image_delegate.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      alignment: Alignment.center,
      child: _toMainWidget(),
    ));
  }

  Widget _toMainWidget() {
    return PhotoPreviewHeroWidget(
        tag: "test2",
        onClickForTag: (tag) {
          PhotoPreviewPage.navigatorPush(
            context,
            PhotoPreviewDataSource(
                imgVideoFullList: [
                  // PhotoPreviewInfoVo(
                  //     url: "https://v-cdn.zjol.com.cn/277001.mp4",
                  //     vCoverUrl:
                  //         "https://zts-tx.oss-cn-beijing.aliyuncs.com/picture/splash_ad/3.png",
                  //     heroTag: "a"),
                  // PhotoPreviewInfoVo(
                  //   url: "https://p.pstatp.com/origin/1379a000109aa279a2bd8.jpg",
                  // ),
                  PhotoPreviewInfoVo(
                      url:
                          "http://pic.8688g.com/up/2020-7/202072710359875970.jpg",
                      heroTag: "test"),
                  PhotoPreviewInfoVo(
                      url:
                          "https://zts-tx.oss-cn-beijing.aliyuncs.com/picture/splash_ad/3.png",
                      heroTag: "test2"),
                  PhotoPreviewInfoVo(
                      url:
                          "http://pic.8688g.com/up/2020-7/2020727103514764860.jpg",
                      heroTag: "test3"),
                ],
                // initialUrl:
                //     "https://zts-tx.oss-cn-beijing.aliyuncs.com/picture/splash_ad/3.png",
                initialPage: 1),
            // videoDelegate: CustomPhotoPreviewVideoDelegate(),
            imageDelegate: CustomPhotoPreviewImageDelegate(),
            totalAmount: 3,
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.red,
              child: Image.network(
                  'https://zts-tx.oss-cn-beijing.aliyuncs.com/picture/splash_ad/3.png'),
            ),
            // Container(
            //   height: 200,
            //   width: 200,
            //   color: Colors.green,
            //   child: Text('2'),
            // ),
            // Container(
            //   height: 200,
            //   width: 200,
            //   color: Colors.blue,
            //   child: Text('3'),
            // )
          ],
        ));
  }
}
