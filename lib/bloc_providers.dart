import 'package:data_access/data_access.dart' as di;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/controllers/address_cubit/address_cubit.dart';
import 'package:fort_parts/controllers/authentication_cubit/authentication_cubit.dart';
import 'package:fort_parts/controllers/cart_cubit/cart_cubit.dart';
import 'package:fort_parts/controllers/coupon_cubit/coupon_cubit.dart';
import 'package:fort_parts/controllers/order_cubit/order_cubit.dart';
import 'package:fort_parts/controllers/settings_cubit/settings_cubit.dart';
import 'package:fort_parts/view/home_layout/home_layout_cubit/home_layout_cubit.dart';
import 'package:fort_parts/view/profile_view/lang/cubit/lang_cubit.dart';
import 'package:fort_parts/view/profile_view/lang/data/data_sources/settings_local_data_source_impl.dart';
import 'package:fort_parts/view/profile_view/lang/data/repositories/setting_repository_impl.dart';
import 'package:fort_parts/view/profile_view/lang/domain/use_cases/settings_change_lang_usecase.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/single_child_widget.dart';
final sl = GetIt.instance;
final List<SingleChildWidget> blocProviders = [
  BlocProvider(create: (BuildContext context) => HomeLayoutCubit()),
  BlocProvider(create: (BuildContext context) => AddressCubit()),
  BlocProvider(create: (BuildContext context) => AuthenticationCubit()),
  BlocProvider(create: (BuildContext context) => CartCubit()..fetchCart()),
  BlocProvider(create: (BuildContext context) => CouponCubit()),
  BlocProvider(create: (BuildContext context) => OrderCubit()),
  BlocProvider(create: (BuildContext context) => SettingsCubit()),
  BlocProvider(create: (BuildContext context) => LangCubit(
      settingsChangeLangUseCase: LangChangeLangUseCase(
      settingRepository: SettingsRepositoryImpl(
          settingsLocalDataSource: SettingsLocalDataSourceImpl())))),
];
