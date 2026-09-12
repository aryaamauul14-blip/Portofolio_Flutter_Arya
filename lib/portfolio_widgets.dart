import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'portfolio_theme.dart';

class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).width < 600 ? 22 : 48,
        ),
        child: child,
      ),
    ),
  );
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color = Palette.muted});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) => Text(
    text.toUpperCase(),
    style: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w700,
      letterSpacing: 2,
      color: color,
    ),
  );
}

class Tag extends StatelessWidget {
  const Tag(this.label, {super.key, this.dark = false});

  final String label;
  final bool dark;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: dark ? Palette.white.withValues(alpha: 0.08) : Palette.paper,
      border: Border.all(
        color: dark ? Palette.white.withValues(alpha: 0.18) : Palette.line,
      ),
      borderRadius: BorderRadius.circular(7),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: dark ? Palette.white : Palette.muted,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

class Entrance extends StatelessWidget {
  const Entrance({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
    tween: Tween(begin: 0, end: 1),
    duration: motionDuration(context, 750),
    curve: Curves.easeOutCubic,
    builder:
        (context, value, child) => Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 22 * (1 - value)),
            child: child,
          ),
        ),
    child: child,
  );
}

class Brand extends StatelessWidget {
  const Brand({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Tooltip(
    message: 'Back to top',
    child: TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        alignment: Alignment.centerLeft,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Palette.blue,
              borderRadius: BorderRadius.circular(9),
            ),
            child: const Icon(
              Icons.north_east_rounded,
              color: Palette.white,
              size: 19,
            ),
          ),
          const SizedBox(width: 9),
          MediaQuery.withClampedTextScaling(
            maxScaleFactor: 1.2,
            child: Text('arya.', style: PortfolioTheme.display(25)),
          ),
        ],
      ),
    ),
  );
}

Future<void> copyContact(BuildContext context, String value) async {
  try {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Copied to clipboard.'),
          showCloseIcon: true,
        ),
      );
  } on PlatformException {
    if (!context.mounted) return;
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Copy this contact'),
            content: SelectableText(value),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
            ],
          ),
    );
  }
}

Future<void> openContact(BuildContext context, String address) async {
  try {
    if (await launchUrl(Uri.parse(address))) return;
  } on PlatformException {
    // The selectable fallback also works without a registered URL handler.
  }
  if (!context.mounted) return;
  showDialog<void>(
    context: context,
    builder:
        (dialogContext) => AlertDialog(
          title: const Text('Open this link'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('No app opened this link. You can copy it instead.'),
              const SizedBox(height: 12),
              SelectableText(address),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                copyContact(context, address);
              },
              child: const Text('Copy link'),
            ),
          ],
        ),
  );
}
