import 'package:cov_meds/constants/values.dart';
import 'package:flutter/material.dart';

// 日本オンリーの場合は固定で
const kLocale = Locale("ja", "JP");

const String kFontFamilyCupertino = "Hiragino Sans";

final String? _kFontFamily = lang == 'en' ? null : kFontFamilyCupertino;

final TextTheme _whiteTextTheme =
    lang == 'en' ? Typography.whiteMountainView : Typography.whiteCupertino;
final TextTheme _blackTextTheme =
    lang == 'en' ? Typography.blackMountainView : Typography.blackCupertino;

// Flutter標準のTextThemeをベースにして
// fontFamilyとlocaleを設定したTextStyleとTextThemeで作る
final Typography kTypography = Typography(
  white: _textTheme(_whiteTextTheme),
  black: _textTheme(_blackTextTheme),
  englishLike: _textTheme(Typography.englishLike2014),
  dense: _textTheme(Typography.dense2014),
  tall: _textTheme(Typography.tall2014),
);

TextStyle? _textStyle(TextStyle? base) {
  return base!.copyWith(
    fontFamily: _kFontFamily,
    locale: kLocale,
    textBaseline: TextBaseline.ideographic,
  );
}

TextTheme _textTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: _textStyle(base.displayLarge),
    displayMedium: _textStyle(base.displayMedium),
    displaySmall: _textStyle(base.displaySmall),
    headline1: _textStyle(base.headline1),
    headline2: _textStyle(base.headline2),
    headline3: _textStyle(base.headline3),
    headline4: _textStyle(base.headline4),
    headline5: _textStyle(base.headline5),
    headline6: _textStyle(base.headline6),
    titleMedium: _textStyle(base.titleMedium),
    subtitle1: _textStyle(base.subtitle1),
    subtitle2: _textStyle(base.subtitle2),
    bodyText1: _textStyle(base.bodyText1),
    bodyText2: _textStyle(base.bodyText2),
    bodyLarge: _textStyle(base.bodyLarge),
    bodyMedium: _textStyle(base.bodyMedium),
    bodySmall: _textStyle(base.bodySmall),
    caption: _textStyle(base.caption),
    button: _textStyle(base.button),
    overline: _textStyle(base.overline),
  );
}
