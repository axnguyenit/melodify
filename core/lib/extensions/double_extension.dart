extension DoubleExtension on double {
  double toDecimal({int decimal = 2}) {
    return double.parse(toStringAsFixed(decimal));
  }
}
