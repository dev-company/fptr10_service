import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:fptr10_service/data/elements/fptr_text_element.dart';
import 'package:fptr10_service/data/elements/fptr_barcode_element.dart';
import 'package:fptr10_service/data/elements/fptr_pixels_element.dart';
import 'package:fptr10_service/data/elements/fptr_fiscal_item_element.dart';
import 'package:fptr10_service/data/elements/fptr_fiscal_payment_element.dart';
import 'package:fptr10_service/data/elements/fptr_picture_mem_element.dart';
import 'package:fptr10_service/data/elements/fptr_element_enums.dart';
import 'package:fptr10_service/data/status/fptr_status.dart';

import 'package:fptr10_service/fptr10_service.dart';
import 'package:fptr10_service/fptr10_service_tasks.dart';
import 'package:fptr10_service/tasks/fptr_json_task.dart';
import 'package:fptr10_service/tasks/fptr_task_enums.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController ipcontroller =
      TextEditingController(text: '192.168.1.2');
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => initPlatformState());
  }

  Future<void> initPlatformState() async {
    String platformVersion;

    try {
      platformVersion = await Fptr10Service.driverVersion ??
          'Неизвестная версия драйвера АТОЛ';
    } on PlatformException {
      platformVersion = 'Не удалось загрузить версию платформы.';
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
          title: Text('Example app. ATOL: $_platformVersion\n'),
        ),
        body: ListView(
          children: [
            TextFormField(controller: ipcontroller),
            // connection
            TextButton.icon(
              onPressed: () async {
                await Fptr10Service.setupSettings(ipcontroller.text, 5555);
                await Fptr10Service.close();
                await Fptr10Service.open();
              },
              icon: const Icon(Icons.settings),
              label: const Text('Применить настройки и подключиться'),
            ),
            TextButton.icon(
              onPressed: () => Fptr10Service.open(),
              icon: const Icon(Icons.cell_wifi_outlined),
              label: const Text('Соединить'),
            ),
            TextButton.icon(
              onPressed: () => Fptr10Service.close(),
              icon: const Icon(Icons.signal_cellular_nodata_rounded),
              label: const Text('Разъединить'),
            ),
            TextButton.icon(
              onPressed: () async {
                FptrStatus status = await Fptr10Service.status;
                debugPrint(status.toString());
              },
              icon: const Icon(Icons.info_outline),
              label: const Text('Статус'),
            ),
            // shift actions
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
            // fiscal actions
            TextButton(
              onPressed: () {
                Map<String, dynamic> task = FptrJsonTask.fiscal(
                  type: FptrFiscalType.sell,
                  total: 146,
                  items: [
                    FptrFiscalItemElement(
                      name: "Бананы",
                      price: 73.15,
                      quantity: 2,
                      amount: 146.3,
                      infoDiscountAmount: 10.0,
                      measurementUnit: FptrMeasurementUnit.kilogram,
                      paymentObject: FptrPaymentObject.commodity,
                    ),
                  ],
                  payments: [
                    FptrFiscalPaymentElement(
                      type: FptrPaymentType.cash,
                      sum: 146,
                    ),
                  ],
                );
                dynamic result =
                    Fptr10ServiceTasks.sendTaskWithParsedResponse(task);

                debugPrint(result.toString());
              },
              child: const Text('Чек покупки (прихода)'),
            ),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = FptrJsonTask.fiscal(
                    type: FptrFiscalType.sellReturn,
                    total: 73,
                    items: [
                      FptrFiscalItemElement(
                        name: "Бананы",
                        price: 73.15,
                        quantity: 1,
                        amount: 73.15,
                        infoDiscountAmount: 0.0,
                        measurementUnit: FptrMeasurementUnit.kilogram,
                        paymentObject: FptrPaymentObject.commodity,
                      ),
                    ],
                    payments: [
                      FptrFiscalPaymentElement(
                        type: FptrPaymentType.cash,
                        sum: 73,
                      ),
                    ],
                  );
                  Fptr10ServiceTasks.sendTaskWithResponse(task);
                },
                child: const Text('Чек возврата (прихода)')),

            // nonfiscal actions
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = FptrJsonTask.nonFiscal(
                    items: [
                      FptrTextElement(
                          text: 'Строка 1',
                          alignment: FptrElementAlignment.left),
                      FptrTextElement(text: 'Строка 2'),
                      FptrTextElement(
                          text: 'Строка 3',
                          alignment: FptrElementAlignment.right),
                    ],
                  );
                  Fptr10ServiceTasks.sendTask(task);
                },
                child: const Text('Печать текста')),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = FptrJsonTask.nonFiscal(
                    items: [
                      FptrBarcodeElement(
                        barcode: '[01]98898765432106[3202]012345[15]991231',
                        barcodeType: FptrBarcodeType.GS1_128,
                        scale: 1,
                      )
                    ],
                  );
                  Fptr10ServiceTasks.sendTask(task);
                },
                child: const Text('Печать GS1_128')),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = FptrJsonTask.nonFiscal(
                    items: [
                      FptrBarcodeElement(
                        barcode:
                            'https://check.egais.ru?id=cf1b1096-3cbc-11e7-b3c1-9b018b2ba3f7',
                        barcodeType: FptrBarcodeType.QR,
                        scale: 4,
                        alignment: FptrElementAlignment.left,
                      ),
                      FptrTextElement(
                          text: 'Строка 1',
                          alignment: FptrElementAlignment.left),
                      FptrTextElement(text: 'Строка 2'),
                      FptrTextElement(
                          text: 'Строка 3',
                          alignment: FptrElementAlignment.right),
                    ],
                  );
                  Fptr10ServiceTasks.sendTask(task);
                },
                child: const Text('Печать QR')),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = FptrJsonTask.nonFiscal(
                    items: [
                      FptrPixelsElement(
                        pixels: '/////////wAAAAD//wAAAAD/////////',
                        width: 6,
                        scale: 1000,
                      )
                    ],
                  );
                  Fptr10ServiceTasks.sendTask(task);
                },
                child: const Text('Печать пикселей')),
            TextButton(
                onPressed: () {
                  Map<String, dynamic> task = FptrJsonTask.nonFiscal(
                    items: [
                      FptrPictureMemElement(
                        pictureNumber: 1,
                      )
                    ],
                  );
                  Fptr10ServiceTasks.sendTask(task);
                },
                child: const Text('Печать из памяти')),
          ],
        ),
      ),
    );
  }

  List<Widget> exampleActions = nonFiscalActions;
}

List<Widget> nonFiscalActions = [];
