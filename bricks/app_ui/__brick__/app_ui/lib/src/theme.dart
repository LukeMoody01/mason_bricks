import 'package:app_ui/src/colors.dart';
import 'package:app_ui/src/typography/typography.dart';
import 'package:flutter/material.dart';

const _smallTextScaleFactor = 0.80;
const _largeTextScaleFactor = 1.20;

/// Namespace for the {{#pascalCase}}{{project_name}}{{/pascalCase}} [ThemeData].
class {{#pascalCase}}{{project_name}}{{/pascalCase}}Theme {
  /// Standard `ThemeData` for {{#pascalCase}}{{project_name}}{{/pascalCase}} UI.
  static ThemeData get standard {
    return ThemeData(
      colorScheme:
          ColorScheme.fromSwatch(accentColor: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.primary),
      appBarTheme: _appBarTheme,
      elevatedButtonTheme: _elevatedButtonTheme,
      outlinedButtonTheme: _outlinedButtonTheme,
      textTheme: _textTheme,
      dialogBackgroundColor: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.whiteBackground,
      dialogTheme: _dialogTheme,
      tooltipTheme: _tooltipTheme,
      bottomSheetTheme: _bottomSheetTheme,
      tabBarTheme: _tabBarTheme,
      dividerTheme: _dividerTheme,
    );
  }

  /// `ThemeData` for {{#pascalCase}}{{project_name}}{{/pascalCase}} UI for small screens.
  static ThemeData get small {
    return standard.copyWith(textTheme: _smallTextTheme);
  }

  /// `ThemeData` for {{#pascalCase}}{{project_name}}{{/pascalCase}} UI for medium screens.
  static ThemeData get medium {
    return standard.copyWith(textTheme: _smallTextTheme);
  }

  /// `ThemeData` for {{#pascalCase}}{{project_name}}{{/pascalCase}} UI for large screens.
  static ThemeData get large {
    return standard.copyWith(textTheme: _largeTextTheme);
  }

  static TextTheme get _textTheme {
    return TextTheme(
      headline1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline1,
      headline2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline2,
      headline3: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline3,
      headline4: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline4,
      headline5: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline5,
      headline6: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline6,
      subtitle1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.subtitle1,
      subtitle2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.subtitle2,
      bodyText1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.bodyText1,
      bodyText2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.bodyText2,
      caption: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.caption,
      overline: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.overline,
      button: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.button,
    );
  }

  static TextTheme get _smallTextTheme {
    return TextTheme(
      headline1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline1.copyWith(
        fontSize: _textTheme.headline1!.fontSize! * _smallTextScaleFactor,
      ),
      headline2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline2.copyWith(
        fontSize: _textTheme.headline2!.fontSize! * _smallTextScaleFactor,
      ),
      headline3: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline3.copyWith(
        fontSize: _textTheme.headline3!.fontSize! * _smallTextScaleFactor,
      ),
      headline4: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline4.copyWith(
        fontSize: _textTheme.headline4!.fontSize! * _smallTextScaleFactor,
      ),
      headline5: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline5.copyWith(
        fontSize: _textTheme.headline5!.fontSize! * _smallTextScaleFactor,
      ),
      headline6: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline6.copyWith(
        fontSize: _textTheme.headline6!.fontSize! * _smallTextScaleFactor,
      ),
      subtitle1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.subtitle1.copyWith(
        fontSize: _textTheme.subtitle1!.fontSize! * _smallTextScaleFactor,
      ),
      subtitle2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.subtitle2.copyWith(
        fontSize: _textTheme.subtitle2!.fontSize! * _smallTextScaleFactor,
      ),
      bodyText1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.bodyText1.copyWith(
        fontSize: _textTheme.bodyText1!.fontSize! * _smallTextScaleFactor,
      ),
      bodyText2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.bodyText2.copyWith(
        fontSize: _textTheme.bodyText2!.fontSize! * _smallTextScaleFactor,
      ),
      caption: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.caption.copyWith(
        fontSize: _textTheme.caption!.fontSize! * _smallTextScaleFactor,
      ),
      overline: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.overline.copyWith(
        fontSize: _textTheme.overline!.fontSize! * _smallTextScaleFactor,
      ),
      button: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.button.copyWith(
        fontSize: _textTheme.button!.fontSize! * _smallTextScaleFactor,
      ),
    );
  }

  static TextTheme get _largeTextTheme {
    return TextTheme(
      headline1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline1.copyWith(
        fontSize: _textTheme.headline1!.fontSize! * _largeTextScaleFactor,
      ),
      headline2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline2.copyWith(
        fontSize: _textTheme.headline2!.fontSize! * _largeTextScaleFactor,
      ),
      headline3: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline3.copyWith(
        fontSize: _textTheme.headline3!.fontSize! * _largeTextScaleFactor,
      ),
      headline4: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline4.copyWith(
        fontSize: _textTheme.headline4!.fontSize! * _largeTextScaleFactor,
      ),
      headline5: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline5.copyWith(
        fontSize: _textTheme.headline5!.fontSize! * _largeTextScaleFactor,
      ),
      headline6: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.headline6.copyWith(
        fontSize: _textTheme.headline6!.fontSize! * _largeTextScaleFactor,
      ),
      subtitle1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.subtitle1.copyWith(
        fontSize: _textTheme.subtitle1!.fontSize! * _largeTextScaleFactor,
      ),
      subtitle2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.subtitle2.copyWith(
        fontSize: _textTheme.subtitle2!.fontSize! * _largeTextScaleFactor,
      ),
      bodyText1: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.bodyText1.copyWith(
        fontSize: _textTheme.bodyText1!.fontSize! * _largeTextScaleFactor,
      ),
      bodyText2: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.bodyText2.copyWith(
        fontSize: _textTheme.bodyText2!.fontSize! * _largeTextScaleFactor,
      ),
      caption: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.caption.copyWith(
        fontSize: _textTheme.caption!.fontSize! * _largeTextScaleFactor,
      ),
      overline: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.overline.copyWith(
        fontSize: _textTheme.overline!.fontSize! * _largeTextScaleFactor,
      ),
      button: {{#pascalCase}}{{project_name}}{{/pascalCase}}TextStyle.button.copyWith(
        fontSize: _textTheme.button!.fontSize! * _largeTextScaleFactor,
      ),
    );
  }

  static AppBarTheme get _appBarTheme {
    return const AppBarTheme(color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.primary);
  }

  static ElevatedButtonThemeData get _elevatedButtonTheme {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        primary: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.primary,
        fixedSize: const Size(208, 54),
      ),
    );
  }

  static OutlinedButtonThemeData get _outlinedButtonTheme {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        side: const BorderSide(color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.white, width: 2),
        primary: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.white,
        fixedSize: const Size(208, 54),
      ),
    );
  }

  static TooltipThemeData get _tooltipTheme {
    return const TooltipThemeData(
      decoration: BoxDecoration(
        color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.charcoal,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.all(10),
      textStyle: TextStyle(color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.white),
    );
  }

  static DialogTheme get _dialogTheme {
    return DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  static BottomSheetThemeData get _bottomSheetTheme {
    return const BottomSheetThemeData(
      backgroundColor: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.whiteBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }

  static TabBarTheme get _tabBarTheme {
    return const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 2,
          color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.primary,
        ),
      ),
      labelColor: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.primary,
      unselectedLabelColor: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.black25,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  static DividerThemeData get _dividerTheme {
    return const DividerThemeData(
      space: 0,
      thickness: 1,
      color: {{#pascalCase}}{{project_name}}{{/pascalCase}}Colors.black25,
    );
  }
}
