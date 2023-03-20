import './utils/substring.dart';
import './location.dart';
import './error.dart';
import './tokenize_error_types.dart';

enum TokenType {
  LEFT_BRACE, // {
  RIGHT_BRACE, // }
  LEFT_BRACKET, // [
  RIGHT_BRACKET, // ]
  COLON, // :
  COMMA, // ,
  STRING, //
  NUMBER, //
  TRUE, // true
  FALSE, // false
  NULL // null
}

final Map<String, TokenType> punctuatorTokensMap = {
  '{': TokenType.LEFT_BRACE,
  '}': TokenType.RIGHT_BRACE,
  '[': TokenType.LEFT_BRACKET,
  ']': TokenType.RIGHT_BRACKET,
  ':': TokenType.COLON,
  ',': TokenType.COMMA
};

final Map<String, TokenType> keywordTokensMap = {
  'true': TokenType.TRUE,
  'false': TokenType.FALSE,
  'null': TokenType.NULL
};

enum _StringState { _START_, START_QUOTE_OR_CHAR, ESCAPE }

final Map<String, int> escapes = {
  '"': 0, // Quotation mask
  '\\': 1, // Reverse solidus
  '/': 2, // Solidus
  'b': 3, // Backspace
  'f': 4, // Form feed
  'n': 5, // New line
  'r': 6, // Carriage return
  't': 7, // Horizontal tab
  'u': 8 // 4 hexadecimal digits
};

enum _NumberState {
  _START_,
  MINUS,
  ZERO,
  DIGIT,
  POINT,
  DIGIT_FRACTION,
  EXP,
  EXP_DIGIT_OR_SIGN
}

bool _compareDynamicList(List l, List other) {
  if (l != null && other != null) {
    final len = l.length;
    if (len != other.length) {
      return false;
    }
    for (int i = 0; i < len; i++) {
      final el = l.elementAt(i);
      final otherEl = other.elementAt(i);
      if (el != otherEl) {
        return false;
      }
    }
  } else if (l == null && other != null || l != null && other == null) {
    return false;
  }
  return true;
}

abstract class Node {
  final String type;
  Location? loc;

  Node(this.type);
}

class ValueNode extends Node {
  final String value;
  final String? raw;

  ValueNode(this.value, this.raw) : super('Identifier');

  bool operator ==(dynamic other) =>
      other is ValueNode &&
      type == other.type &&
      loc == other.loc &&
      value == other.value &&
      raw == other.raw;
}

class Token {
  final TokenType? type;
  final int line;
  final int column;
  final int index;
  final String? value;
  Location? loc;
  Token(this.type, this.line, this.column, this.index, this.value);
}

class ObjectNode extends Node {
  final List<PropertyNode> children = <PropertyNode>[];

  ObjectNode() : super('Object');

  bool operator ==(dynamic other) =>
      other is ObjectNode &&
      type == other.type &&
      loc == other.loc &&
      _compareDynamicList(this.children, other.children);
}

class ArrayNode extends Node {
  final List<Node> children = <Node>[];

  ArrayNode() : super('Array');

  bool operator ==(dynamic other) =>
      other is ArrayNode &&
      type == other.type &&
      loc == other.loc &&
      _compareDynamicList(this.children, other.children);
}

class PropertyNode extends Node {
  final List<Node> children = <Node>[];
  int? index;
  ValueNode? key;
  Node? value;

  PropertyNode() : super('Property');

  bool operator ==(dynamic other) =>
      other is PropertyNode &&
      type == other.type &&
      index == other.index &&
      loc == other.loc &&
      key == other.key &&
      value == other.value &&
      _compareDynamicList(this.children, other.children);
}

class LiteralNode extends Node {
  final dynamic value;
  final String? raw;

  LiteralNode(this.value, this.raw) : super('Literal');

  bool operator ==(dynamic other) =>
      other is LiteralNode &&
      type == other.type &&
      loc == other.loc &&
      value == other.value &&
      raw == other.raw;
}

