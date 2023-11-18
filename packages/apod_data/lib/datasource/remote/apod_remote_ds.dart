import 'dart:convert';

import 'package:apod_data/model/apod.dart';
import 'package:http/http.dart';

class ApodRemoteDataSource {
  Future<APOD> fetchApodOfTheDay() async {
    // Uri.https('api.nasa.gov/planetary','apod',[
    //   'api_key' : ''
    // ])
    final response = await get(Uri.parse(
        "https://api.nasa.gov/planetary/apod?api_key=wRhfrDUOQf53z2UvpadrP3qmNNhSxx0Wjlv5HhFQ"));
    if (response.statusCode == 200) {
      return APOD.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to fetch Apod");
    }
  }

  Future<List<APOD>> fetchAstronomyPictures(
      String fromDate, String endDate) async {
    final response = await get(Uri.parse(
        "https://api.nasa.gov/planetary/apod?api_key=wRhfrDUOQf53z2UvpadrP3qmNNhSxx0Wjlv5HhFQ&start_date=$fromDate&end_date=$endDate"));

    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List<dynamic>)
          .map((apodJson) => APOD.fromJson(apodJson))
          .toList();
    } else {
      throw Exception("Failed to fetch Apod list");
    }
  }
}
