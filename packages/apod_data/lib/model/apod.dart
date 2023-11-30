class APOD {
  final String date;
  final String? title;
  final String? url;
  final String? explanation;
  final String? hdurl;
  final String? mediaType;

  APOD({
    required this.date,
    required this.title,
    required this.url,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
  });

  factory APOD.fromJson(Map<String, dynamic> json) {
    return APOD(
      date: json['date'] as String,
      title: json['title'],
      url: json['url'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      mediaType: json['media_type'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'title': title,
      'url': url,
      'explanation': explanation,
      'hdurl': hdurl,
      'media_type': mediaType,
    };
  }

  @override
  String toString() {
    return "APOD('date' : $date, 'title' : $title,   'url' : $url,'explanation' : $explanation,'hdurl' : $hdurl,'media_type' : $mediaType,)";
  }

  static const MEDIA_TYPE_IMAGE = "image";
  static const MEDIA_TYPE_VIDEO = "video";
}
