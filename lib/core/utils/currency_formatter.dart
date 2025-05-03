import 'package:intl/intl.dart';

/// Currency formatter extensions to format strings
/// to currency naira using [formatToNaira] and for custom currency use
/// [formatToCurrency]
extension CurrencyFormat on String {
  /// format String characters to naira
  String get formatToNaira {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(name: 'NGN', decimalDigits: 0);
      final format = formatCurrency.format(num.parse(this));

      return format;
    } catch (e) {
      return this;
    }
  }

  /// formats string char to any custom currency
  String formatToCurrency(String currency) {
    try {
      final formatCurrency = NumberFormat.simpleCurrency(name: currency);
      final format = formatCurrency.format(num.parse(this));

      return format;
    } catch (e) {
      return this;
    }
  }

  String formatNumber(String countryCode) {
    return '$countryCode${replaceFirst('0', '')}';
  }
}
