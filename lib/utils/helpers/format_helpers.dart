class FormatHelpers {
  static String formatValue(String value) {
    if (value.contains('null')) {
      return '';
    }
    return value.trim();
  }

  static String phoneNumber(String value, {String callingCode = '84'}) {
    String result = formatValue(value);
    if (value.startsWith('0')) {
      result = '+$callingCode${result.substring(1)}';
    } else if (!value.startsWith('+')) {
      result = '+$result';
    }
    return result;
  }

  static String upperFirstCharacter(String value) {
    String firstStr = value[0];
    return '${firstStr.toUpperCase()}${value.substring(1)}';
  }
}
