import 'dart:developer';
import 'dart:io';

import 'package:apod_data/model/apod.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart' as filepaths;

class ApodDescription extends StatefulWidget {
  final APOD apod;
  final VoidCallback openApod;

  const ApodDescription(
      {super.key, required this.apod, required this.openApod});

  @override
  State<ApodDescription> createState() => _ApodDescriptionState();
}

class _ApodDescriptionState extends State<ApodDescription> {
  bool isDownloading = false;
  static const platform = MethodChannel("apod.gabriel.com/openFile");

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
              widget.apod.explanation.toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: widget.openApod,
                  icon: const Icon(Icons.open_in_new),
                ),
                IconButton(
                  onPressed: () {
                    shareLink();
                  },
                  icon: const Icon(Icons.share),
                ),
                Visibility(
                  visible: !kIsWeb && widget.apod.mediaType == APOD.MEDIA_TYPE_IMAGE,
                  child: isDownloading
                      ? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: SizedBox.square(
                            dimension: 24.0,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            downloadImage((filePath) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text("Image downloaded"),
                                action: SnackBarAction(
                                  label: "Open",
                                  onPressed: () async {
                                    var fileUri = Uri.file(filePath);
                                    if (await canLaunchUrl(fileUri)) {
                                      await launchUrl(Uri.file(filePath));
                                    } else {
                                      await platform.invokeMethod(
                                          "viewFile", filePath);
                                    }
                                  },
                                ),
                              ));
                            });
                          },
                          icon: const Icon(Icons.download),
                        ),
                ),
              ],
            )
          ],
        ));
  }

  Text dateWidget() {
    var apodDate = DateFormat("yyyy-MM-dd").parse(widget.apod.date);
    var displayDate = DateFormat("MMM dd, yyyy").format(apodDate);
    return Text(displayDate);
  }

  void shareLink() {
    var url = widget.apod.hdurl;
    url ??= widget.apod.url;
    Share.share(
      """${widget.apod.explanation}
      
       View it here -> $url""",
      subject: widget.apod.title!,
    );
  }

  void downloadImage(Function(String) onDownloaded) async {
    var url = widget.apod.hdurl;
    if (url == null) return;
    setState(() {
      isDownloading = true;
    });

    var fileName = widget.apod.title!.replaceAll(RegExp("[^A-Za-z0-9]"), "");
    var fileExt = "jpeg";
    String downloadedFilePath;

    var filesDir = await _getDirectory();
    log("Files Dir - $filesDir");
    File? imageFile;
    if (filesDir != null) {
      imageFile = File("$filesDir/$fileName.jpeg");
    }
    log("imageFile - $imageFile");
    if (imageFile == null || !(await imageFile.exists())) {
      downloadedFilePath = await FileSaver.instance.saveFile(
        name: fileName,
        link: LinkDetails(link: url),
        ext: fileExt,
      );
    } else {
      downloadedFilePath = imageFile.path;
    }
    log("Saved file path : $downloadedFilePath");
    setState(() {
      isDownloading = false;
    });
    onDownloaded(downloadedFilePath);
  }

  static Future<String?> _getDirectory() async {
    String? path;
    try {
      if (Platform.isAndroid) {
        path = (await filepaths.getExternalStorageDirectory())?.path;
      } else if (Platform.isIOS) {
        path = (await filepaths.getApplicationDocumentsDirectory()).path;
      } else {
        path = (await filepaths.getDownloadsDirectory())?.path;
      }
    } on Exception catch (e) {
      log('Something wemt worng while getting directories');
      log(e.toString());
    }
    return path;
  }
}
