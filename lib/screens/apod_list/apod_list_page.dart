import 'package:apod_flutter/bloc/bloc_provider.dart';
import 'package:apod_flutter/screens/apod_list/apod_list.dart';
import 'package:apod_flutter/screens/apod_list/apod_list_bloc.dart';
import 'package:flutter/material.dart';

class ApodListPage extends StatelessWidget {
  const ApodListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(bloc: ApodListBloc(), child: const ApodList()));
  }
}
