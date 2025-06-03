import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/favorite_page.dart';
import '../pages/main_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/favorite_service.dart'; // jangan lupa import ini

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteService().init();
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MovieBox',
      theme: ThemeData.dark().copyWith(
        colorScheme: ColorScheme.dark(
          primary: Colors.redAccent,
        ),
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const MainNavigation(),
    );
  }
}
