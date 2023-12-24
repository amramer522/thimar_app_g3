import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppImage extends StatelessWidget {
  final String url;
  final double? height, width;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
  const AppImage(this.url, {Key? key,this.borderRadius= BorderRadius.zero, this.fit = BoxFit.scaleDown, this.height, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.startsWith("http")) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: Image.network(
          url,
          height: height,
          width: width,
          fit: fit,
          errorBuilder: (context, error, stackTrace) => Text("Error"),
        ),
      );
    } else if (url.endsWith("svg")) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: SvgPicture.asset(
          url,
          height: height,
          width: width,
          fit: fit,
        ),
      );
    }
    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.asset(
        url,
        height: height,
        width: width,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => Text("Error"),
      ),
    );
  }
}