class ValueIndex<T> {
  final T value;
  final int index;

  ValueIndex(this.value, this.index);

  bool operator ==(dynamic other) =>
      other is ValueIndex<T> && value == other.value && index == other.index;
}

// HELPERS

bool isDigit1to9(String char) {
  final charCode = char.codeUnitAt(0);
  return charCode >= '1'.codeUnitAt(0) && charCode <= '9'.codeUnitAt(0);
}

bool isDigit(String char) {
  final charCode = char.codeUnitAt(0);
  return charCode >= '0'.codeUnitAt(0) && charCode <= '9'.codeUnitAt(0);
}

bool isHex(char) {
  final charCode = char.codeUnitAt(0);
  return (isDigit(char) ||
      (charCode >= 'a'.codeUnitAt(0) && charCode <= 'f'.codeUnitAt(0)) ||
      (charCode >= 'A'.codeUnitAt(0) && charCode <= 'F'.codeUnitAt(0)));
}

bool isExp(char) {
  return char == 'e' || char == 'E';
}

class Position {
  final int index;
  final int line;
  final int column;

  Position(this.index, this.line, this.column);
}

// PARSERS

Position? parseWhitespace(String input, int index, int line, int column) {
  final char = input[index];

  if (char == '\r') {
    // CR (Unix)
    index++;
    line++;
    column = 1;
    if (input[index] == '\n') {
      // CRLF (Windows)
      index++;
    }
  } else if (char == '\n') {
    // LF (MacOS)
    index++;
    line++;
    column = 1;
  } else if (char == '\t' || char == ' ') {
    index++;
    column++;
  } else {
    return null;
  }

  return new Position(index, line, column);
}

Token? parseChar(String input, int index, int line, int column) {
  final char = input[index];
  if (punctuatorTokensMap.containsKey(char)) {
    final tokenType = punctuatorTokensMap[char];
    return new Token(tokenType, line, column + 1, index + 1, null);
  }

  return null;
}

Token? parseKeyword(String input, int index, int line, int column) {
  final entries = keywordTokensMap.entries;
  for (int i = 0; i < entries.length; i++) {
    final entry = entries.elementAt(i);
    final keyLen = entry.key.length;
    final nextLen = index + keyLen;
    final lastIndex = nextLen > input.length ? input.length : nextLen;
    if (safeSubstring(input, index, lastIndex) == entry.key) {
      return new Token(
          entry.value, line, column + keyLen, lastIndex, entry.key);
    }
  }

  return null;
}

Token? parseString(String input, int index, int line, int column) {
  final startIndex = index;
  // final buffer = new StringBuffer();
  _StringState state = _StringState._START_;

  while (index < input.length) {
    final char = input[index];

    switch (state) {
      case _StringState._START_:
        {
          if (char == '"') {
            index++;
            state = _StringState.START_QUOTE_OR_CHAR;
          } else {
            return null;
          }
          break;
        }

      case _StringState.START_QUOTE_OR_CHAR:
        {
          if (char == '\\') {
            // buffer.write(char);
            index++;
            state = _StringState.ESCAPE;
          } else if (char == '"') {
            index++;
            return new Token(
                TokenType.STRING,
                line,
                column + index - startIndex,
                index,
                safeSubstring(input, startIndex, index));
          } else {
            // buffer.write(char);
            index++;
          }
          break;
        }

      case _StringState.ESCAPE:
        {
          if (escapes.containsKey(char)) {
            // buffer.write(char);
            index++;
            if (char == 'u') {
              for (int i = 0; i < 4; i++) {
                final curChar = input[index];
                if (curChar != '' && isHex(curChar)) {
                  // buffer.write(char);
                  index++;
                } else {
                  return null;
                }
              }
            }
            state = _StringState.START_QUOTE_OR_CHAR;
          } else {
            return null;
          }
          break;
        }
    }
  }
  return null;
}

