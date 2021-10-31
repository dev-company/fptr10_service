import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_element_enums.dart';

class FptrTextElement {
  final FptrElementType type = FptrElementType.text;
  final String text;
  final FptrElementAlignment alignment;
  final FptrTextWrap wrap;
  final int font;
  final bool doubleWidth;
  final bool doubleHeight;

  FptrTextElement({
    required this.text,
    this.alignment = FptrElementAlignment.center,
    this.wrap = FptrTextWrap.none,
    this.font = 0,
    this.doubleWidth = false,
    this.doubleHeight = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': EnumUtils.toShortString(type),
      'text': text,
      'alignment': EnumUtils.toShortString(alignment),
      'wrap': EnumUtils.toShortString(wrap),
      'font': font,
      'doubleWidth': doubleWidth,
      'doubleHeight': doubleHeight,
    };
  }
}
