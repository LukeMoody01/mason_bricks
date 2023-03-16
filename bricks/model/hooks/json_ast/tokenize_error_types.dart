String unexpectedSymbol(String symbol, String source, int line, int column) {
  final sourceOrEmpty = source != "" ? '$source:' : '';
  final positionStr = '$sourceOrEmpty${line}:$column';
  return 'Unexpected symbol <$symbol> at $positionStr';
}
