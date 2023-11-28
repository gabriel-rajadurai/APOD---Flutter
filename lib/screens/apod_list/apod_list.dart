import 'dart:developer';

import 'package:apod_data/model/apod.dart';
import 'package:apod_flutter/bloc/bloc_provider.dart';
import 'package:apod_flutter/screens/apod_details/apod_details_page.dart';
import 'package:apod_flutter/screens/apod_list/apod_list_bloc.dart';
import 'package:apod_flutter/screens/apod_list/apod_tile.dart';
import 'package:apod_flutter/screens/commons/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ApodList extends StatefulWidget {
  const ApodList({super.key});

  @override
  State<ApodList> createState() => _ApodListState();
}

class _ApodListState extends State<ApodList> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<ApodListBloc>(context);

    return StreamBuilder(
        stream: bloc.apodStream,
        builder: (context, snapshot) {
          var apodList = snapshot.data;
          if (apodList == null || apodList.isEmpty) {
            return const ApodLoadingIndicator(loadingText: "Please wait");
          } else {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ApodListTile(
                  apod: apodList[index],
                  openApod: () => openApod(apodList[index]),
                );
              },
              itemCount: apodList.length,
            );
          }
        });
  }

  void openApod(APOD apod) async {
    if (apod.media_type == APOD.MEDIA_TYPE_VIDEO) {
      var url = Uri.parse(apod.url!);
      if (!await launchUrl(url)) {
        log("Failed to load url $url");
      }
    } else {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ApodDetailsPage(
                apod: apod,
              )));
    }
  }
}
