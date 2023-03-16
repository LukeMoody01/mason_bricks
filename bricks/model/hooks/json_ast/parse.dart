import 'dart:math';

import './utils/substring.dart';
import './location.dart';
import './error.dart';
import './parse_error_types.dart';
import './tokenize.dart';

enum _ObjectState { _START_, OPEN_OBJECT, PROPERTY, COMMA }

enum _PropertyState { _START_, KEY, COLON }

enum _ArrayState { _START_, OPEN_ARRAY, VALUE, COMMA }

JSONASTException errorEof(
    String input, List<dynamic> tokenList, Settings settings) {
  final Loc loc = tokenList.length > 0
      ? tokenList[tokenList.length - 1].loc.end
      : new Loc(line: 1, column: 1);

  final src = settings.source ?? "";
  return new JSONASTException(
      unexpectedEnd(), input, src, loc.line, loc.column);
}

/// [hexCode] is the hexCode string without '\u' prefix
String parseHexEscape(String hexCode) {
  int charCode = 0;
  final minLength = min(hexCode.length, 4);
  for (int i = 0; i < minLength; i++) {
    final hc = int.tryParse(hexCode[i], radix: 16);
    if (hc != null) {
      charCode = charCode * 16 + hc;
    }
  }
  return String.fromCharCode(charCode);
}

final escapes = {
  'b': '\b', // Backspace
  'f': '\f', // Form feed
  'n': '\n', // New line
  'r': '\r', // Carriage return
  't': '\t' // Horizontal tab
};

final passEscapes = ['"', '\\', '/'];

String parseString(String string) {
  final result = new StringBuffer();
  for (int i = 0; i < string.length; i++) {
    final char = string[i];
    if (char == '\\') {
      i++;
      final nextChar = string[i];
      if (nextChar == 'u') {
        result.write(parseHexEscape(safeSubstring(string, i + 1, i + 5)));
        i += 4;
      } else if (passEscapes.indexOf(nextChar) != -1) {
        result.write(nextChar);
      } else if (escapes.containsKey(nextChar)) {
        result.write(escapes[nextChar]);
      } else {
        break;
      }
    } else {
      result.write(char);
    }
  }
  return result.toString();
}

ValueIndex<ObjectNode>? parseObject(
    input, List<Token> tokenList, int index, Settings settings) {
  // object: LEFT_BRACE (property (COMMA property)*)? RIGHT_BRACE
  late Token startToken;
  final object = new ObjectNode();
  _ObjectState state = _ObjectState._START_;

  while (index < tokenList.length) {
    final token = tokenList[index];

    switch (state) {
      case _ObjectState._START_:
        {
          if (token.type == TokenType.LEFT_BRACE) {
            startToken = token;
            state = _ObjectState.OPEN_OBJECT;
            index++;
          } else {
            return null;
          }
          break;
        }

      case _ObjectState.OPEN_OBJECT:
        {
          if (token.type == TokenType.RIGHT_BRACE) {
            if (settings.loc) {
              final src = settings.source ?? "";
              object.loc = Location.create(
                  startToken.loc!.start.line,
                  startToken.loc!.start.column,
                  startToken.loc!.start.offset,
                  token.loc!.end.line,
                  token.loc!.end.column,
                  token.loc!.end.offset,
                  src);
            }
            return new ValueIndex(object, index + 1);
          } else {
            final property = parseProperty(input, tokenList, index, settings);
            if (property != null) {
              object.children.add(property.value);
              state = _ObjectState.PROPERTY;
              index = property.index;
            } else {
              final src = settings.source ?? "";
              final msg = unexpectedToken(
                  substring(
                      input, token.loc!.start.offset, token.loc!.end.offset),
                  src,
                  token.loc!.start.line,
                  token.loc!.start.column);
              throw new JSONASTException(msg, input, src, token.loc!.start.line,
                  token.loc!.start.column);
            }
          }
          break;
        }

      case _ObjectState.PROPERTY:
        {
          if (token.type == TokenType.RIGHT_BRACE) {
            if (settings.loc != null) {
              final src = settings.source ?? "";
              object.loc = Location.create(
                  startToken.loc!.start.line,
                  startToken.loc!.start.column,
                  startToken.loc!.start.offset,
                  token.loc!.end.line,
                  token.loc!.end.column,
                  token.loc!.end.offset,
                  src);
            }
            return new ValueIndex(object, index + 1);
          } else if (token.type == TokenType.COMMA) {
            state = _ObjectState.COMMA;
            index++;
          } else {
            final src = settings.source ?? "";
            final msg = unexpectedToken(
                substring(
                    input, token.loc!.start.offset, token.loc!.end.offset),
                src,
                token.loc!.start.line,
                token.loc!.start.column);
            throw new JSONASTException(msg, input, src, token.loc!.start.line,
                token.loc!.start.column);
          }
          break;
        }

      case _ObjectState.COMMA:
        {
          final property = parseProperty(input, tokenList, index, settings);
          if (property != null) {
            index = property.index;
            object.children.add(property.value);
            state = _ObjectState.PROPERTY;
          } else {
            final src = settings.source ?? "";
            final msg = unexpectedToken(
                substring(
                    input, token.loc!.start.offset, token.loc!.end.offset),
                src,
                token.loc!.start.line,
                token.loc!.start.column);
            throw new JSONASTException(msg, input, src, token.loc!.start.line,
                token.loc!.start.column);
          }
          break;
        }
    }
  }
  throw errorEof(input, tokenList, settings);
}

