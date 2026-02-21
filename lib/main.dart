import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/home_page.dart';
import 'pages/add_report_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(MafqoodatiApp());
}

class MafqoodatiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'مفقوداتي',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color(0xFF6C63FF),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.cairoTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => HomePage(),
        '/add': (_) => AddReportPage(),
        '/about': (_) => AboutPage(),
      },
    );
  }
}
