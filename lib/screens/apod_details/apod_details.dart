import 'package:apod_data/model/apod.dart';
import 'package:apod_flutter/screens/commons/apod_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ApodDetails extends StatelessWidget {
  final APOD apod;

  const ApodDetails({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: 500
          ),
          child: Builder(builder: (context) {
            if (apod.mediaType == APOD.MEDIA_TYPE_IMAGE) {
              return ApodImage(apodUrl: apod.hdurl!, fit: BoxFit.contain);
            } else {
              return Center(
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle_outlined),
                ),
              );
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                apod.explanation.toString(),
              ),
              const SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: dateWidget(),
              ),
            ],
          ),
        )
      ],
    );
  }

  Text dateWidget() {
    var apodDate = DateFormat("yyyy-MM-dd").parse(apod.date);
    var displayDate = DateFormat("MMM dd, yyyy").format(apodDate);
    return Text(displayDate);
  }
}