ValueIndex<PropertyNode>? parseProperty(
    String input, List<Token> tokenList, int index, Settings settings) {
  // property: STRING COLON value
  late Token startToken;
  final property = new PropertyNode();
  _PropertyState state = _PropertyState._START_;

  while (index < tokenList.length) {
    final token = tokenList[index];

    switch (state) {
      case _PropertyState._START_:
        {
          if (token.type == TokenType.STRING) {
            final value = parseString(safeSubstring(
                input, token.loc!.start.offset + 1, token.loc!.end.offset - 1));
            final key = new ValueNode(value, token.value);
            if (settings.loc != null) {
              key.loc = token.loc;
            }
            startToken = token;
            property.key = key;
            state = _PropertyState.KEY;
            index++;
          } else {
            return null;
          }
          break;
        }

      case _PropertyState.KEY:
        {
          if (token.type == TokenType.COLON) {
            state = _PropertyState.COLON;
            index++;
          } else {
            final src = settings.source ?? "";
            final msg = unexpectedToken(
                substring(
                    input, token.loc!.start.offset, token.loc!.end.offset),
                src,
                token.loc!.start.line,
                token.loc!.start.column);
            throw new JSONASTException(msg, input, src, token.loc!.start.line,
                token.loc!.start.column);
          }
          break;
        }

      case _PropertyState.COLON:
        {
          final value = _parseValue(input, tokenList, index, settings);
          property.value = value.value;
          if (settings.loc != null) {
            final src = settings.source ?? "";
            property.loc = Location.create(
                startToken.loc!.start.line,
                startToken.loc!.start.column,
                startToken.loc!.start.offset,
                value.value.loc.end.line,
                value.value.loc.end.column,
                value.value.loc.end.offset,
                src);
          }
          return new ValueIndex(property, value.index);
        }
    }
  }
  return null;
}

