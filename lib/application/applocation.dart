
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:huaxia/config/config.dart';

import 'book_config/init_binding.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      theme: AppTheme.theme,
      title: '华夏国学',
      getPages: AppRouters.routers,
      initialRoute: Routers.Initial,
      builder: BotToastInit(),
      initialBinding: InitBinding(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      navigatorObservers: [
        BotToastNavigatorObserver()
      ],
      supportedLocales: const [
         Locale('en'),
         Locale('zh'),
      ],
    );
  }
}
