import 'dart:io';

import 'package:apod_data/model/apod.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';

class ApodDescription extends StatelessWidget {
  final APOD apod;
  final VoidCallback openApod;

  const ApodDescription(
      {super.key, required this.apod, required this.openApod});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
        padding: const EdgeInsets.all(8.0),
        color: theme.colorScheme.background.withAlpha(120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            dateWidget(),
            const SizedBox(
              height: 20,
            ),
            Text(
              apod.explanation.toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: openApod, icon: const Icon(Icons.open_in_new)),
                IconButton(
                    onPressed: () {
                      shareLink();
                    },
                    icon: const Icon(Icons.share)),
                IconButton(
                    onPressed: () {
                      downloadImage();
                    },
                    icon: const Icon(Icons.download)),
              ],
            )
          ],
        ));
  }

  Text dateWidget() {
    var apodDate = DateFormat("yyyy-MM-dd").parse(apod.date);
    var displayDate = DateFormat("MMM dd, yyyy").format(apodDate);
    return Text(displayDate);
  }

  void shareLink() {
    var url = apod.hdurl;
    url ??= apod.url;
    Share.share(
      """${apod.explanation}
      
       View it here -> $url""",
      subject: apod.title!,
    );
  }

  void downloadImage() async {
    var url = apod.hdurl;
    if (url == null) return;
    HttpClient httpClient = HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    if(response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      FileSaver.instance.saveFile(name: apod.title!, bytes: bytes);
    }
  }
}
