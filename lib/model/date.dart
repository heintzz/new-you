class DateModel {
  static final Map<int, String> monthMap = {
    1: 'Januari',
    2: 'Februari',
    3: 'Maret',
    4: 'April',
    5: 'Mei',
    6: 'Juni',
    7: 'Juli',
    8: 'Agustus',
    9: 'September',
    10: 'Oktober',
    11: 'November',
    12: 'Desember'
  };

  static String getMonthName(int index) {
    return monthMap[index] ?? '';
  }

  static String getFullDateString(DateTime currDate) {
    final (day, month, year) =
        (currDate.day.toString(), currDate.month, currDate.year.toString());
    return "$day ${getMonthName(month)} $year";
  }

  static String getDayName(DateTime currDate, int day) {
    final date = DateTime(currDate.year, currDate.month, day + 1);
    return ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'][date.weekday % 7];
  }

  static int getDaysInMonth(DateTime currDate) {
    return DateTime(currDate.year, currDate.month + 1, 0).day;
  }

  static int? getMonthIndex(String monthName) {
    return monthMap.entries
        .firstWhere((entry) => entry.value == monthName,
            orElse: () => const MapEntry(0, ''))
        .key;
  }
}
