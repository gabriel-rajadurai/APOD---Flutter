class APOD {
  final String date;
  final String? title;
  final String? url;
  final String? explanation;
  final String? hdurl;
  final String? media_type;

  APOD({
    required this.date,
    required this.title,
    required this.url,
    required this.explanation,
    required this.hdurl,
    required this.media_type,
  });

  factory APOD.fromJson(Map<String, dynamic> json) {
    return APOD(
      date: json['date'] as String,
      title: json['title'],
      url: json['url'],
      explanation: json['explanation'],
      hdurl: json['hdurl'],
      media_type: json['media_type'],
    );
  }
}
