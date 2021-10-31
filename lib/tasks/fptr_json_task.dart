import 'package:fptr10_service/data/elements/fptr_barcode_element.dart';
import 'package:fptr10_service/data/elements/fptr_fiscal_item_element.dart';
import 'package:fptr10_service/data/elements/fptr_fiscal_payment_element.dart';
import 'package:fptr10_service/data/elements/fptr_picture_mem_element.dart';
import 'package:fptr10_service/data/elements/fptr_pixels_element.dart';
import 'package:fptr10_service/data/elements/fptr_text_element.dart';
import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_task_enums.dart';

class FptrJsonTask {
  // NOT_SUPPORTED: Регистрация/перерегистрация ККТ
  // NOT_SUPPORTED: Закрытие ФН
  // NOT_SUPPORTED: Запись настроек ККТ

  /// Открытие смены
  static final Map<String, dynamic> openShift = {'type': 'openShift'};

  /// Закрытие смены. Отчёт с гашением ( Z-отчёт)
  static final Map<String, dynamic> closeShift = {'type': 'closeShift'};

  /// X-отчёт. Отчёт без гашения
  static final Map<String, dynamic> reportX = {'type': 'reportX'};

  /// Z-отчёт. Отчёт с гашением (закрытие смены)
  static final Map<String, dynamic> reportZ = FptrJsonTask.closeShift;

  /// Печать документа из ФН по номеру
  /// [number] – номер документа
  static Map<String, dynamic> printFnDocument(int number) {
    return {'type': 'printFnDocument', 'fiscalDocumentNumber': number};
  }

  /// Печать документов из БД документов
  /// [isShift] по сменам? Если false, то печать будет по номерам документов
  ///
  /// [from] – начало
  /// [to] – конец диапазона выгрузки.
  static Map<String, dynamic> printDocumentsFromJournal(
      bool isShift, int from, int to) {
    return {
      'type': 'printDocumentsFromJournal',
      'filter': isShift ? 'shiftNumber' : 'fiscalDocumentNumber',
      'from': from,
      'to': to,
    };
  }

  /// Допечатать документ
  static final Map<String, dynamic> continuePrint = {'type': 'continuePrint'};

  /// Печать копии последнего чека
  static final Map<String, dynamic> printLastReceiptCopy = {
    'type': 'printLastReceiptCopy'
  };

  //_______________________________
  // Действия с оборудованием
  /// Открыть денежный ящик
  static final Map<String, dynamic> openCashDrawer = {'type': 'openCashDrawer'};

  //_______________________________
  // Параметры и состояния

  /// Запрос состояния денежного ящика
  static final Map<String, dynamic> getCashDrawerStatus = {
    'type': 'getCashDrawerStatus'
  };

  /// Запрос введенных в ККТ лицензий/кодов защиты
  static final Map<String, dynamic> getLicenses = {'type': 'getLicenses'};

  /// Запрос параметров регистрации
  static final Map<String, dynamic> getRegistrationInfo = {
    'type': 'getRegistrationInfo'
  };

  /// Запрос информации о ФН
  static final Map<String, dynamic> getFnInfo = {'type': 'getFnInfo'};

  /// Запрос состояния о ФН
  static final Map<String, dynamic> getFnStatus = {'type': 'getFnStatus'};

  /// Отчёт о состоянии расчетов
  static final Map<String, dynamic> reportOfdExchangeStatus = {
    'type': 'reportOfdExchangeStatus'
  };

  /// Отчет по секциям
  static final Map<String, dynamic> reportDepartments = {
    'type': 'reportDepartments'
  };

  /// Запрос состояния смены
  static final Map<String, dynamic> getShiftStatus = {'type': 'getShiftStatus'};

  /// Запрос сменных итогов
  static final Map<String, dynamic> getShiftTotals = {'type': 'getShiftTotals'};

  /// Запрос необнуляемых итогов
  static final Map<String, dynamic> getOverallTotals = {
    'type': 'getOverallTotals'
  };

