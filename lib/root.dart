import 'package:flutter/material.dart';

import 'client_injector.dart';
import 'routes/route_generator.dart';
import 'routes/route_names.dart';
import 'routes/routes.dart';

class RootApplication extends StatefulWidget {
  const RootApplication({Key key}) : super(key: key);

  @override
  _RootApplicationState createState() => _RootApplicationState();
}

class _RootApplicationState extends State<RootApplication> {
  @override
  void initState() {
    ClientInjector.injectAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.home,
      onGenerateRoute: (settings) => defaultRouteGenerator(settings, routes),
    );
  }
}
