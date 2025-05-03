import 'package:flutter/material.dart';

///[AppTheme] extension for various themes
extension AppTheme on BuildContext {
  ///extension method to access [theme] from [BuildContext]
  ThemeData get theme => Theme.of(this);

  ///extension method to access [textTheme] from [BuildContext]
  TextTheme get textTheme => Theme.of(this).textTheme;
}
