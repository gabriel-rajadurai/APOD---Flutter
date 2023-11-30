
import 'package:apod_data/model/apod.dart';
import 'package:apod_flutter/screens/apod_list/apod_description.dart';
import 'package:apod_flutter/screens/commons/apod_image.dart';
import 'package:flutter/material.dart';

class ApodListTile extends StatefulWidget {
  final APOD apod;
  final VoidCallback openApod;

  const ApodListTile({super.key, required this.apod, required this.openApod});

  @override
  State<ApodListTile> createState() => _ApodListTileState();
}

class _ApodListTileState extends State<ApodListTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool isDescriptionShown = false;

  @override
  void initState() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
        upperBound: 0.5);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 300,
          child: Stack(
            fit: StackFit.expand,
            children: [
              InkWell(
                onTap: widget.openApod,
                child: Builder(builder: (context) {
                  if (widget.apod.mediaType == APOD.MEDIA_TYPE_IMAGE) {
                    return ApodImage(apodUrl: widget.apod.url!);
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
              Visibility(
                visible: isDescriptionShown,
                maintainAnimation: true,
                maintainState: true,
                child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastOutSlowIn,
                    opacity: isDescriptionShown ? 1 : 0,
                    child: ApodDescription(
                      apod: widget.apod,
                      openApod: widget.openApod,
                    )),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text(
                  widget.apod.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                child: IconButton(
                  onPressed: () {
                    _toggleDescription();
                  },
                  icon: const Icon(Icons.expand_less),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  void _toggleDescription() {
    if (!isDescriptionShown) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() {
      isDescriptionShown = !isDescriptionShown;
    });
  }
}
