class DateFormater {
  compareDate(dynamic finalDate) {
    final difference = DateTime.now().difference(finalDate).inMinutes;
    if (difference <= 1) {
      return "Há ${difference} min";
    } else if (difference <= 59) {
      return "Há ${difference} mins";
    } else {
      final difference = DateTime.now().difference(finalDate).inHours;
      if (difference <= 1) {
        return "Há ${difference} hora";
      } else {
        return "Há ${difference} horas";
      }
    }
  }
}
