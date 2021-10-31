import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_element_enums.dart';
import 'fptr_text_element.dart';

class FptrBarcodeElement {
  final FptrElementType type = FptrElementType.barcode;
  final String barcode;
  final FptrBarcodeType barcodeType;
  final FptrElementAlignment alignment;
  final int scale;
  final int height;
  final bool printText;
  final List<FptrTextElement> overlay;

  FptrBarcodeElement({
    required this.barcode,
    required this.barcodeType,
    this.alignment = FptrElementAlignment.center,
    this.scale = 1,
    this.printText = false,
    this.height = 30,
    this.overlay = const <FptrTextElement>[],
  });

  Map<String, dynamic> toMap() {
    return {
      'type': EnumUtils.toShortString(type),
      'barcode': barcode,
      'barcodeType': EnumUtils.toShortString(barcodeType),
      'alignment': EnumUtils.toShortString(alignment),
      'scale': scale,
      'printText': printText,
      'height': height,
      'overlay': overlay.map((FptrTextElement e) => e.toMap()).toList(),
    };
  }
}
