// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bjj_drills/main.dart';

void main() {
  testWidgets('BJJ Drills app smoke test', (WidgetTester tester) async {
    // Set a larger screen size to avoid overflow issues
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BJJDrillsApp());

    // Verify that our app shows the welcome message.
    expect(find.text('Welcome to BJJ Drills!'), findsOneWidget);
    expect(find.text('Hello World!'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    
    // Verify that the tab navigation is present
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Drills List'), findsOneWidget);
    
    // Verify the app can be built without errors
    expect(find.byType(BJJDrillsApp), findsOneWidget);
  });
}
