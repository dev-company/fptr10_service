import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_element_enums.dart';
import 'fptr_text_element.dart';

class FptrFiscalPaymentElement {
  final FptrPaymentType type;
  final double sum;
  final List<FptrTextElement> printItems;

  FptrFiscalPaymentElement({
    required this.type,
    required this.sum,
    this.printItems = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'type': EnumUtils.toShortString(type),
      'sum': sum,
      'printItems': printItems.map((FptrTextElement e) => e.toMap()).toList(),
    };
  }
}
