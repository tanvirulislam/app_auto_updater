import 'package:auto_updater/auto_updater.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:preference_list/preference_list.dart';
import 'package:window_manager/window_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with UpdaterListener {
  final String _feedURL =
      'https://raw.githubusercontent.com/tanvirulislam/app_auto_updater/refs/heads/main/apcast.xml';

  bool isFeedURLSetted = false;
  String? appVersion;
  @override
  void initState() {
    autoUpdater.addListener(this);
    getAppVersion();
    super.initState();
  }

  Future<void> getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  void dispose() {
    autoUpdater.removeListener(this);
    super.dispose();
  }

  Future<void> handleClickSetFeedURL() async {
    await autoUpdater.setFeedURL(_feedURL);
    isFeedURLSetted = true;
  }

  Future<void> _handleClickCheckForUpdates() async {
    await autoUpdater.setFeedURL(_feedURL);
    await autoUpdater.checkForUpdates();
  }

  Future<void> handleClickCheckForUpdatesWithoutUI() async {
    await autoUpdater.checkForUpdates(inBackground: true);
  }

  Future<void> handleClickSetScheduledCheckInterval() async {
    await autoUpdater.setScheduledCheckInterval(3600);
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: <Widget>[
        PreferenceListSection(
          children: [
            PreferenceListItem(
              title: const Text('setFeedURL'),
              detailText: Text(_feedURL),
              onTap: () => handleClickSetFeedURL(),
            ),
            PreferenceListItem(
              title: const Text('checkForUpdates'),
              onTap: () => _handleClickCheckForUpdates(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Version ${appVersion ?? ''}"),
      ),
      body: _buildBody(context),
    );
  }

  @override
  void onUpdaterError(UpdaterError? error) {
    if (kDebugMode) {
      print('onUpdaterError: $error');
    }
  }

  @override
  void onUpdaterCheckingForUpdate(Appcast? appcast) {
    if (kDebugMode) {
      print('onUpdaterCheckingForUpdate: ${appcast?.toJson()}');
    }
  }

  @override
  void onUpdaterUpdateAvailable(AppcastItem? item) {
    if (kDebugMode) {
      print('onUpdaterUpdateAvailable: ${item?.toJson()}');
    }
  }

  @override
  void onUpdaterUpdateNotAvailable(UpdaterError? error) {
    if (kDebugMode) {
      print('onUpdaterUpdateNotAvailable: $error');
    }
  }

  @override
  void onUpdaterUpdateDownloaded(AppcastItem? item) {
    if (kDebugMode) {
      print('onUpdaterUpdateDownloaded: ${item?.toJson()}');
    }
  }

  @override
  void onUpdaterBeforeQuitForUpdate(AppcastItem? item) {
    if (kDebugMode) {
      print('onUpdaterBeforeQuitForUpdate: ${item?.toJson()}');
    }
    windowManager.setPreventClose(false);
  }
}
