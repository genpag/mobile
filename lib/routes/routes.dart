import 'package:flutter/material.dart';
import 'package:mobile/features/home/home.dart';
import 'package:mobile/routes/route_names.dart';

Map<String, Function(BuildContext context)> routes = {
  RouteNames.home: HomeScreen.create
};
