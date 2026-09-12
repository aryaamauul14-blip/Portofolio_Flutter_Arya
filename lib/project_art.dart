import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'portfolio_data.dart';
import 'portfolio_theme.dart';
import 'portfolio_widgets.dart';

class ProjectArt extends StatelessWidget {
  const ProjectArt({super.key, required this.project});

  final PortfolioItem project;

  @override
  Widget build(BuildContext context) => Semantics(
    label: '${project.title} concept illustration',
    image: true,
    child: ExcludeSemantics(
      child: MediaQuery.withClampedTextScaling(
        maxScaleFactor: 1,
        child: AspectRatio(
          aspectRatio: 1.45,
          child: ClipRect(
            child: ColoredBox(
              color: project.background,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: 406,
                  height: 280,
                  child: switch (project.kind) {
                    ProjectKind.web => const _WasteArt(),
                    ProjectKind.iot => const _FloodArt(),
                    ProjectKind.game => const _GameArt(),
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

class _WasteArt extends StatelessWidget {
  const _WasteArt();

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      Positioned(
        right: -28,
        top: -40,
        child: Container(
          width: 210,
          height: 210,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Palette.green.withValues(alpha: 0.10),
              width: 40,
            ),
          ),
        ),
      ),
      Positioned(
        left: 30,
        top: 25,
        child: Row(
          children: [
            const Icon(Icons.recycling, color: Palette.green, size: 21),
            const SizedBox(width: 7),
            Text(
              'zerosampah',
              style: PortfolioTheme.display(15, color: Palette.green),
            ),
          ],
        ),
      ),
      Positioned(
        top: 71,
        left: 30,
        child: Text(
          'Small actions.\nA greener tomorrow.',
          style: PortfolioTheme.display(27, color: Palette.green),
        ),
      ),
      Positioned(
        left: 37,
        right: 37,
        bottom: 25,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bin('ORGANIC', Palette.green, 81, Icons.eco_outlined),
            _bin('RECYCLE', Palette.lime, 101, Icons.recycling),
            _bin('RESIDUAL', Palette.white, 71, Icons.delete_outline),
          ],
        ),
      ),
    ],
  );

  Widget _bin(
    String label,
    Color color,
    double height,
    IconData icon,
  ) => Transform.rotate(
    angle: label == 'ORGANIC' ? -0.08 : (label == 'RESIDUAL' ? 0.08 : 0),
    child: Column(
      children: [
        Container(
          width: 81,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 3),
        Container(
          width: 73,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 27,
                color: color == Palette.green ? Palette.mint : Palette.green,
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: TextStyle(
                  fontSize: 7,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w700,
                  color: color == Palette.green ? Palette.mint : Palette.green,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _FloodArt extends StatelessWidget {
  const _FloodArt();

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Positioned.fill(child: CustomPaint(painter: _WaterPainter())),
      const Positioned(
        left: 28,
        top: 25,
        child: Row(
          children: [
            Icon(Icons.waves_rounded, size: 22, color: Palette.water),
            SizedBox(width: 9),
            Eyebrow('Canal monitor', color: Palette.water),
          ],
        ),
      ),
      Positioned(
        top: 73,
        left: 28,
        child: Text(
          'Connected for\na safer tomorrow.',
          style: PortfolioTheme.display(27, color: Palette.white),
        ),
      ),
      const Positioned(
        bottom: 28,
        left: 28,
        child: Text(
          'SENSE  →  MONITOR  →  INFORM',
          style: TextStyle(
            fontSize: 9,
            letterSpacing: 1.8,
            color: Palette.water,
          ),
        ),
      ),
      Positioned(
        right: 28,
        top: 26,
        child: Icon(
          Icons.sensors_rounded,
          size: 27,
          color: Palette.water.withValues(alpha: 0.7),
        ),
      ),
    ],
  );
}

class _WaterPainter extends CustomPainter {
  const _WaterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final grid =
        Paint()
          ..color = Palette.water.withValues(alpha: 0.08)
          ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 27) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += 27) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final wave =
        Path()
          ..moveTo(0, 210)
          ..cubicTo(60, 245, 95, 151, 155, 183)
          ..cubicTo(223, 227, 235, 141, 300, 157)
          ..cubicTo(340, 170, 369, 121, 406, 129);
    canvas.drawPath(
      wave,
      Paint()
        ..color = Palette.water
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );
    final area =
        Path.from(wave)
          ..lineTo(406, 280)
          ..lineTo(0, 280)
          ..close();
    canvas.drawPath(
      area,
      Paint()..color = Palette.water.withValues(alpha: 0.09),
    );
    canvas.drawCircle(
      const Offset(300, 157),
      9,
      Paint()..color = Palette.water.withValues(alpha: 0.15),
    );
    canvas.drawCircle(
      const Offset(300, 157),
      4,
      Paint()..color = Palette.water,
    );
  }

  @override
  bool shouldRepaint(_WaterPainter oldDelegate) => false;
}

class _GameArt extends StatelessWidget {
  const _GameArt();

  @override
  Widget build(BuildContext context) => Stack(
    children: [
      const Positioned.fill(child: CustomPaint(painter: _GamePainter())),
      const Positioned(
        left: 28,
        top: 25,
        child: Row(
          children: [
            Icon(
              Icons.sports_esports_outlined,
              color: Palette.purple,
              size: 22,
            ),
            SizedBox(width: 8),
            Eyebrow('Infinite runner', color: Palette.purple),
          ],
        ),
      ),
      Positioned(
        left: 28,
        top: 71,
        child: Text(
          'One more run.',
          style: PortfolioTheme.display(32, color: Palette.purple),
        ),
      ),
      const Positioned(
        left: 28,
        top: 113,
        child: Text(
          'A world built for the next move.',
          style: TextStyle(fontSize: 11, color: Palette.purple),
        ),
      ),
    ],
  );
}

class _GamePainter extends CustomPainter {
  const _GamePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    canvas.drawCircle(
      const Offset(344, 69),
      26,
      paint..color = Palette.white.withValues(alpha: 0.65),
    );
    for (var i = 0; i < 11; i++) {
      final height = [53.0, 93.0, 68.0, 105.0, 75.0][i % 5];
      final x = i * 42.0 - 12;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 250 - height, 31, height),
          const Radius.circular(2),
        ),
        paint..color = Palette.purple.withValues(alpha: 0.12),
      );
      for (var row = 0; row < 4; row++) {
        canvas.drawRect(
          Rect.fromLTWH(x + 7, 260 - height + row * 15, 5, 5),
          paint..color = Palette.violet,
        );
      }
    }
    canvas.drawPath(
      Path()
        ..moveTo(166, 183)
        ..lineTo(237, 183)
        ..lineTo(385, 280)
        ..lineTo(23, 280)
        ..close(),
      paint..color = Palette.purple.withValues(alpha: 0.19),
    );
    paint
      ..color = Palette.white.withValues(alpha: 0.65)
      ..strokeWidth = 2;
    canvas.drawLine(const Offset(190, 195), const Offset(147, 280), paint);
    canvas.drawLine(const Offset(216, 195), const Offset(267, 280), paint);
    for (var i = 0; i < 3; i++) {
      canvas.drawCircle(
        Offset(214 + i * 15, 232 + i * 17),
        4.5 + i,
        paint..color = Palette.peach,
      );
    }
    paint
      ..color = Palette.purple
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    canvas.drawPath(
      Path()
        ..moveTo(194, 202)
        ..lineTo(184, 221)
        ..lineTo(165, 224)
        ..moveTo(187, 215)
        ..lineTo(205, 230)
        ..lineTo(200, 245)
        ..moveTo(190, 204)
        ..lineTo(201, 213)
        ..lineTo(212, 206),
      paint,
    );
    canvas.drawCircle(
      const Offset(196, 187),
      8,
      paint
        ..style = PaintingStyle.fill
        ..color = Palette.peach,
    );
    canvas.drawLine(
      const Offset(190, 201),
      const Offset(186, 215),
      paint
        ..color = Palette.blue
        ..strokeWidth = 14,
    );
    canvas.drawPath(
      Path()
        ..moveTo(289, 156)
        ..lineTo(301, 144)
        ..lineTo(319, 147)
        ..lineTo(310, 155)
        ..lineTo(328, 165)
        ..lineTo(306, 162)
        ..lineTo(299, 172)
        ..close(),
      paint..color = Palette.purple.withValues(alpha: 0.4),
    );
  }

  @override
  bool shouldRepaint(_GamePainter oldDelegate) => false;
}

class StarPainter extends CustomPainter {
  const StarPainter({this.color = Palette.blue});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    for (var i = 0; i < 16; i++) {
      final radius = size.width * (i.isEven ? 0.48 : 0.19);
      final angle = i * math.pi / 8;
      final point = center + Offset(math.cos(angle), math.sin(angle)) * radius;
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(path..close(), Paint()..color = color);
  }

  @override
  bool shouldRepaint(StarPainter oldDelegate) => color != oldDelegate.color;
}
