import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../theme/app_theme.dart';

class CustomImageWidget extends StatelessWidget {
  CustomImageWidget({
    super.key,
    required this.URL,
    required this.width,
    required this.height,
    this.fit = BoxFit.fill,
    this.borderRadius = 12,
  });

  String URL;
  double height;
  double width;
  BoxFit fit;
  double borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: URL,
      imageBuilder: (context, imageProvider) => Container(
        padding: EdgeInsets.symmetric(vertical: 8.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          image: DecorationImage(
            image: imageProvider,
            fit: fit,
          ),
        ),
      ),
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: AppTheme.colors.darkGray.withOpacity(0.5),
        highlightColor: AppTheme.colors.lightGray,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: AppTheme.colors.lightGray.withOpacity(0.5),
              borderRadius: BorderRadius.circular(borderRadius.r)),
        ),
      ),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: AppTheme.colors.lightGray.withOpacity(0.5),
            borderRadius: BorderRadius.circular(borderRadius.r)),
        child: Icon(
          Icons.error_outline,
          size: 40.r,
        ),
      ),
    );
  }
}
