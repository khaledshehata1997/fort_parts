import 'package:api_services/api_services.dart';
import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fort_parts/bloc_observer.dart';
import 'package:fort_parts/bloc_providers.dart';
import 'package:fort_parts/view/splash_screen/splash_view.dart';
import 'package:get/get.dart';
import 'package:local_storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencyInjection();
  await ApiServices.init();
  await HiveHelper.init();
  await SharedPreferenceHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());

  SharedPreferenceHelper.sharedKeysDispose();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus!.unfocus();
        },
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'fort parts',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorKey: NavigationService.navigatorKey,
          home: SplashView(),
        ),
      ),
    );
  }
}
