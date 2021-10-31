// ignore_for_file: constant_identifier_names

enum FptrBarcodeType {
  EAN8,
  EAN13,
  UPCA,
  UPCE,
  CODE39,
  CODE93,
  CODE128,
  CODABAR,
  ITF,
  ITF14,
  GS1_128,
  PDF417,
  QR,
  CODE39_EXTENDED,
}
enum FptrElementAlignment { left, center, right }
enum FptrTextWrap { none, chars, words }

enum FptrElementType {
  position,
  text,
  barcode,
  userAttribute,
  additionalAttribute,
  pictureFromMemory,
  pixels
}

/// Для ФФД 1.2
enum FptrMeasurementUnit {
  piece, // 0 - штуки, единицы;
  gram, // 10 – грамм;
  kilogram, // 11 – килограмм;
  ton, // 12 – тонна;
  centimeter, // 20 - сантиметр;
  decimeter, // 21 – дециметр;
  meter, // 22 - метр;
  squareCentimeter, // 30 - квадратный сантиметр;
  squareDecimeter, // 31 - квадратный дециметр;
  squareMeter, // 32 - квадратный метр;
  milliliter, // 40 – миллилитр;
  liter, // 41 – литр;
  cubicMeter, // 42 – кубический метр;
  kilowattHour, // 50 – киловатт час;
  gkal, // 51 – гигакалория;
  day, // 70 – сутки (день);
  hour, // 71 - час;
  minute, // 72 – минута;
  second, // 73 – секунда;
  kilobyte, // 80 – килобайт;
  megabyte, // 81 – мегабайт;
  gigabyte, // 82 – гигабайт;
  terabyte, // 83 – терабайт;
  otherUnits, // 255 – иные единицы измерения;
}

enum FptrPaymentType {
  cash, // или 0 - наличными
  electronically, // или 1 - безналичными
  prepaid, // или 2 - предварительная оплата (аванс)
  credit, // или 3 - последующая оплата (кредит)
  other, // или 4 - иная форма оплаты (встречное предоставление)
  // NOT_SUPPORTED 5-9 - пользовательский тип оплаты
}

enum FptrPaymentMethod {
  fullPrepayment, // - предоплата 100%
  prepayment, // - предоплата
  advance, // - аванс
  fullPayment, // - полный расчет
  partialPayment, // - частичный расчет и кредит
  credit, // - передача в кредит
  creditPayment, // - оплата кредита
}

enum FptrPaymentObject {
  commodity, // или 1 - товар
  excise, // или 2 - подакцизный товар
  job, // или 3 - работа
  service, // или 4 - услуга
  gamblingBet, // или 5 - ставка азартной игры
  gamblingPrize, // или 6 - выигрыш азартной игры
  lottery, // или 7 - лотерейный билет
  lotteryPrize, // или 8 - выигрыш лотереи
  intellectualActivity, // или 9 - предоставление результатов интеллектуальной деятельности
  payment, // или 10 - платеж
  agentCommission, // или 11 - агентское вознаграждение
  composite, // (устаревшее) или pay или 12 - выплата
  another, // или 13 - иной предмет расчета
  proprietaryLaw, // или 14 - имущественное право
  nonOperatingIncome, // или 15 - внереализационный доход
  insuranceContributions, // (устаревшее) или otherContributions или 16 - иные платежи и взносы/страховые взносы
  merchantTax, // или 17 - торговый сбор
  resortFee, // или 18 - курортный сбор
  deposit, // или 19 - залог
  consumption, // или 20 - расход
  soleProprietorCPIContributions, // или 21 - взносы на ОПС ИП
  cpiContributions, // или 22 - взносы на ОПС
  soleProprietorCMIContributions, // или 23 - взносы на ОМС ИП
  cmiContributions, // или 24 - взносы на ОМС
  csiContributions, // или 25 - взносы на ОСС
  casinoPayment, // или 26 - платеж казино
  fundsIssuance, // или 27 - выдача денежных средств
  exciseWithoutMarking, // или 30 - подакцизный товар, не имеющий код маркировки
  exciseWithMarking, // или 31 - подакцизный товар, имеющий код маркировки
  commodityWithoutMarking, // или 32 - товар, не имеющий код маркировки
  commodityWithMarking, // или 33 - товар, имеющий код маркировки

}
