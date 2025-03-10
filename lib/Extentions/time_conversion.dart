String convertTo24Hour(String time12Hour) {
  // Clean and normalize the input
  time12Hour = time12Hour.trim();

  // Extract hours, minutes, and period (AM/PM)
  final match = RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)', caseSensitive: false)
      .firstMatch(time12Hour);

  if (match == null) {
    throw FormatException("Invalid time format: $time12Hour");
  }

  int hours = int.parse(match.group(1)!); // Group 1: Hours
  int minutes = int.parse(match.group(2)!); // Group 2: Minutes
  String period = match.group(3)!.toUpperCase(); // Group 3: AM/PM

  // Convert hours to 24-hour format
  if (period == "PM" && hours != 12) {
    hours += 12;
  } else if (period == "AM" && hours == 12) {
    hours = 0;
  }

  // Format the result as HH:mm
  return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
}