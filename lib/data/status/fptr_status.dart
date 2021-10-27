import 'package:freezed_annotation/freezed_annotation.dart';

part 'fptr_status.freezed.dart';
part 'fptr_status.g.dart';

@freezed
class FptrStatus with _$FptrStatus {
  factory FptrStatus({
    required int operatorID,
    required int logicalNumber,
    @Default(3) int shiftState,
    required String modelName,
    required int mode,
    required int submode,
    required int receiptNumber,
    required int documentNumber,
    required int shiftNumber,
    required int receiptType,
    required int documentType,
    required int lineLength,
    required int lineLengthPix,
    required double receiptSum,
    required bool isFiscalDevice,
    required bool isFiscalFN,
    required bool isFNPresent,
    required bool isInvalidFN,
    required bool isCashDrawerOpened,
    required bool isPaperPresent,
    required bool isPaperNearEnd,
    required bool isCoverOpened,
    required bool isPrinterConnectionLost,
    required bool isPrinterError,
    required bool isCutError,
    required bool isPrinterOverheat,
    required bool isDeviceBlocked,
  }) = _FptrStatus;

  factory FptrStatus.fromJson(Map<String, dynamic> json) =>
      _$FptrStatusFromJson(json);

  // event _InternalLinkedHashMap<String, dynamic>
  factory FptrStatus.fromEvent(dynamic event) {
    Map<String, dynamic> eventMap = Map<String, dynamic>.from(event);
    return FptrStatus.fromJson(eventMap);
  }
}

extension FptrStatusExt on FptrStatus {
  Map<String, dynamic> toSimpleMap() {
    return {
      'shift': shiftString,
      'blocked': isDeviceBlocked,
      'coverOpened': isCoverOpened,
      'paperPresent': isPaperPresent,
      'fiscal': isFiscalDevice,
      'fnFiscal': isFiscalFN,
      'cashDrawerOpened': isCashDrawerOpened,
    };
  }

  String get shiftString {
    const List<String> states = ['closed', 'opened', 'expired', 'unknown'];
    return states[shiftState];
  }
}
