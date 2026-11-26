import 'package:flutter_test/flutter_test.dart';
import 'package:gallery_ui/main.dart';

void main() {
  testWidgets('Gallery screen shows every labelled section', (tester) async {
    await tester.pumpWidget(const GalleryApp());
    await tester.pumpAndSettle();

    expect(find.text('Gallery'), findsWidgets);
    expect(find.text('Get the Best Experience'), findsOneWidget);
    expect(find.text('Spotify'), findsOneWidget);
    expect(find.text('Apple Music'), findsOneWidget);
    expect(find.text('Seamlessly update playlists.'), findsOneWidget);
    expect(find.text('Collections'), findsOneWidget);
    expect(find.text('Summer'), findsWidgets);
    expect(find.text('Halloween'), findsOneWidget);
    expect(find.text('Free Artworks'), findsOneWidget);
    expect(find.text('No catches, just awesome covers.'), findsOneWidget);
    expect(find.text('SURF'), findsOneWidget);
    expect(find.text('ROCK'), findsOneWidget);
    expect(find.text('running\ntracks'), findsOneWidget);
    expect(find.text('EAST'), findsOneWidget);
    expect(find.text('COUNTRY'), findsOneWidget);
    expect(find.text('Recently Added'), findsOneWidget);
    expect(find.text('My Covers'), findsOneWidget);
  });
}