Token? parseNumber(String input, int index, int line, int column) {
  final startIndex = index;
  int passedValueIndex = index;
  _NumberState state = _NumberState._START_;

  iterator:
  while (index < input.length) {
    final char = input[index];

    switch (state) {
      case _NumberState._START_:
        {
          if (char == '-') {
            state = _NumberState.MINUS;
          } else if (char == '0') {
            passedValueIndex = index + 1;
            state = _NumberState.ZERO;
          } else if (isDigit1to9(char)) {
            passedValueIndex = index + 1;
            state = _NumberState.DIGIT;
          } else {
            return null;
          }
          break;
        }

      case _NumberState.MINUS:
        {
          if (char == '0') {
            passedValueIndex = index + 1;
            state = _NumberState.ZERO;
          } else if (isDigit1to9(char)) {
            passedValueIndex = index + 1;
            state = _NumberState.DIGIT;
          } else {
            return null;
          }
          break;
        }

      case _NumberState.ZERO:
        {
          if (char == '.') {
            state = _NumberState.POINT;
          } else if (isExp(char)) {
            state = _NumberState.EXP;
          } else {
            break iterator;
          }
          break;
        }

      case _NumberState.DIGIT:
        {
          if (isDigit(char)) {
            passedValueIndex = index + 1;
          } else if (char == '.') {
            state = _NumberState.POINT;
          } else if (isExp(char)) {
            state = _NumberState.EXP;
          } else {
            break iterator;
          }
          break;
        }

      case _NumberState.POINT:
        {
          if (isDigit(char)) {
            passedValueIndex = index + 1;
            state = _NumberState.DIGIT_FRACTION;
          } else {
            break iterator;
          }
          break;
        }

      case _NumberState.DIGIT_FRACTION:
        {
          if (isDigit(char)) {
            passedValueIndex = index + 1;
          } else if (isExp(char)) {
            state = _NumberState.EXP;
          } else {
            break iterator;
          }
          break;
        }

      case _NumberState.EXP:
        {
          if (char == '+' || char == '-') {
            state = _NumberState.EXP_DIGIT_OR_SIGN;
          } else if (isDigit(char)) {
            passedValueIndex = index + 1;
            state = _NumberState.EXP_DIGIT_OR_SIGN;
          } else {
            break iterator;
          }
          break;
        }

      case _NumberState.EXP_DIGIT_OR_SIGN:
        {
          if (isDigit(char)) {
            passedValueIndex = index + 1;
          } else {
            break iterator;
          }
          break;
        }
    }

    index++;
  }

  if (passedValueIndex > 0) {
    return new Token(
        TokenType.NUMBER,
        line,
        column + passedValueIndex - startIndex,
        passedValueIndex,
        safeSubstring(input, startIndex, passedValueIndex));
  }

  return null;
}

typedef Token? _tokenParser(String input, int index, int line, int column);

List<_tokenParser> _parsers = [
  parseChar,
  parseKeyword,
  parseString,
  parseNumber
];

Token? _parseToken(String input, int index, int line, int column) {
  for (int i = 0; i < _parsers.length; i++) {
    final token = _parsers[i](input, index, line, column);
    if (token != null) {
      return token;
    }
  }
  return null;
}

List<Token> tokenize(String input, Settings settings) {
  int line = 1;
  int column = 1;
  int index = 0;
  List<Token> tokens = <Token>[];

  while (index < input.length) {
    final whitespace = parseWhitespace(input, index, line, column);
    if (whitespace != null) {
      index = whitespace.index;
      line = whitespace.line;
      column = whitespace.column;
      continue;
    }

    final token = _parseToken(input, index, line, column);

    if (token != null) {
      final src = settings.source ?? "";
      token.loc = Location.create(
          line, column, index, token.line, token.column, token.index, src);
      tokens.add(token);
      index = token.index;
      line = token.line;
      column = token.column;
    } else {
      final src = settings.source ?? "";
      final msg = unexpectedSymbol(
          substring(input, index, index + 1), src, line, column);
      throw new JSONASTException(msg, input, src, line, column);
    }
  }
  return tokens;
}
