import 'package:appfactorytest/core/cache_helper/cache_helper.dart';
import 'package:appfactorytest/core/routing/app_router.dart';
import 'package:appfactorytest/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  CacheHelper.init();

  runApp(MyApp(appRouter: AppRouter()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      designSize: const Size(390, 844),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: CacheHelper.initialRoute(),
        onGenerateRoute: appRouter.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
