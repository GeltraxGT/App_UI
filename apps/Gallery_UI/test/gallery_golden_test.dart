import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_ui/main.dart';

void main() {
  testWidgets('Gallery golden at 390x844', (tester) async {
    // Logical size 390x844: physical size is logical x devicePixelRatio.
    tester.view.physicalSize = const Size(780, 1688);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const GalleryApp());
    await tester.pumpAndSettle();
    await expectLater(
      find.byType(GalleryPage),
      matchesGoldenFile('goldens/gallery_390x844.png'),
    );
  });
}
