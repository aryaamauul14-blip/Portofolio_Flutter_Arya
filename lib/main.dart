import 'package:flutter/material.dart';
import 'package:praktikum/portfolio_theme.dart';
import 'package:praktikum/profil_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Arya — Curiosity into code',
      theme: PortfolioTheme.light,
      home: const ProfilPage(),
    );
  }
}
