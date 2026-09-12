import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum/main.dart';
import 'package:praktikum/new_form.dart';
import 'package:praktikum/portfolio_data.dart';
import 'package:praktikum/portfolio_widgets.dart';

void main() {
  final clipboardCalls = <MethodCall>[];
  setUp(() {
    clipboardCalls.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, (call) async {
          if (call.method == 'Clipboard.setData') clipboardCalls.add(call);
          return null;
        });
  });
  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(SystemChannels.platform, null);
  });
  for (final size in [
    const Size(360, 800),
    const Size(800, 900),
    const Size(1440, 1000),
  ]) {
    testWidgets('Sections and every project remain usable at $size', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(const MyApp());
      await tester.pumpAndSettle();
      expect(tester.takeException(), isNull);

      await tester.tap(find.text('Porto'));
      await tester.pumpAndSettle();
      for (final pair in [
        ('Web', portfolioItems[0]),
        ('IoT', portfolioItems[1]),
        ('Game', portfolioItems[2]),
      ]) {
        await tester.ensureVisible(find.widgetWithText(ChoiceChip, pair.$1));
        await tester.tap(find.widgetWithText(ChoiceChip, pair.$1));
        await tester.pumpAndSettle();
        expect(find.text('View project'), findsOneWidget);
        expect(find.text(pair.$2.title), findsOneWidget);
        await tester.ensureVisible(find.text('View project'));
        await tester.tap(find.text('View project'));
        await tester.pumpAndSettle();
        expect(find.byType(NewForm), findsOneWidget);
        expect(find.text(pair.$2.description), findsOneWidget);
        await tester.ensureVisible(find.text('Back to all projects'));
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull);
        await tester.tap(find.text('Back to all projects'));
        await tester.pumpAndSettle();
        expect(find.widgetWithText(ChoiceChip, pair.$1), findsOneWidget);
        expect(find.text('View project'), findsOneWidget);
      }
      await tester.tap(find.text('Porto'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(ChoiceChip, 'All work'));
      await tester.pumpAndSettle();
      expect(find.text('View project'), findsNWidgets(3));
      await tester.tap(find.text('About Me'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('123103124'));
      expect(find.text('123103124').hitTestable(), findsOneWidget);
      await tester.tap(find.text('Contact'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Copy email'));
      await tester.tap(find.text('Copy email'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(find.text('Copied to clipboard.'), findsOneWidget);
      expect(clipboardCalls.last.arguments, {'text': Profile.email});
      expect(tester.takeException(), isNull);
      await tester.tap(find.byTooltip('Close'));
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.text('Back to top'));
      await tester.tap(find.text('Back to top'));
      await tester.pumpAndSettle();
      expect(find.text("Hi, I'm Arya").hitTestable(), findsOneWidget);
    });
  }

  testWidgets('Phone layout supports enlarged text and reduced motion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder:
            (context, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: const TextScaler.linear(2),
                disableAnimations: true,
              ),
              child: child!,
            ),
        home: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.tap(find.text('Porto'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    await tester.ensureVisible(find.text('View project').first);
    await tester.tap(find.text('View project').first);
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Back to all projects'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Back to all projects'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Back to top'));
    await tester.pumpAndSettle();
    expect(find.text("Hi, I'm Arya").hitTestable(), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Contact launcher exposes a selectable fallback on failure', (
    tester,
  ) async {
    const channel = MethodChannel('plugins.flutter.io/url_launcher');
    final calls = <MethodCall>[];
    tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(channel, (
      call,
    ) async {
      calls.add(call);
      throw PlatformException(code: 'unavailable');
    });
    addTearDown(
      () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        channel,
        null,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder:
                (context) => TextButton(
                  onPressed: () => openContact(context, Profile.github),
                  child: const Text('Open GitHub'),
                ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('Open GitHub'));
    await tester.pumpAndSettle();
    expect(calls, isNotEmpty);
    expect(find.text('Open this link'), findsOneWidget);
    expect(find.text(Profile.github), findsOneWidget);
    await tester.tap(find.text('Copy link'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.text('Copied to clipboard.'), findsOneWidget);
    expect(clipboardCalls.last.arguments, {'text': Profile.github});
  });
}
