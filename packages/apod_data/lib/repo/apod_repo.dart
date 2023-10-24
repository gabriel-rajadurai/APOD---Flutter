import 'package:apod_data/datasource/local/apod_local_ds.dart';
import 'package:apod_data/datasource/remote/apod_remote_ds.dart';
import 'package:apod_data/model/apod.dart';

class ApodRepo {
  ApodLocalDataSource _apodLocalDataSource = ApodLocalDataSource();
  ApodRemoteDataSource _apodRemoteDataSource = ApodRemoteDataSource();

  Future<APOD> fetchApodOfTheDay() {
    return _apodRemoteDataSource.fetchApodOfTheDay();
  }
}