import 'package:flutter/material.dart';

class PNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit fit;
  final double width,height;
  const PNetworkImage(this.image, {Key key,this.fit,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      image: image,
      placeholder: 'assets/Drops/loading.gif',
//      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
      fit: fit,
      width: width,
      height: height,
    );
  }
}