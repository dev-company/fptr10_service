import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_element_enums.dart';

class FptrPixelsElement {
  final FptrElementType type = FptrElementType.pixels;

  final String pixels;
  final int width;
  final int scale;
  final FptrElementAlignment alignment;

  /// Массив пикселей [pixels].
  /// Каждый байт кодирует один пиксель (0 - белый, другие значения - черный).
  /// Затем массив кодируется в base64
  FptrPixelsElement({
    required this.pixels,
    required this.width,
    this.scale = 100,
    this.alignment = FptrElementAlignment.center,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': EnumUtils.toShortString(type),
      'pixels': pixels,
      'width': width,
      'scale': scale,
      'alignment': EnumUtils.toShortString(alignment),
    };
  }
}
