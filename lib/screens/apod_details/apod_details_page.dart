import 'package:apod_data/model/apod.dart';
import 'package:flutter/material.dart';

import 'apod_details.dart';

class ApodDetailsPage extends StatelessWidget {
  final APOD apod;

  const ApodDetailsPage({super.key, required this.apod});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: AppBar(
              backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                title: Text(
                  apod.title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                )),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: ApodDetails(
              apod: apod,
            ),
          )
        ],
      ),
    );
  }
}
