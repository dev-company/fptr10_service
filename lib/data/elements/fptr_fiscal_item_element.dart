import 'fptr_element_enums.dart';

enum FptrImcItemStatus {
  itemPieceSold,
  itemDryForSale,
  itemPieceReturn,
  itemDryReturn,
  itemStatusUnchanged,
}

enum FptrImcType {
  auto,
  imcUnrecognized,
  imcShort,
  imcFmVerifyCode88,
  imcVerifyCode44,
  imcFmVerifyCode44,
  imcVerifyCode4,
}

class FptrImcParams {
  final FptrImcType imcType;
  final FptrImcItemStatus itemEstimatedStatus;
  final int imcModeProcessing;

  /// Идентификатор маркированного товара (тег 2101) в base64-представлении
  final String? imcBarcode;
  final String? itemFractionalAmount;
  final num itemQuantity;
  final FptrMeasurementUnit itemUnits;

  /// base64 представление значения кода маркировки (тег 2000)
  final String imc;
  // final itemInfoCheckResult;

  FptrImcParams({
    required this.imc,
    required this.itemEstimatedStatus,
    required this.itemQuantity,
    required this.itemUnits,
    this.imcBarcode,
    this.imcModeProcessing = 0,
    this.imcType = FptrImcType.auto,
    this.itemFractionalAmount,
  });

  Map<String, dynamic> get mapped {
    return {
      'imc': imc,
      'itemEstimatedStatus': itemEstimatedStatus.name,
      'itemQuantity': itemQuantity,
      'itemUnits': itemUnits.name,
      'imcBarcode': imcBarcode,
      'imcModeProcessing': imcModeProcessing,
      'imcType': imcType.name,
      'itemFractionalAmount': itemFractionalAmount,
    };
  }
}

class FptrFiscalItemElement {
  final FptrElementType type = FptrElementType.position;
  final String name;
  final double price;
  final double quantity;
  final double amount;
  final int department;
  final double infoDiscountAmount;
  final FptrMeasurementUnit measurementUnit;
  final bool piece;
  final FptrPaymentMethod paymentMethod;
  final FptrPaymentObject paymentObject;
  final FptrImcParams? imcParams;
  // final tax;
  // final agentInfo;
  // final supplierInfo;
  // final industryInfo;
  // final productCodes;
  // final additionalAttribute;
  final bool additionalAttributePrint;
  // final exciseSum;
  // final countryCode;
  // final customsDeclaration;
  // final userParam3;
  // final userParam4;
  // final userParam5;
  // final userParam6;

  FptrFiscalItemElement({
    // required this.type,
    required this.amount,
    required this.measurementUnit,
    required this.name,
    required this.paymentObject,
    required this.price,
    required this.quantity,
    this.additionalAttributePrint = true,
    this.department = 1,
    this.imcParams,
    this.infoDiscountAmount = 0.0,
    this.paymentMethod = FptrPaymentMethod.fullPrepayment,
    this.piece = false,
  });

  Map<String, dynamic> toMap() {
    Map<String, dynamic> basic = {
      'type': type.name,
      'name': name,
      'price': price,
      'quantity': quantity,
      'amount': amount,
      'department': department,
      'infoDiscountAmount': infoDiscountAmount,
      'measurementUnit': measurementUnit.name,
      'piece': piece,
      'paymentMethod': paymentMethod.name,
      'paymentObject': paymentObject.name,
      'additionalAttributePrint': additionalAttributePrint,
      // TODO: add other
    };

    // добавляем информацию о маркировке, если она есть
    if (imcParams != null) {
      basic = {
        ...basic,
        'imcParams': imcParams!.mapped,
      };
    }

    return basic;
  }
}
