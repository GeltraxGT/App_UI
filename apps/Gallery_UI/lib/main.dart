import 'package:flutter/material.dart';

void main() {
  runApp(const GalleryApp());
}

/// Gallery screen from the reference screenshot:
/// "Get the Best Experience", Connect Account (Spotify / Apple Music),
/// Collections (Summer / Halloween), Free Artworks, Recently Added,
/// with a floating bottom nav: My Covers / Gallery.
///
/// Layout is responsive, not hard-coded to one phone:
/// card widths are a fraction of the screen width, sections use
/// consistent 20px side padding and 12 / 16 / 24 / 28px spacing.
class GalleryApp extends StatelessWidget {
  const GalleryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gallery',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const GalleryPage(),
    );
  }
}

class GalleryPage extends StatefulWidget {
  const GalleryPage({super.key});

  @override
  State<GalleryPage> createState() => _GalleryPageState();
}

class _GalleryPageState extends State<GalleryPage> {
  int _selectedIndex = 1; // 0 = My Covers, 1 = Gallery (as in the screenshot)

  static const double _sidePadding = 20;
  static const double _cardGap = 12;

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildHeader(),
              const SizedBox(height: 24),

              // Get the Best Experience
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                child: Text(
                  'Get the Best Experience',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildConnectRow(screenWidth),
              const SizedBox(height: 28),

              // Collections
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                child: Text(
                  'Collections',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildCollectionsRow(screenWidth),
              const SizedBox(height: 28),

              // Free Artworks
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Free Artworks',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111111),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'No catches, just awesome covers.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6E6E6E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildFreeArtworksRow(),
              const SizedBox(height: 28),

              // Recently Added
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                child: Text(
                  'Recently Added',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111111),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildRecentlyAddedRow(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE5E5E5)),
              color: Colors.white,
            ),
            child: const Icon(Icons.settings, size: 20, color: Colors.black87),
          ),
          const Expanded(
            child: Text(
              'Gallery',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
          ),
          // Balances the 40px settings button so "Gallery" stays centred.
          const SizedBox(width: 40),
        ],
      ),
    );
  }

  Widget _buildConnectRow(double screenWidth) {
    final double cardWidth = screenWidth * 0.68;
    return SizedBox(
      height: 148,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
        children: [
          _ConnectCard(
            width: cardWidth,
            label: 'Spotify',
            labelColor: const Color(0xFF1DB954),
            iconColor: const Color(0xFF1DB954),
            description: 'Seamlessly update playlists.',
          ),
          const SizedBox(width: _cardGap),
          _ConnectCard(
            width: cardWidth,
            label: 'Apple Music',
            labelColor: Colors.black,
            iconColor: Colors.black,
            description: 'Create personalized playlists.',
          ),
        ],
      ),
    );
  }

  Widget _buildCollectionsRow(double screenWidth) {
    final double cardWidth = screenWidth * 0.72;
    return SizedBox(
      height: 180,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
        children: [
          _CollectionCard(
            width: cardWidth,
            height: 180,
            image: 'assets/images/summer.jpg',
            label: 'Summer',
          ),
          const SizedBox(width: _cardGap),
          _CollectionCard(
            width: cardWidth,
            height: 180,
            image: 'assets/images/halloween.jpg',
            label: 'Halloween',
          ),
        ],
      ),
    );
  }

  Widget _buildFreeArtworksRow() {
    return SizedBox(
      height: 150,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
        children: const [
          _SurfRockCard(),
          SizedBox(width: _cardGap),
          _RunningTracksCard(),
          SizedBox(width: _cardGap),
          _EastCountryCard(),
        ],
      ),
    );
  }

  Widget _buildRecentlyAddedRow() {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
        children: const [
          _RecentCard(
            image: 'assets/images/summer.jpg',
            label: 'Summer',
          ),
          SizedBox(width: _cardGap),
          _RecentCard(
            image: 'assets/images/surf_rock.jpg',
            label: 'Surf Rock',
          ),
          SizedBox(width: _cardGap),
          _RecentCard(
            image: 'assets/images/running_tracks.jpg',
            label: 'Running Tracks',
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: const [
            BoxShadow(
              color: Color(0x1F000000),
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: _NavItem(
                icon: Icons.grid_view_rounded,
                label: 'My Covers',
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
              ),
            ),
            Expanded(
              child: _NavItem(
                icon: Icons.photo_library_rounded,
                label: 'Gallery',
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConnectCard extends StatelessWidget {
  const _ConnectCard({
    required this.width,
    required this.label,
    required this.labelColor,
    required this.iconColor,
    required this.description,
  });

  final double width;
  final String label;
  final Color labelColor;
  final Color iconColor;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CONNECT ACCOUNT',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
              color: Color(0xFF8A8A8A),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: iconColor,
                ),
                child: const Icon(
                  Icons.music_note,
                  size: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontStyle:
                      label == 'Spotify' ? FontStyle.italic : FontStyle.normal,
                  color: labelColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _CollectionCard extends StatelessWidget {
  const _CollectionCard({
    required this.width,
    required this.height,
    required this.image,
    required this.label,
  });

  final double width;
  final double height;
  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(image, fit: BoxFit.cover),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0x66000000)],
                  stops: [0.55, 1.0],
                ),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 16,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SurfRockCard extends StatelessWidget {
  const _SurfRockCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/surf_rock.jpg', fit: BoxFit.cover),
            const Positioned(
              top: 12,
              left: 0,
              right: 0,
              child: Text(
                'SURF',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFD600),
                ),
              ),
            ),
            const Positioned(
              bottom: 12,
              left: 0,
              right: 0,
              child: Text(
                'ROCK',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFFFFD600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RunningTracksCard extends StatelessWidget {
  const _RunningTracksCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/running_tracks.jpg',
              fit: BoxFit.cover,
            ),
            const Center(
              child: Text(
                'running\ntracks',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// "EAST COUNTRY" — the third Free Artwork in the screenshot is only
/// partly visible (sunset sky over a green field). It is drawn here as
/// a sunset gradient cover with the title, not a generated photo.
class _EastCountryCard extends StatelessWidget {
  const _EastCountryCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFFF7B733),
            Color(0xFFE88A4A),
            Color(0xFF7A9A5A),
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'EAST',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            Text(
              'COUNTRY',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  const _RecentCard({required this.image, required this.label});

  final String image;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              image,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEDEDED) : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 22, color: Colors.black87),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
