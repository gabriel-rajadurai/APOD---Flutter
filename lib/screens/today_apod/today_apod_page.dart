import 'package:apod_data/model/apod.dart';
import 'package:apod_data/repo/apod_repo.dart';
import 'package:apod_flutter/bloc/bloc_provider.dart';
import 'package:apod_flutter/screens/commons/apod_image.dart';
import 'package:apod_flutter/screens/commons/progress_indicator.dart';
import 'package:apod_flutter/screens/today_apod/today_apod.dart';
import 'package:apod_flutter/screens/today_apod/today_apod_bloc.dart';
import 'package:flutter/material.dart';

class TodayApodPage extends StatefulWidget {
  const TodayApodPage({super.key});

  @override
  State<TodayApodPage> createState() => _TodayApodPageState();
}

class _TodayApodPageState extends State<TodayApodPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: TodayApodBloc(),
      child: const TodayApod(),
    );
  }
}
