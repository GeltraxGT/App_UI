import 'package:flutter/material.dart';

void main() {
  runApp(const LearningApp());
}

/// Learning home screen from the reference screenshot:
/// profile + search / bell, Jan 15 schedule card, "Let's talk right
/// now!" + 21:30 Hours spent, Active lessons, floating bottom nav.
///
/// Layout is responsive, not hard-coded to one phone: side-by-side
/// cards use Expanded, lesson titles use Expanded + wrapping, and
/// sections use consistent 20px side padding and 16 / 20px spacing.
class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const LearningPage(),
    );
  }
}

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int _selectedIndex = 0; // 0 home, 1 calendar, 2 lessons, 3 chat

  static const double _sidePadding = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildTopBar(),
              const SizedBox(height: 20),
              _buildDateCard(),
              const SizedBox(height: 16),
              _buildMiddleRow(),
              const SizedBox(height: 20),

              // Active lessons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'Active lessons',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Text(
                            'View all',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                child: _LessonCard(
                  title: 'Intro to Front-End Development',
                  meta: '28 lessons  •  17 hours',
                  image: 'assets/images/code_cube.jpg',
                  filledSegments: 15,
                  lessonsLeft: '5 lessons left',
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: _sidePadding),
                child: _LessonCard(
                  title: 'Startup & Product Development',
                  meta: '18 lessons  •  12 hours',
                  image: 'assets/images/startup.jpg',
                  filledSegments: 8,
                  lessonsLeft: '8 lessons left',
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage('assets/images/profile_avatar.jpg'),
          ),
          const Spacer(),
          _CircleIconButton(icon: Icons.search, onTap: () {}),
          const SizedBox(width: 12),
          _CircleIconButton(icon: Icons.notifications_outlined, onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildDateCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFCDE8A0),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 84,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jan 15',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF2E3A1F),
                    ),
                  ),
                  SizedBox(height: 72),
                  Text(
                    'Thursday',
                    style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF5A6B3F),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                children: const [
                  _ScheduleItem(
                    title: 'Intro to Front-End Development',
                    time: '09:15 – 11:45 AM',
                  ),
                  SizedBox(height: 8),
                  _ScheduleItem(
                    title: 'Digital Product Creation',
                    time: '12:45 – 03:00 PM',
                  ),
                  SizedBox(height: 8),
                  Opacity(
                    opacity: 0.45,
                    child: _ScheduleItem(
                      title: 'Startup & Product Development',
                      time: '03:30 – 05:00 PM',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMiddleRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: _sidePadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildChatCard()),
          const SizedBox(width: 12),
          Expanded(child: _buildHoursCard()),
        ],
      ),
    );
  }

  Widget _buildChatCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDE8F0),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/chat_bubbles.jpg',
              height: 96,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Let's talk right now!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Start chat'),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB9D2F5), Color(0xFF7FB0E8)],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '21:30',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1F2A44),
            ),
          ),
          const Text(
            'Hours spent',
            style: TextStyle(fontSize: 14, color: Color(0xFF3D4E6B)),
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: SizedBox(
              width: 72,
              height: 72,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: CircularProgressIndicator(
                      value: 0.75,
                      strokeWidth: 6,
                      backgroundColor: Colors.white.withValues(alpha: 0.4),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Color(0xFF2563EB),
                      ),
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Icon(
                      Icons.schedule,
                      size: 24,
                      color: Color(0xFF2563EB),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    const icons = [
      Icons.home_outlined,
      Icons.calendar_today_outlined,
      Icons.menu_book_outlined,
      Icons.chat_bubble_outline,
    ];
    const labels = ['Home', 'Calendar', 'Lessons', 'Chat'];
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
          children: List.generate(icons.length, (index) {
            final selected = _selectedIndex == index;
            return Expanded(
              child: InkWell(
                onTap: () => setState(() => _selectedIndex = index),
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected
                        ? const Color(0xFFEDEDED)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(
                    icons[index],
                    size: 24,
                    color: Colors.black87,
                    semanticLabel: labels[index],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  const _CircleIconButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: const Color(0xFFEDEDED)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Icon(icon, size: 22, color: Colors.black87),
      ),
    );
  }
}

class _ScheduleItem extends StatelessWidget {
  const _ScheduleItem({required this.title, required this.time});

  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: const Border(
          left: BorderSide(color: Color(0xFFF472B6), width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 2),
          Text(
            time,
            style: const TextStyle(fontSize: 13, color: Color(0xFF6E6E6E)),
          ),
        ],
      ),
    );
  }
}

class _LessonCard extends StatelessWidget {
  const _LessonCard({
    required this.title,
    required this.meta,
    required this.image,
    required this.filledSegments,
    required this.lessonsLeft,
  });

  final String title;
  final String meta;
  final String image;
  final int filledSegments;
  final String lessonsLeft;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F7),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _AvatarStack(),
                    const SizedBox(height: 12),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      meta,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6E6E6E),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  image,
                  width: 104,
                  height: 104,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: List.generate(20, (index) {
                    return Expanded(
                      child: Container(
                        height: 20,
                        margin: const EdgeInsets.symmetric(horizontal: 1.5),
                        decoration: BoxDecoration(
                          color: index < filledSegments
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFE5E5E5),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                lessonsLeft,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Overlapping learner avatars. The reference shows photos; here they
/// are coloured initial circles, so no extra faces are invented.
class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  @override
  Widget build(BuildContext context) {
    const avatars = [
      ('A', Color(0xFF34D399)),
      ('J', Color(0xFFFBBF24)),
      ('M', Color(0xFFF472B6)),
    ];
    return SizedBox(
      height: 28,
      child: Stack(
        children: List.generate(avatars.length, (index) {
          final (letter, color) = avatars[index];
          return Positioned(
            left: index * 20,
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                border: Border.all(color: Colors.white, width: 2),
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
