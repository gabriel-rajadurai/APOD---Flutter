import 'dart:async';

import 'package:apod_data/model/apod.dart';
import 'package:apod_data/repo/apod_repo.dart';
import 'package:apod_flutter/bloc/bloc.dart';

class ApodListBloc implements Bloc {
  final ApodRepo _apodRepo = ApodRepo();
  late Stream<List<APOD>?> apodStream;

  ApodListBloc() {
    _apodRepo.fetchAstronomyPictures();
     apodStream = _apodRepo.getAllApods();
  }

  @override
  void dispose() {
    _apodRepo.close();
  }
}
