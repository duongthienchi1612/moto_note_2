import 'package:basic_utils/basic_utils.dart';

class StringFormatter {
  StringFormatter._();
  
  static String formatDisplayKm(String? input) {
    if (StringUtils.isNullOrEmpty(input)) return input ?? '';
    if (input!.length < 4) return input;

    final splitIndex = input.length == 5 ? 2 : 1;
    return '${input.substring(0, splitIndex)},${input.substring(splitIndex)}';
  }
}
