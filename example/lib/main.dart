import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fptr10_service/fptr10_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await Fptr10Service.driverVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            Text('Running on: $_platformVersion\n'),
            TextButton.icon(
              onPressed: () =>
                  Fptr10Service.setupSettings('192.168.0.112', 5555),
              icon: const Icon(Icons.settings),
              label:
                  const Text('Задать настройки подключения 192.168.0.112:5555'),
            ),
            IconButton(
                onPressed: () => Fptr10Service.isOpened(),
                icon: const Icon(Icons.open_in_new)),
            IconButton(
                onPressed: () => Fptr10Service.open(),
                icon: const Icon(Icons.cell_wifi_outlined)),
            IconButton(
                onPressed: () => Fptr10Service.close(),
                icon: const Icon(Icons.close)),
            IconButton(
                onPressed: () => Fptr10Service.settings,
                icon: const Icon(Icons.print)),
          ],
        ),
      ),
    );
  }
}
