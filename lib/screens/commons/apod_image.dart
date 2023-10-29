import 'package:apod_flutter/screens/commons/progress_indicator.dart';
import 'package:flutter/material.dart';

class ApodImage extends StatelessWidget {
  final String apodUrl;

  const ApodImage({super.key, required this.apodUrl});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      apodUrl,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        } else {
          return const ApodLoadingIndicator(loadingText: "Loading image");
        }
      },
      //TODO Change this based on screen size and loaded image size
      fit: BoxFit.cover,
    );
  }
}
