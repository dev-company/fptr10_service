class EnumUtils {
  static String toShortString(Object enumEntry) =>
      enumEntry.toString().split('.').last;
}