ValueIndex<ArrayNode>? parseArray(
    String input, List<Token> tokenList, int index, Settings settings) {
  // array: LEFT_BRACKET (value (COMMA value)*)? RIGHT_BRACKET
  late Token startToken;
  final array = new ArrayNode();
  var state = _ArrayState._START_;
  Token token;
  while (index < tokenList.length) {
    token = tokenList[index];
    switch (state) {
      case _ArrayState._START_:
        {
          if (token.type == TokenType.LEFT_BRACKET) {
            startToken = token;
            state = _ArrayState.OPEN_ARRAY;
            index++;
          } else {
            return null;
          }
          break;
        }

      case _ArrayState.OPEN_ARRAY:
        {
          if (token.type == TokenType.RIGHT_BRACKET) {
            if (settings.loc != null) {
              final src = settings.source ?? "";
              array.loc = Location.create(
                  startToken.loc!.start.line,
                  startToken.loc!.start.column,
                  startToken.loc!.start.offset,
                  token.loc!.end.line,
                  token.loc!.end.column,
                  token.loc!.end.offset,
                  src);
            }
            return new ValueIndex(array, index + 1);
          } else {
            final value = _parseValue(input, tokenList, index, settings);
            index = value.index;
            array.children.add(value.value);
            state = _ArrayState.VALUE;
          }
          break;
        }

      case _ArrayState.VALUE:
        {
          if (token.type == TokenType.RIGHT_BRACKET) {
            if (settings.loc != null) {
              final src = settings.source ?? "";
              array.loc = Location.create(
                  startToken.loc!.start.line,
                  startToken.loc!.start.column,
                  startToken.loc!.start.offset,
                  token.loc!.end.line,
                  token.loc!.end.column,
                  token.loc!.end.offset,
                  src);
            }
            return new ValueIndex(array, index + 1);
          } else if (token.type == TokenType.COMMA) {
            state = _ArrayState.COMMA;
            index++;
          } else {
            final src = settings.source ?? "";
            final msg = unexpectedToken(
                substring(
                    input, token.loc!.start.offset, token.loc!.end.offset),
                src,
                token.loc!.start.line,
                token.loc!.start.column);
            throw new JSONASTException(msg, input, src, token.loc!.start.line,
                token.loc!.start.column);
          }
          break;
        }

      case _ArrayState.COMMA:
        {
          final value = _parseValue(input, tokenList, index, settings);
          index = value.index;
          array.children.add(value.value);
          state = _ArrayState.VALUE;
          break;
        }
    }
  }
  throw errorEof(input, tokenList, settings);
}

ValueIndex<LiteralNode>? parseLiteral(
    String input, List<Token> tokenList, int index, Settings settings) {
  // literal: STRING | NUMBER | TRUE | FALSE | NULL
  final token = tokenList[index];
  var value = null;

  switch (token.type) {
    case TokenType.STRING:
      {
        value = parseString(safeSubstring(
            input, token.loc!.start.offset + 1, token.loc!.end.offset - 1));
        break;
      }
    case TokenType.NUMBER:
      {
        if (token.value != null) {
          value = int.tryParse(token.value!) ?? null;
          if (value == null) {
            value = double.tryParse(token.value!) ?? null;
          }
        }
        break;
      }
    case TokenType.TRUE:
      {
        value = true;
        break;
      }
    case TokenType.FALSE:
      {
        value = false;
        break;
      }
    case TokenType.NULL:
      {
        value = null;
        break;
      }
    default:
      {
        return null;
      }
  }

  final literal = new LiteralNode(value, token.value);
  if (settings.loc != null) {
    literal.loc = token.loc;
  }
  return new ValueIndex(literal, index + 1);
}

typedef ValueIndex? _parserFun(
    String input, List<Token> tokenList, int index, Settings settings);

List<_parserFun> _parsersList = [parseLiteral, parseObject, parseArray];

ValueIndex? _findValueIndex(
    String input, List<Token> tokenList, int index, Settings settings) {
  for (int i = 0; i < _parsersList.length; i++) {
    final parser = _parsersList.elementAt(i);
    final valueIndex = parser(input, tokenList, index, settings);
    if (valueIndex != null) {
      return valueIndex;
    }
  }
  return null;
}

ValueIndex _parseValue(
    String input, List<Token> tokenList, int index, Settings settings) {
  // value: literal | object | array
  final token = tokenList[index];

  final value = _findValueIndex(input, tokenList, index, settings);

  if (value != null) {
    return value;
  } else {
    final src = settings.source ?? "";
    final msg = unexpectedToken(
        substring(input, token.loc!.start.offset, token.loc!.end.offset),
        src,
        token.loc!.start.line,
        token.loc!.start.column);
    throw new JSONASTException(
        msg, input, src, token.loc!.start.line, token.loc!.start.column);
  }
}

Node parse(input, settings) {
  final tokenList = tokenize(input, settings);

  if (tokenList.length == 0) {
    throw errorEof(input, tokenList, settings);
  }

  final value = _parseValue(input, tokenList, 0, settings);

  if (value.index == tokenList.length) {
    return value.value;
  }

  final token = tokenList[value.index];

  final src = settings.source ?? "";
  final msg = unexpectedToken(
      substring(input, token.loc!.start.offset, token.loc!.end.offset),
      src,
      token.loc!.start.line,
      token.loc!.start.column);
  throw new JSONASTException(
      msg, input, src, token.loc!.start.line, token.loc!.start.column);
}
