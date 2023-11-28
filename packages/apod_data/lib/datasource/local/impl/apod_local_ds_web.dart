import 'dart:async';
import 'dart:developer';

import 'package:apod_data/datasource/local/apod_local_ds.dart';
import 'package:apod_data/model/apod.dart';

class ApodLocalDataSourceWeb extends ApodLocalDataSource {
  List<APOD> apods = [];
  StreamController<List<APOD>> apodStream = StreamController<List<APOD>>();

  @override
  Stream<List<APOD>> getAllApods() {
    _getAllApods();
    return apodStream.stream;
  }

  @override
  Future<APOD?> getApodByDate(String date) async {
    try {
      return apods.firstWhere((element) => element.date == date);
    } on StateError {
      return null;
    }
  }

  @override
  Future<void> saveApod(APOD apod) async {
    apods.add(apod);
    _getAllApods();
  }

  @override
  Future<void> saveApods(List<APOD> apods) async {
    log("Saving apods : $apods");
    this.apods.addAll(apods);
    _getAllApods();
  }

  @override
  void close() {
    apodStream.close();
  }

  //singletong impl
  static final ApodLocalDataSourceWeb _instance = ApodLocalDataSourceWeb._internal();
  factory ApodLocalDataSourceWeb() {
    return _instance;
  }
  ApodLocalDataSourceWeb._internal();

  _getAllApods() {
    apodStream.add(apods);
  }
}
