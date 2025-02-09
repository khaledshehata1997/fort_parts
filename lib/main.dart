import 'package:api_services/api_services.dart';
import 'package:components/components.dart';
import 'package:data_access/data_access.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fort_parts/bloc_observer.dart';
import 'package:fort_parts/bloc_providers.dart';
import 'package:fort_parts/firebase_options.dart';
import 'package:fort_parts/generated/codegen_loader.g.dart';
import 'package:fort_parts/view/splash_screen/splash_view.dart';
import 'package:get/get.dart';
import 'package:local_storage/local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initDependencyInjection();
  await HiveHelper.init();
  await SharedPreferenceHelper.init();
  await ApiServices.init();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());

  SharedPreferenceHelper.sharedKeysDispose();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Phoenix(
      child: EasyLocalization(
        startLocale: const Locale('ar'),
        supportedLocales: const [Locale('ar'), Locale('en')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ar'),
        assetLoader: const CodegenLoader(),
        child: MultiBlocProvider(
          providers: blocProviders,
          child: ScreenUtilInit(
            builder: (cxt, w) => GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus!.unfocus();
              },
              child: GetMaterialApp(
                builder: (context, widget) {
                  ScreenUtil.init(
                    context,
                    designSize: const Size(375, 812),
                    minTextAdapt: true,
                    splitScreenMode: true,
                  );
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaler: const TextScaler.linear(1.0),
                    ),
                    child: Overlay(
                      initialEntries: <OverlayEntry>[
                        OverlayEntry(
                          builder: (BuildContext ctx) {
                            return widget!;
                          },
                        ),
                      ],
                    ),
                  );
                },
                debugShowCheckedModeBanner: false,
                title: 'fort parts',
                theme: ThemeData(
                  scaffoldBackgroundColor: AppColors.fFBFBFB,
                  colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
                navigatorKey: NavigationService.navigatorKey,
                home: SplashScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
