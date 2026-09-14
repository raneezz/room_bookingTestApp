class DateUtils {
  DateUtils();

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

  static int nightsBetween(DateTime? a, DateTime? b) {
    if (a == null || b == null) return 0;
    final n = b.difference(a).inDays;
    return n > 0 ? n : 0;
  }

  static String formatDate(DateTime? d) {
    if (d == null) return '';
    const m = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${d.day.toString().padLeft(2, '0')} ${m[d.month - 1]} ${d.year}';
  }
}
