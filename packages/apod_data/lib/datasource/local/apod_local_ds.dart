import 'package:apod_data/model/apod.dart';

abstract class ApodLocalDataSource {
  Future<APOD?> getApodByDate(String date);

  Future<void> saveApod(APOD apod);

  Future<void> saveApods(List<APOD> apods);

  Stream<List<APOD>> getAllApods();

  void close();
}
