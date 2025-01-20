import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> blocProviders = [
  BlocProvider(create: (BuildContext context) => AuthenticationCubit()),
  BlocProvider(create: (BuildContext context) => SettingsCubit()),
];
