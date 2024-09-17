import 'package:flutter/material.dart';
import 'package:mini_projects/pokemon_app/features/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          centerTitle: true,
          color: Colors.black.withOpacity(0.5),
          elevation: 40,
        ),
      ),
      home: const HomePage(),
    );
  }
}
