import 'package:fptr10_service/utils/enum_utils.dart';

import 'fptr_element_enums.dart';

class FptrPictureMemElement {
  final FptrElementType type = FptrElementType.pictureFromMemory;

  final int pictureNumber;
  final FptrElementAlignment alignment;

  /// Номер картинки [pictureNumber]
  FptrPictureMemElement({
    required this.pictureNumber,
    this.alignment = FptrElementAlignment.center,
  });

  Map<String, dynamic> toMap() {
    return {
      'type': EnumUtils.toShortString(type),
      'pictureNumber': pictureNumber,
      'alignment': EnumUtils.toShortString(alignment),
    };
  }
}
