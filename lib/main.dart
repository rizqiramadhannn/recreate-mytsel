import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/routes/app_pages.dart';
import 'app/widgets/splash_screen.dart';
import 'i18n/AppTranslation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translationsKeys: AppTranslation.translationsKeys,
      locale: Get.deviceLocale,
      title: "Application",
      initialRoute: Routes.HOME,
      getPages: AppPages.routes,
    );
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3)),
        builder: (context, snapshot) {
          if ((snapshot.connectionState == ConnectionState.waiting)) {
            return SplashScreen();
          } else {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: "Application",
              initialRoute: Routes.LOGIN,
              getPages: AppPages.routes,
            );
          }
        });
  }
}
