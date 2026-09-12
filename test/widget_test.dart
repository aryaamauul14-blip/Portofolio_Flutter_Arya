import 'package:flutter_test/flutter_test.dart';

import 'package:praktikum/main.dart';

void main() {
  testWidgets('Portfolio app shows profile content', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Naufal Arya Maulana'), findsWidgets);
    expect(find.text('About Me'), findsOneWidget);
    expect(find.text('Porto'), findsOneWidget);
    expect(find.text('Contact'), findsOneWidget);
  });
}
