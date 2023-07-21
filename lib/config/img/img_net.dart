
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class ImgNet{
  static Widget net(String url,{
    double? width,
    double? height,
    BoxFit? fit,
    BoxBorder? border,
    BoxShape? boxShape
  }){
   return ExtendedImage.network(
      url,
      width: width,
      height: height,
      fit: fit,
      cache: true,
      shape: boxShape,
      border:border ,
      printError: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return CircularProgressIndicator();

          case LoadState.completed:
            return state.completedWidget;
          case LoadState.failed:
            return GestureDetector(
              child: const Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Icon(Icons.error_rounded,color: Colors.red,),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Text(
                      "加载图片失败，点击重试",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              onTap: () {
                state.reLoadImage();
              },
            );
            break;
        }
      },
    );

  }
}