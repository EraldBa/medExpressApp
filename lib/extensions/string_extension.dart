extension TextFormatting on String {
  String formatWith(String format, {int step = 1}) {
    final s = split('');

    for (int i = step; i < s.length; i += step) {
      while (i < s.length && s[i] != ' ') {
        ++i;
      }
      s.insert(i, format);
    }

    return s.join();
  }
}
