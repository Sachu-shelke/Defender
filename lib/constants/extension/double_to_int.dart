extension DoubleToInt on String {
  String get doubleToInt {
    return double.parse(this).toInt().toString();
  }
}


// first letting Capital in name

extension StringExtension on String {
  String capitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.capitalize())
      .join(' ');
}
