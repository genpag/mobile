import 'package:flutter/material.dart';
import 'package:mobile/pages/to_do_list.page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const mainColor = 0xFF1373B2;

    return MaterialApp(
      title: 'Flutter Todo List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: MaterialColor(mainColor, {
          50: Color(mainColor).withOpacity(.1),
          100: Color(mainColor).withOpacity(.2),
          200: Color(mainColor).withOpacity(.3),
          300: Color(mainColor).withOpacity(.4),
          400: Color(mainColor).withOpacity(.5),
          500: Color(mainColor).withOpacity(.6),
          600: Color(mainColor).withOpacity(.7),
          700: Color(mainColor).withOpacity(.8),
          800: Color(mainColor).withOpacity(.9),
          900: Color(mainColor).withOpacity(1),
        }),
        accentColor: const Color(0xFFC59739),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListPage(),
    );
  }
}
