import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:fptr10_service/data/elements/fptr_text_element.dart';
import 'package:fptr10_service/data/status/fptr_status.dart';
import 'package:fptr10_service/fptr10_service.dart';
import 'package:fptr10_service/tasks/fptr_json_task.dart';

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

    WidgetsBinding.instance!.addPostFrameCallback((_) => initPlatformState());
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion =
          await Fptr10Service.driverVersion ?? 'Unknown atol platform version';
    } on PlatformException {
      platformVersion = 'Failed to get atol platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> setupDefaultFptrConnection() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('ATOL plugin example app'),
        ),
        body: ListView(
          children: [
            Text('Running on: $_platformVersion\n'),
            TextButton.icon(
              onPressed: () async {
                await Fptr10Service.setupSettings('192.168.0.112', 5555);
                await Fptr10Service.close();
                await Fptr10Service.open();
              },
              icon: const Icon(Icons.settings),
              label: const Text(
                  'Задать настройки подключения 192.168.0.112:5555 и подключиться'),
            ),
            TextButton.icon(
                onPressed: () {
                  Fptr10Service.statusChannel
                      .receiveBroadcastStream()
                      .listen((event) {
                    FptrStatus status = FptrStatus.fromEvent(event);
                    debugPrint('KKM status: ${status.toSimpleMap()}');
                  });
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text('Начать опрашивать кассу о статусе')),
            TextButton.icon(
              onPressed: () => Fptr10Service.open(),
              icon: const Icon(Icons.cell_wifi_outlined),
              label: const Text('соединить'),
            ),
            TextButton.icon(
              onPressed: () => Fptr10Service.close(),
              icon: const Icon(Icons.cell_wifi_outlined),
              label: const Text('Разъединить'),
            ),
            TextButton(
                onPressed: () {
                  Fptr10ServiceTasks.sendTask(FptrJsonTask.closeShift);
                },
                child: const Text('Закрыть смену')),
            TextButton(
                onPressed: () {
                  Fptr10ServiceTasks.sendTask(FptrJsonTask.openShift);
                },
                child: const Text('Открыть смену')),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = {
                    'type': 'nonFiscal',
                    'items': [
                      FptrTextElement(
                              text: 'Строка 1', alignment: TextAlignment.left)
                          .toMap(),
                      FptrTextElement(text: 'Строка 2').toMap(),
                      FptrTextElement(
                              text: 'Строка 3', alignment: TextAlignment.right)
                          .toMap(),
                    ],
                  };
                  Fptr10ServiceTasks.sendTask(task);
                },
                child: const Text('Печать текста')),
          ],
        ),
      ),
    );
  }
}
