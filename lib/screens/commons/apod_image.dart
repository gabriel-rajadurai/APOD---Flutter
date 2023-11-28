import 'package:apod_flutter/screens/commons/progress_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ApodImage extends StatelessWidget {
  final String apodUrl;
  final BoxFit fit;

  const ApodImage({super.key, required this.apodUrl, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: apodUrl,
      progressIndicatorBuilder: (context, url, progress) =>
          const ApodLoadingIndicator(loadingText: "Loading image"),
      fit: fit,
    );
  }
}
