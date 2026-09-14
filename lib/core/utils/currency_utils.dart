class CurrencyUtils {
  CurrencyUtils._();

  static String formatRupees(int value) {
    final s = value.toString();
    if (s.length <= 3) return '₹$s';
    var p = s.substring(0, s.length - 3),
        last = s.substring(s.length - 3);
    final parts = <String>[];
    while (p.length > 2) {
      parts.insert(0, p.substring(p.length - 2));
      p = p.substring(0, p.length - 2);
    }
    if (p.isNotEmpty) parts.insert(0, p);
    return '₹${parts.join(',')},$last';
  }
}
