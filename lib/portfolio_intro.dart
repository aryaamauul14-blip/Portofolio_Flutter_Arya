import 'package:flutter/material.dart';

import 'portfolio_data.dart';
import 'portfolio_theme.dart';
import 'portfolio_widgets.dart';
import 'project_art.dart';

class PortfolioIntro extends StatelessWidget {
  const PortfolioIntro({
    super.key,
    required this.onWork,
    required this.onContact,
  });
  final VoidCallback onWork;
  final VoidCallback onContact;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final compact = constraints.maxWidth < 760;
      final text = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Eyebrow('Informatics student · Jakarta, ID'),
          const SizedBox(height: 24),
          Text(
            "Hi, I'm Arya",
            style: TextStyle(
              color: Palette.ink,
              fontSize: compact ? 19 : 21,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 13),
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: 'Turning curiosity\ninto things '),
                TextSpan(
                  text: 'that work.',
                  style: TextStyle(
                    color: Palette.blue,
                    decoration: TextDecoration.underline,
                    decorationColor: Palette.blue.withValues(alpha: 0.24),
                    decorationThickness: 2,
                  ),
                ),
              ],
            ),
            style: PortfolioTheme.display(
              compact
                  ? (constraints.maxWidth < 370 ? 42 : 52)
                  : (constraints.maxWidth < 1000 ? 54 : 64),
            ),
          ),
          const SizedBox(height: 23),
          const SizedBox(
            width: 425,
            child: Text(
              'I explore the space between web, connected devices, and playful '
              'digital experiences. One project at a time.',
              style: TextStyle(fontSize: 16, height: 1.8),
            ),
          ),
          const SizedBox(height: 30),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(
                onPressed: onWork,
                icon: const Icon(Icons.arrow_downward, size: 17),
                iconAlignment: IconAlignment.end,
                label: const Text('Explore my work'),
              ),
              OutlinedButton.icon(
                onPressed: onContact,
                icon: const Icon(Icons.north_east, size: 17),
                iconAlignment: IconAlignment.end,
                label: const Text('Get in touch'),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Container(width: 28, height: 1, color: Palette.muted),
              const SizedBox(width: 12),
              const Flexible(
                child: Text(
                  'Always learning. Always building.',
                  style: TextStyle(fontSize: 12, color: Palette.muted),
                ),
              ),
            ],
          ),
        ],
      );
      return Padding(
        padding: EdgeInsets.only(top: compact ? 40 : 64, bottom: 58),
        child:
            compact
                ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    text,
                    const SizedBox(height: 42),
                    const Center(child: _Portrait()),
                  ],
                )
                : Row(
                  children: [
                    Expanded(flex: 6, child: text),
                    const SizedBox(width: 30),
                    const Expanded(flex: 5, child: _Portrait()),
                  ],
                ),
      );
    },
  );
}

class _Portrait extends StatelessWidget {
  const _Portrait();

  @override
  Widget build(BuildContext context) => MediaQuery.withClampedTextScaling(
    maxScaleFactor: 1,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 440),
      child: AspectRatio(
        aspectRatio: 0.94,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: width * 0.10,
                  left: width * 0.04,
                  right: width * 0.03,
                  bottom: width * 0.10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Palette.sky,
                      borderRadius: BorderRadius.circular(width * 0.35),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: width * 0.035,
                  bottom: width * 0.025,
                  child: Transform.rotate(
                    angle: -0.22,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Palette.blue.withValues(alpha: 0.18),
                        ),
                        borderRadius: BorderRadius.circular(width * 0.5),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: width * 0.16,
                  right: width * 0.14,
                  top: width * 0.09,
                  bottom: width * 0.09,
                  child: Transform.rotate(
                    angle: 0.055,
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        color: Palette.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Palette.ink.withValues(alpha: 0.09),
                            blurRadius: 30,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(11),
                              child: Image.asset(
                                Profile.avatar,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                alignment: const Alignment(0, -0.62),
                                semanticLabel:
                                    'Portrait of Naufal Arya Maulana',
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 11, bottom: 3),
                            child: Text(
                              Profile.name,
                              style: PortfolioTheme.display(width * 0.031),
                            ),
                          ),
                          const Text(
                            'a human behind the code',
                            style: TextStyle(
                              fontSize: 10,
                              color: Palette.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Transform.rotate(
                    angle: 0.1,
                    child: const SizedBox(
                      width: 63,
                      height: 63,
                      child: CustomPaint(painter: StarPainter()),
                    ),
                  ),
                ),
                Positioned(
                  top: width * 0.13,
                  left: -3,
                  child: Transform.rotate(
                    angle: -0.07,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Palette.ink,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '<developer>',
                            style: TextStyle(
                              fontSize: 11,
                              color: Palette.water,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '  code. learn.\n  repeat.',
                            style: TextStyle(
                              fontSize: 11,
                              color: Palette.white,
                              height: 1.6,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '</developer>',
                            style: TextStyle(
                              fontSize: 11,
                              color: Palette.water,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: width * 0.08,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.white,
                      border: Border.all(color: Palette.line),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Palette.blue,
                          size: 16,
                        ),
                        SizedBox(width: 7),
                        Text(
                          'Jakarta, Indonesia',
                          style: TextStyle(fontSize: 11, color: Palette.ink),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    ),
  );
}

class ToolStrip extends StatelessWidget {
  const ToolStrip({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(vertical: 22),
    decoration: const BoxDecoration(
      border: Border.symmetric(horizontal: BorderSide(color: Palette.line)),
    ),
    child: ContentWidth(
      child: Wrap(
        spacing: 33,
        runSpacing: 20,
        alignment: WrapAlignment.spaceBetween,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Text(
            'A FEW TOOLS I BUILD WITH',
            style: TextStyle(
              fontSize: 9,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w600,
            ),
          ),
          for (final item in [
            (Icons.code, 'Next.js'),
            (Icons.waves, 'Tailwind CSS'),
            (Icons.data_object, 'Python'),
            (Icons.memory, 'Arduino'),
            (Icons.design_services_outlined, 'Figma'),
          ])
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(item.$1, color: Palette.muted, size: 19),
                const SizedBox(width: 9),
                Flexible(
                  child: Text(
                    item.$2,
                    style: const TextStyle(
                      color: Palette.muted,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    ),
  );
}
