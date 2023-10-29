import 'package:flutter/material.dart';

class ApodLoadingIndicator extends StatelessWidget {
  final String loadingText;

  const ApodLoadingIndicator({super.key, this.loadingText = ""});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          Text(loadingText),
        ],
      ),
    );
  }
}
