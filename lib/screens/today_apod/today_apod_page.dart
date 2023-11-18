import 'package:apod_flutter/bloc/bloc_provider.dart';
import 'package:apod_flutter/screens/today_apod/today_apod.dart';
import 'package:apod_flutter/screens/today_apod/today_apod_bloc.dart';
import 'package:flutter/material.dart';

class TodayApodPage extends StatelessWidget {
  const TodayApodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: TodayApodBloc(),
      child: const TodayApod(),
    );
  }
}
