import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_ui/main.dart';

void main() {
  testWidgets('Learning golden at 390x844', (tester) async {
    // Logical size 390x844: physical size is logical x devicePixelRatio.
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const LearningApp());
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(LearningPage),
      matchesGoldenFile('goldens/learning_390x844.png'),
    );
  });
}
