import 'package:apod_data/model/apod.dart';
import 'package:apod_flutter/screens/commons/apod_image.dart';
import 'package:flutter/material.dart';

class ApodListTile extends StatefulWidget {
  final APOD apod;

  const ApodListTile({super.key, required this.apod});

  @override
  State<ApodListTile> createState() => _ApodListTileState();
}

class _ApodListTileState extends State<ApodListTile> {
  bool isDescriptionShown = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  if (widget.apod.media_type == APOD.MEDIA_TYPE_IMAGE) {
                    return ApodImage(apodUrl: widget.apod.url!);
                  } else {
                    return Center(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.play_circle_outlined)));
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: [
                    Text(
                      widget.apod.title!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        _toggleDescription();
                      },
                      icon: const Icon(Icons.expand_less),
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void _toggleDescription() {}
}
