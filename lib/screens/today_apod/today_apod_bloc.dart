import 'dart:async';

import 'package:apod_data/model/apod.dart';
import 'package:apod_data/repo/apod_repo.dart';
import 'package:apod_flutter/bloc/bloc.dart';

class TodayApodBloc implements Bloc {
  final ApodRepo _apodRepo = ApodRepo();
  final _apodStreamController = StreamController<bool>();
  late Stream<APOD?> apodStream;

  TodayApodBloc() {
    apodStream = _apodStreamController.stream.asyncMap((event) => _apodRepo.fetchApodOfTheDay());
    _apodStreamController.sink.add(true);
  }

  @override
  void dispose() {
    _apodStreamController.close();
  }
}
