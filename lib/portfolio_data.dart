import 'package:flutter/material.dart';

import 'portfolio_theme.dart';

enum ProjectKind { web, iot, game }

class PortfolioItem {
  const PortfolioItem({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.tech,
    required this.kind,
    required this.focus,
    required this.features,
  });

  final String title;
  final String subtitle;
  final String description;
  final List<String> tech;
  final ProjectKind kind;
  final String focus;
  final List<String> features;

  String get category => switch (kind) {
    ProjectKind.web => 'Web development',
    ProjectKind.iot => 'Internet of Things',
    ProjectKind.game => 'Game development',
  };

  Color get color => switch (kind) {
    ProjectKind.web => Palette.green,
    ProjectKind.iot => Palette.ocean,
    ProjectKind.game => Palette.purple,
  };

  Color get background => switch (kind) {
    ProjectKind.web => Palette.mint,
    ProjectKind.iot => Palette.ocean,
    ProjectKind.game => Palette.violet,
  };
}

abstract final class Profile {
  static const name = 'Naufal Arya Maulana';
  static const email = 'naufal.maulana@students.paramadina.ac.id';
  static const phone = '081292091767';
  static const github = 'https://github.com/aarz24';
  static const linkedIn =
      'https://www.linkedin.com/in/naufal-arya-maulana-4a2a31354';
  static const avatar = 'assets/Foto Profil Naufal Arya.jpeg';
  static const skills = [
    'Next.js',
    'Tailwind CSS',
    'Python',
    'C for IoT',
    'Figma',
  ];
}

const portfolioItems = [
  PortfolioItem(
    title: 'ZeroSampah',
    subtitle: 'Less waste. More possibility.',
    description:
        'A community-based waste management system integrated with Gemini AI '
        'to help communities sort, monitor, and improve waste handling.',
    tech: ['Next.js', 'Tailwind CSS', 'TypeScript', 'Clerk', 'Supabase'],
    kind: ProjectKind.web,
    focus: 'Technology for a cleaner everyday life.',
    features: [
      'Community-based waste management',
      'AI-assisted waste sorting with Gemini',
      'Monitoring to improve waste handling',
    ],
  ),
  PortfolioItem(
    title: 'IoT For Flood Warning System',
    subtitle: 'A little warning goes a long way.',
    description:
        'A canal level monitoring system that detects rising water levels and '
        'sends messages to users before flooding happens.',
    tech: ['Arduino IDE', 'Grafana', 'InfluxDB', 'HiveMQTT'],
    kind: ProjectKind.iot,
    focus: 'Making connected devices work for people.',
    features: [
      'Canal water-level monitoring',
      'Detection of rising water levels',
      'Early warning messages for users',
    ],
  ),
  PortfolioItem(
    title: 'Infinite Running Game',
    subtitle: 'Keep running. Stay curious.',
    description:
        'A Subway Surfers inspired Unity game set in a city destroyed by dragons '
        'where players collect points and avoid obstacles.',
    tech: ['Unity', 'C language'],
    kind: ProjectKind.game,
    focus: 'Learning through a world of play.',
    features: [
      'An endless run through a dragon-destroyed city',
      'Points to collect along the way',
      'Obstacles that keep players on their toes',
    ],
  ),
];
