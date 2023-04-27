import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'ResourcePage.dart';
import 'resource_bloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ResourceBloc>(
          create: (context) => ResourceBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Resources App',
        home: Provider<ResourceBloc>(
          create: (context) => ResourceBloc(),
          child: Resourcepage(),
        ),
      ),
    );
  }
}
