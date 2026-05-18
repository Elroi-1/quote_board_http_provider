import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quote_board_http_provider/providers/quote_provider.dart';
import 'package:quote_board_http_provider/screens/home_screen.dart';

void main() {
  testWidgets('HomeScreen renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => QuoteProvider(),
        child: MaterialApp(home: HomeScreen()),
      ),
    );

    // Verify that HomeScreen loads (shows loading spinner or quote list)
    expect(find.byType(Scaffold), findsOneWidget);
  });
}
