import 'package:flutter_test/flutter_test.dart';
import 'package:automate/main.dart';

void main() {
  testWidgets('AutoMate app renders', (WidgetTester tester) async {
    await tester.pumpWidget(const AutoMateApp());
    expect(find.text('AutoMate'), findsWidgets);
  });
}
