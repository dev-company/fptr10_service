// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fptr_status.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FptrStatus _$$_FptrStatusFromJson(Map<String, dynamic> json) =>
    _$_FptrStatus(
      operatorID: json['operatorID'] as int,
      logicalNumber: json['logicalNumber'] as int,
      shiftState: json['shiftState'] as int? ?? 3,
      modelName: json['modelName'] as String,
      mode: json['mode'] as int,
      submode: json['submode'] as int,
      receiptNumber: json['receiptNumber'] as int,
      documentNumber: json['documentNumber'] as int,
      shiftNumber: json['shiftNumber'] as int,
      receiptType: json['receiptType'] as int,
      documentType: json['documentType'] as int,
      lineLength: json['lineLength'] as int,
      lineLengthPix: json['lineLengthPix'] as int,
      receiptSum: (json['receiptSum'] as num).toDouble(),
      isFiscalDevice: json['isFiscalDevice'] as bool,
      isFiscalFN: json['isFiscalFN'] as bool,
      isFNPresent: json['isFNPresent'] as bool,
      isInvalidFN: json['isInvalidFN'] as bool,
      isCashDrawerOpened: json['isCashDrawerOpened'] as bool,
      isPaperPresent: json['isPaperPresent'] as bool,
      isPaperNearEnd: json['isPaperNearEnd'] as bool,
      isCoverOpened: json['isCoverOpened'] as bool,
      isPrinterConnectionLost: json['isPrinterConnectionLost'] as bool,
      isPrinterError: json['isPrinterError'] as bool,
      isCutError: json['isCutError'] as bool,
      isPrinterOverheat: json['isPrinterOverheat'] as bool,
      isDeviceBlocked: json['isDeviceBlocked'] as bool,
    );

Map<String, dynamic> _$$_FptrStatusToJson(_$_FptrStatus instance) =>
    <String, dynamic>{
      'operatorID': instance.operatorID,
      'logicalNumber': instance.logicalNumber,
      'shiftState': instance.shiftState,
      'modelName': instance.modelName,
      'mode': instance.mode,
      'submode': instance.submode,
      'receiptNumber': instance.receiptNumber,
      'documentNumber': instance.documentNumber,
      'shiftNumber': instance.shiftNumber,
      'receiptType': instance.receiptType,
      'documentType': instance.documentType,
      'lineLength': instance.lineLength,
      'lineLengthPix': instance.lineLengthPix,
      'receiptSum': instance.receiptSum,
      'isFiscalDevice': instance.isFiscalDevice,
      'isFiscalFN': instance.isFiscalFN,
      'isFNPresent': instance.isFNPresent,
      'isInvalidFN': instance.isInvalidFN,
      'isCashDrawerOpened': instance.isCashDrawerOpened,
      'isPaperPresent': instance.isPaperPresent,
      'isPaperNearEnd': instance.isPaperNearEnd,
      'isCoverOpened': instance.isCoverOpened,
      'isPrinterConnectionLost': instance.isPrinterConnectionLost,
      'isPrinterError': instance.isPrinterError,
      'isCutError': instance.isCutError,
      'isPrinterOverheat': instance.isPrinterOverheat,
      'isDeviceBlocked': instance.isDeviceBlocked,
    };
