import 'package:flutter/material.dart';

Route<dynamic> defaultRouteGenerator(RouteSettings settings,
    Map<String, Function(BuildContext context)> routes) {
  return MaterialPageRoute<dynamic>(
    builder: (context) => routes[settings.name]?.call(context),
    settings: settings,
  );
}
