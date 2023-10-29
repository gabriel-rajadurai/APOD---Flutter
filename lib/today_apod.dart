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
  String _apodTitle = "";
  String _apodDescription = "";
  final ApodRepo _apodRepo = ApodRepo();

  void _getAPOD() async {
    if (_apodUrl != null) return;
    APOD apod = await _apodRepo.fetchApodOfTheDay();
    setState(() {
      _apodUrl = apod.hdurl;
      var title = apod.title;
      if (title != null) {
        _apodTitle = title;
      }
      var description = apod.explanation;
      if (description != null) {
        _apodDescription = description;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    _getAPOD();
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _apodUrl == null
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
                      //TODO Change this based on screen size and loaded image size
                      fit: BoxFit.cover,
                    ),
            )
          ],
        ),
        Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  _apodTitle,
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  _apodDescription,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(
                  height: 40.0,
                ),
                OutlinedButton(
                  onPressed: () {
                    _openApodList();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Discover more",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                )
              ],
            ),
          ),
        ),
        AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: const Text("Today's Picture"),
        )
      ],
    );
  }

  Widget progressIndicator(String loaderText) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          Text(loaderText),
        ],
      ),
    );
  }
  
  void _openApodList() {

  }
}
