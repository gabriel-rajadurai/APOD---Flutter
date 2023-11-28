import 'package:apod_data/datasource/local/apod_local_ds.dart';
import 'package:apod_data/datasource/local/impl/apod_local_ds_impl.dart';
import 'package:apod_data/datasource/local/impl/apod_local_ds_web.dart';
import 'package:apod_data/datasource/remote/apod_remote_ds.dart';
import 'package:apod_data/model/apod.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class ApodRepo {
  late final ApodLocalDataSource _apodLocalDataSource = getLocalDataSource();
  final ApodRemoteDataSource _apodRemoteDataSource = ApodRemoteDataSource();

  Future<APOD> fetchApodOfTheDay() async {
    var today = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var apodLocal = await _apodLocalDataSource.getApodByDate(today);
    if (apodLocal != null) {
      return apodLocal;
    }
    var apodRemote = await _apodRemoteDataSource.fetchApodOfTheDay();
    _apodLocalDataSource.saveApod(apodRemote);
    return apodRemote;
  }

  Stream<List<APOD>> getAllApods() {
    return _apodLocalDataSource.getAllApods();
  }

  Future<List<APOD>> fetchAstronomyPictures() async {
    var startDate = DateFormat("yyyy-MM-dd")
        .format(DateTime.now().subtract(const Duration(days: 30)));
    var endDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
    var apods =
        await _apodRemoteDataSource.fetchAstronomyPictures(startDate, endDate);
    _apodLocalDataSource.saveApods(apods);
    return apods;
  }

  void close() {
    _apodLocalDataSource.close();
  }

  ApodLocalDataSource getLocalDataSource() {
    if (kIsWeb) {
      return ApodLocalDataSourceWeb();
    } else {
      return ApodLocalDataSourceImpl();
    }
  }
}
