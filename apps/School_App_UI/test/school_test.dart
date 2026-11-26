import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:school_app_ui/main.dart';

/// Phone-sized test viewport (390x844 logical, 2x DPR), like the
/// reference screenshots.
Future<void> pumpSchoolApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(780, 1688);
  tester.view.devicePixelRatio = 2.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);
  await tester.pumpWidget(const SchoolApp());
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Home screen loads with greeting and quick actions',
      (tester) async {
    await pumpSchoolApp(tester);

    expect(find.text('Good Morning,'), findsOneWidget);
    expect(find.text('Mrs. Singh'), findsOneWidget);
    expect(find.text("Riya's School Dashboard"), findsOneWidget);
    expect(find.text('Riya Singh'), findsOneWidget);
    expect(find.text('Class 8 • Section A'), findsOneWidget);
    expect(find.text('Attendance'), findsOneWidget);
    expect(find.text('Grades'), findsOneWidget);
    expect(find.text('Homework'), findsOneWidget);
    expect(find.text('Timetable'), findsOneWidget);
    expect(find.text('Fees'), findsOneWidget);
    // 'Messages' is both a Home tile and a bottom-nav label.
    expect(find.text('Messages'), findsWidgets);
    expect(find.text('Circulars'), findsOneWidget);
    expect(find.text('Events'), findsOneWidget);
    expect(find.text('More'), findsOneWidget);
  });

  testWidgets('Bottom navigation switches between the five tabs',
      (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('Academics'));
    await tester.pumpAndSettle();
    expect(find.text('Grades & Results'), findsOneWidget);
    expect(find.text('Study Material'), findsOneWidget);

    await tester.tap(find.text('School'));
    await tester.pumpAndSettle();
    expect(find.text('More Services'), findsOneWidget);
    expect(find.text('Transport'), findsOneWidget);
    expect(find.text('Leave Request'), findsOneWidget);

    await tester.tap(find.text('Messages'));
    await tester.pumpAndSettle();
    expect(find.text('Maths Teacher'), findsOneWidget);
    expect(find.text('School Admin'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    expect(find.text('My Children'), findsOneWidget);
    expect(find.text('Help & Support'), findsOneWidget);

    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();
    expect(find.text('Mrs. Singh'), findsOneWidget);
  });

  testWidgets('Attendance screen is reachable from the Home tile',
      (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('Attendance'));
    await tester.pumpAndSettle();
    expect(find.text('November 2026'), findsOneWidget);
    expect(find.text('92%'), findsOneWidget);
    expect(find.text('22 / 24'), findsOneWidget);
    expect(find.text('Days Present'), findsOneWidget);
    expect(find.text('Present (22)'), findsOneWidget);
    expect(find.text('Absent (2)'), findsOneWidget);
    expect(find.text('Holiday (6)'), findsOneWidget);
    expect(
      find.text('Last Absent: 21 Nov (Medical Leave)'),
      findsOneWidget,
    );

    // Back returns to Home.
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mrs. Singh'), findsOneWidget);
  });

  testWidgets('Fees screen is reachable from the Home tile',
      (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('Fees'));
    await tester.pumpAndSettle();
    expect(find.text('Fees & Payments'), findsWidgets);
    expect(find.text('₹12,500'), findsOneWidget);
    expect(find.text('Total Fee (Term 2)'), findsOneWidget);
    expect(find.text('Pay Now'), findsOneWidget);
    expect(find.text('Fee Summary'), findsOneWidget);
    expect(find.text('Payment History'), findsOneWidget);
    expect(find.text('Download Receipt'), findsOneWidget);
    expect(find.text('Fee Calendar'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mrs. Singh'), findsOneWidget);
  });

  testWidgets('Timetable screen is reachable from the Home tile',
      (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('Timetable'));
    await tester.pumpAndSettle();
    expect(find.text('Mathematics'), findsOneWidget);
    expect(find.text('Room 201'), findsOneWidget);
    expect(find.text('Science'), findsOneWidget);
    expect(find.text('English'), findsOneWidget);
    expect(find.text('Social Science'), findsOneWidget);
    expect(find.text('Hindi'), findsOneWidget);
    expect(find.text('Computer'), findsOneWidget);
    expect(find.text('Lab 1'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mrs. Singh'), findsOneWidget);
  });

  testWidgets('Announcements screen is reachable from the Circulars tile',
      (tester) async {
    await pumpSchoolApp(tester);

    // The third row of quick actions starts below the fold; scroll it
    // into view before tapping.
    await tester.ensureVisible(find.text('Circulars'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Circulars'));
    await tester.pumpAndSettle();
    expect(find.text('PTM Notice'), findsOneWidget);
    expect(find.text('Annual Day'), findsOneWidget);
    expect(find.text('Winter Uniform'), findsOneWidget);
    expect(find.text('Holiday Notice'), findsOneWidget);
    // The time sits inside the notice subtitle line.
    expect(find.textContaining('14h ago'), findsOneWidget);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Mrs. Singh'), findsOneWidget);
  });

  testWidgets('Academics rows open their detail pages', (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('Grades'));
    await tester.pumpAndSettle();
    expect(find.text('Grades & Results'), findsWidgets);

    await tester.tap(find.text('Homework'));
    await tester.pumpAndSettle();
    expect(find.text('Assignments from teachers'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Syllabus'));
    await tester.pumpAndSettle();
    expect(find.text('Subject-wise syllabus'), findsWidgets);
  });

  testWidgets('Messages open a chat thread', (tester) async {
    await pumpSchoolApp(tester);

    // 'Messages' is both a Home tile and a bottom-nav label; the tile
    // comes first in the tree.
    await tester.tap(find.text('Messages').first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Maths Teacher'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Homework for Chapter 7'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(find.text('Maths Teacher'), findsOneWidget);
  });

  testWidgets('More Services tiles open their detail pages',
      (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('School'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Events'));
    await tester.pumpAndSettle();
    expect(find.text('School events & activities'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Gallery'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Gallery'));
    await tester.pumpAndSettle();
    expect(find.text('School photos & albums'), findsWidgets);
  });

  testWidgets('Profile rows open their detail pages', (tester) async {
    await pumpSchoolApp(tester);

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('My Children'));
    await tester.pumpAndSettle();
    expect(find.text('Manage linked students'), findsWidgets);

    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Documents'));
    await tester.pumpAndSettle();
    expect(find.text('ID card, receipts, certificates'), findsWidgets);
  });
}
