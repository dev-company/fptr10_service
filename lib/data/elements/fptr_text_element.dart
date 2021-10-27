import 'package:fptr10_service/utils/enum_utils.dart';

enum TextAlignment { left, center, right }
enum TextWrap { none, chars, words }

class FptrTextElement {
  final String type = 'text';
  final String text;
  final TextAlignment alignment;
  final TextWrap wrap;
  final int font;
  final bool doubleWidth;
  final bool doubleHeight;

  FptrTextElement({
    required this.text,
    this.alignment = TextAlignment.center,
    this.wrap = TextWrap.none,
    this.font = 0,
    this.doubleWidth = false,
    this.doubleHeight = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'text': text,
      'alignment': EnumUtils.toShortString(alignment),
      'wrap': EnumUtils.toShortString(wrap),
      'font': font,
      'doubleWidth': doubleWidth,
      'doubleHeight': doubleHeight,
    };
  }
}