  /// Нефискальные документы
  ///
  /// [items] – массив элементов документа ([FptrTextElement], [FptrBarcodeElement], [FptrPictureMemElement])
  ///
  /// printFooter – печать подвала. По умолчанию – true.
  static Map<String, dynamic> nonFiscal(
      {required List<Object> items, printFooter = true}) {
    return {
      'type': 'nonFiscal',
      'items': items.map((dynamic e) => e.toMap()).toList(),
      'printFooter': printFooter,
    };
  }

  // TODO: Фискальные чеки
  static Map<String, dynamic> fiscal({
    required FptrFiscalType type,
    bool ignoreNonFiscalPrintErrors = false,
    bool electronically = false,
    FptrTaxationType? taxationType,
    String? paymentsPlace,
    String? paymentsAddress,
    String? machineNumber,
    // TODO: FptrOperator operator,
    // TODO: FptrClientInfo clientInfo,
    // TODO: FptrCompanyInfo companyInfo,
    // TODO: FptrAgentInfo agentInfo,
    // TODO: FptrSupplierInfo supplierInfo,
    // TODO: FptrOperationInfo operationInfo,
    // TODO: FptrIndustryInfo industryInfo,
    required List<FptrFiscalItemElement> items,
    required List<FptrFiscalPaymentElement> payments,
    // TODO: List<FptrFiscalTaxesElement> taxes,
    double? total,
    List<Object> preItems = const [],
    List<Object> postItems = const [],
    bool? validateMarkingCodes,
  }) {
    Map<String, dynamic> task = {
      'type': EnumUtils.toShortString(type),
      'ignoreNonFiscalPrintErrors': ignoreNonFiscalPrintErrors,
      'electronically': electronically,
      'items': items.map((FptrFiscalItemElement e) => e.toMap()).toList(),
      'payments':
          payments.map((FptrFiscalPaymentElement e) => e.toMap()).toList(),
      // 'taxationType': EnumUtils.toShortString(taxationType),
      'preItems': preItems.map((dynamic e) => e.toMap()).toList(),
      'postItems': postItems.map((dynamic e) => e.toMap()).toList(),
    };

    if (taxationType != null) {
      task['task'] = EnumUtils.toShortString(taxationType);
    }

    if (paymentsPlace != null) {
      task['paymentsPlace'] = paymentsPlace;
    }

    if (paymentsAddress != null) {
      task['paymentsAddress'] = paymentsAddress;
    }

    if (machineNumber != null) {
      task['machineNumber'] = machineNumber;
    }
    if (total != null) {
      task['total'] = total;
    }
    if (validateMarkingCodes != null) {
      task['validateMarkingCodes'] = validateMarkingCodes;
    }

    return task;
  }
  // TODO: Установка даты и времени
  // TODO: Начать проверку КМ
  // TODO: Получить результат проверки КМ
  // TODO: Подтвердить реализацию КМ
  // TODO: Отказаться от реализации КМ
  // TODO: Прервать проверку КМ
  // TODO: Очистить таблицу проверенных КМ ФН-М
  // TODO: Проверить состояние фоновой проверки
  // TODO: Проверка массива КМ
  // TODO: Добавление массива КМ в таблицу проверенных КМ
  // TODO: Чеки коррекции

  /// Запрос состояния работы с КМ
  static final Map<String, dynamic> checkImcWorkState = {
    'type': 'checkImcWorkState'
  };

  /// Запрос состояния обмена с ИСМ
  static final Map<String, dynamic> ismExchangeStatus = {
    'type': 'ismExchangeStatus'
  };

  /// Запрос состояния обмена с ИСМ
  static final Map<String, dynamic> pingIsm = {'type': 'pingIsm'};

  /// Внесение и выплаты
  /// [isCashIn] внесение? Если false, то выплата
  ///
  /// [sum] – сумма
  static Map<String, dynamic> cashInOut(bool isCashIn, double sum) {
    return {'type': isCashIn ? 'cashIn' : 'cashOut', 'cashSum': sum};
  }
}
