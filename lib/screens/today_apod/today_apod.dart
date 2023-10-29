
import 'package:apod_data/model/apod.dart';
import 'package:apod_flutter/bloc/bloc_provider.dart';
import 'package:apod_flutter/screens/commons/apod_image.dart';
import 'package:apod_flutter/screens/commons/progress_indicator.dart';
import 'package:apod_flutter/screens/today_apod/today_apod_bloc.dart';
import 'package:flutter/material.dart';

class TodayApod extends StatefulWidget {
  const TodayApod({super.key});

  @override
  State<TodayApod> createState() => _TodayApodState();
}

class _TodayApodState extends State<TodayApod> {
   @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    final bloc = BlocProvider.of<TodayApodBloc>(context);
    
    return StreamBuilder<APOD?>(
      stream: bloc.apodStream,
      builder: (context, snapshot) {
        final apod = snapshot.data;
        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            apod == null
                ? const Expanded(
                    child: ApodLoadingIndicator(loadingText: "Please wait"))
                : Expanded(
                    child: Stack(
                      children: [
                        Positioned.fill(child: ApodImage(apodUrl: apod.hdurl!)),
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
                                  apod.title!,
                                  style: theme.textTheme.headlineSmall,
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  apod.explanation!,
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
                                    
                                  },
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0)))),
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
                        )
                      ],
                    ),
                  ),
          ],
        );
      }
    );
  }
}
