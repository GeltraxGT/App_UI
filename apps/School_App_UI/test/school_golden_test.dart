import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app_ui/main.dart';

void main() {
  testWidgets('School home golden at 390x844', (tester) async {
    // Logical size 390x844: physical size is logical x devicePixelRatio.
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SchoolApp());
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(HomeShell),
      matchesGoldenFile('goldens/school_home_390x844.png'),
    );
  });
}
