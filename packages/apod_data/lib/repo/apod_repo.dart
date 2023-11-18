import 'package:apod_data/datasource/local/apod_local_ds.dart';
import 'package:apod_data/datasource/remote/apod_remote_ds.dart';
import 'package:apod_data/model/apod.dart';
import 'package:intl/intl.dart';

class ApodRepo {
  ApodLocalDataSource _apodLocalDataSource = ApodLocalDataSource();
  ApodRemoteDataSource _apodRemoteDataSource = ApodRemoteDataSource();

  Future<APOD> fetchApodOfTheDay() {
    return _apodRemoteDataSource.fetchApodOfTheDay();
  }

  Future<List<APOD>> fetchAstronomyPictures() {
    var startDate = DateFormat("yyyy-MM-dd").format(DateTime.now().subtract(const Duration(days: 30)));
    var endDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    return _apodRemoteDataSource.fetchAstronomyPictures(
      startDate,
      endDate
    );
  }
}