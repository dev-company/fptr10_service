import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_element_enums.dart';

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
  // TODO: final String nomenclatureCode;
  // final FptrImcParams imcParams;
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
    required this.name,
    required this.price,
    required this.quantity,
    required this.amount,
    this.department = 1,
    this.infoDiscountAmount = 0.0,
    required this.measurementUnit,
    this.piece = false,
    this.paymentMethod = FptrPaymentMethod.fullPrepayment,
    required this.paymentObject,
    this.additionalAttributePrint = true,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': EnumUtils.toShortString(type),
      'name': name,
      'price': price,
      'quantity': quantity,
      'amount': amount,
      'department': department,
      'infoDiscountAmount': infoDiscountAmount,
      'measurementUnit': EnumUtils.toShortString(measurementUnit),
      'piece': piece,
      'paymentMethod': EnumUtils.toShortString(paymentMethod),
      'paymentObject': EnumUtils.toShortString(paymentObject),
      'additionalAttributePrint': additionalAttributePrint,
      // TODO: add other
    };
  }
}
