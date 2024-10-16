import 'package:app_auto_updater/home.dart';
import 'package:auto_updater/auto_updater.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();

  // String feedURL = 'https://raw.githubusercontent.com/larryaasen/upgrader/master/test/testappcast.xml';
  // await autoUpdater.setFeedURL(feedURL);
  // await autoUpdater.checkForUpdates();
  // await autoUpdater.setScheduledCheckInterval(3600);

  windowManager.waitUntilReadyToShow(null, () async {
    // await windowManager.setPreventClose(true);
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xff416ff4),
        canvasColor: Colors.white,
        scaffoldBackgroundColor: const Color(0xffF7F9FB),
        dividerColor: Colors.grey.withOpacity(0.3),
      ),
      // theme: ThemeData.dark(),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomePage(),
    );
  }
}
