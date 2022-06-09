import 'package:app_ui/src/colors.dart';
import 'package:app_ui/src/typography/typography.dart';
import 'package:flutter/widgets.dart';

/// {{#pascalCase}}{{project_name}}{{/pascalCase}} Text Style Definitions
class {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle {
  static const _baseTextStyle = TextStyle(
    package: 'app_ui',
    fontFamily: 'OpenSans',
    color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.black,
    fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.regular,
  );

  /// Headline 1 Text Style
  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 56,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.medium,
    );
  }

  /// Headline 2 Text Style
  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 30,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.regular,
    );
  }

  /// Headline 3 Text Style
  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 28,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.regular,
    );
  }

  /// Headline 4 Text Style
  static TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 22,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.bold,
    );
  }

  /// Headline 5 Text Style
  static TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.medium,
    );
  }

  /// Headline 6 Text Style
  static TextStyle get headline6 {
    return _baseTextStyle.copyWith(
      fontSize: 22,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.bold,
    );
  }

  /// Subtitle 1 Text Style
  static TextStyle get subtitle1 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.bold,
    );
  }

  /// Subtitle 2 Text Style
  static TextStyle get subtitle2 {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.bold,
    );
  }

  /// Body Text 1 Text Style
  static TextStyle get bodyText1 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.medium,
    );
  }

  /// Body Text 2 Text Style (the default)
  static TextStyle get bodyText2 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.regular,
    );
  }

  /// Caption Text Style
  static TextStyle get caption {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.regular,
    );
  }

  /// Overline Text Style
  static TextStyle get overline {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.regular,
    );
  }

  /// Button Text Style
  static TextStyle get button {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: {{#pascalCase}}{{project_name}}{{/pascalCase}}FontWeight.medium,
    );
  }
}
