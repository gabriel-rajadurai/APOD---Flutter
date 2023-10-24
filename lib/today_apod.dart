import 'package:apod_data/model/apod.dart';
import 'package:apod_data/repo/apod_repo.dart';
import 'package:flutter/material.dart';

class TodayApod extends StatefulWidget {
  const TodayApod({super.key});

  @override
  State<TodayApod> createState() => _TodayApodState();
}

class _TodayApodState extends State<TodayApod> {
  String? _apodUrl;
  final ApodRepo _apodRepo = ApodRepo();

  void _getAPOD() async {
    APOD apod = await _apodRepo.fetchApodOfTheDay();
    setState(() {
      _apodUrl = apod.url;
    });
  }

  @override
  Widget build(BuildContext context) {
    _getAPOD();
    return _apodUrl == null
        ? progressIndicator("Please wait")
        : Image.network(
            _apodUrl!,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              } else {
                return progressIndicator("Loading image");
              }
            },
          );
  }

  Widget progressIndicator(String loaderText) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(),
          Text(loaderText),
        ],
      ),
    );
  }
}
