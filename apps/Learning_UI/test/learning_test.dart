import 'package:flutter_test/flutter_test.dart';
import 'package:learning_ui/main.dart';

void main() {
  testWidgets('Learning screen shows every labelled section', (tester) async {
    await tester.pumpWidget(const LearningApp());
    await tester.pumpAndSettle();

    expect(find.text('Jan 15'), findsOneWidget);
    expect(find.text('Thursday'), findsOneWidget);
    expect(find.text('Intro to Front-End Development'), findsWidgets);
    expect(find.text('09:15 – 11:45 AM'), findsOneWidget);
    expect(find.text('Digital Product Creation'), findsOneWidget);
    expect(find.text('12:45 – 03:00 PM'), findsOneWidget);
    expect(find.text("Let's talk right now!"), findsOneWidget);
    expect(find.text('Start chat'), findsOneWidget);
    expect(find.text('21:30'), findsOneWidget);
    expect(find.text('Hours spent'), findsOneWidget);
    expect(find.text('Active lessons'), findsOneWidget);
    expect(find.text('View all'), findsOneWidget);
    expect(find.text('28 lessons  •  17 hours'), findsOneWidget);
    expect(find.text('5 lessons left'), findsOneWidget);
    expect(find.text('Startup & Product Development'), findsWidgets);
  });
}
