import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter_create_lab5_note_app/main.dart';
import 'package:flutter_create_lab5_note_app/providers/note_provider.dart';
import 'package:flutter_create_lab5_note_app/providers/settings_provider.dart';

void main() {
  testWidgets('Kiểm tra giao diện chính', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => NoteProvider()),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
        ],
        child: const MyApp(),
      ),
    );

    expect(find.text('Ghi chú'), findsOneWidget);
    
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}
