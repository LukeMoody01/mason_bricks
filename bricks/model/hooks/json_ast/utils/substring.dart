import 'dart:math';

import '../grapheme_splitter.dart';

String substring(String str, int start, [int? end]) {
  if (end == null) {
    end = start + 1;
  }
  final splitter = GraphemeSplitter();
  final iterator = splitter.iterateGraphemes(str.substring(start));
  final strBuffer = StringBuffer();
  for (int i = 0; i < end - start; i++) {
    strBuffer.write(iterator.elementAt(i));
  }
  return strBuffer.toString();
}

String safeSubstring(String str, int start, int end) {
  final len = str.length;
  if (len > start) {
    final lastIndex = min(len, end);
    return str.substring(start, lastIndex);
  }
  return '';
}
