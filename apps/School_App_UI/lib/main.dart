import 'package:flutter/material.dart';

void main() {
  runApp(const SchoolApp());
}

/// Simpedu School ERP — parent app UI, rebuilt from the reference design.
///
/// 9 screens: Home, Academics, Attendance, Fees & Payments, Timetable,
/// Announcements, Messages, More Services, Profile. Bottom nav has 5 tabs
/// (Home, Academics, School, Messages, Profile); the School tab opens
/// More Services. All sample data is exactly what the reference shows.
///
/// Style: warm cream paper background, soft sage-green accent, rounded
/// cards (16-20px), gentle shadows. Material Icons only. The four
/// illustrations in assets/images are watercolor-style AI illustrations.
class SchoolApp extends StatelessWidget {
  const SchoolApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpedu School ERP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.paper,
        colorScheme: const ColorScheme.light(
          primary: AppColors.sageDark,
          secondary: AppColors.sage,
          surface: AppColors.card,
          onPrimary: Colors.white,
          onSurface: AppColors.ink,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.paper,
          foregroundColor: AppColors.ink,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.ink,
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.card,
          selectedItemColor: AppColors.sageDark,
          unselectedItemColor: AppColors.muted,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          unselectedLabelStyle:
              TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          elevation: 8,
        ),
      ),
      home: const HomeShell(),
    );
  }
}

class AppColors {
  static const paper = Color(0xFFFBF6EC);
  static const card = Color(0xFFFFFFFF);
  static const ink = Color(0xFF2B2620);
  static const muted = Color(0xFF8A7F70);
  static const sage = Color(0xFF7A9B76);
  static const sageDark = Color(0xFF5F7F5B);
  static const sageSoft = Color(0xFFE7EFE3);
  static const amber = Color(0xFFD99A2B);
  static const amberSoft = Color(0xFFFBF0D3);
  static const rose = Color(0xFFD96C4F);
  static const roseSoft = Color(0xFFFBE3DC);
  static const blue = Color(0xFF5B7DB8);
  static const blueSoft = Color(0xFFE3EBF7);
  static const teal = Color(0xFF4E9A8F);
  static const tealSoft = Color(0xFFDFF0EC);
  static const violet = Color(0xFF7C6BB5);
  static const violetSoft = Color(0xFFEDE7F6);
  static const pink = Color(0xFFC96A8B);
  static const pinkSoft = Color(0xFFFBE7EF);
  static const line = Color(0xFFE5DCCB);
}

typedef PushPage = void Function(Widget page);

/// The 5-tab shell. School tab opens More Services.
class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0; // 0 home, 1 academics, 2 school, 3 messages, 4 profile

  void _selectTab(int index) => setState(() => _index = index);

  void _push(Widget page) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      HomeScreen(onSelectTab: _selectTab, onPush: _push),
      AcademicsScreen(onPush: _push),
      MoreServicesScreen(onPush: _push),
      MessagesScreen(onPush: _push),
      ProfileScreen(onPush: _push),
    ];
    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: _selectTab,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_outlined), label: 'Academics'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school_outlined), label: 'School'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'Messages'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}

/// Small tinted icon tile used in rows and grids.
Widget iconTile(IconData icon, Color color, Color bg, {double size = 48}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Icon(icon, color: color, size: 24),
  );
}

/// A white card row: leading widget, title + subtitle, chevron. Taps open
/// the matching screen.
class RowCard extends StatelessWidget {
  const RowCard({
    super.key,
    required this.leading,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  final Widget leading;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                leading,
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: AppColors.muted),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Rounded filter chips (All / Teachers / School, ...).
class FilterChips extends StatelessWidget {
  const FilterChips({
    super.key,
    required this.options,
    required this.selected,
    required this.onSelected,
  });

  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((option) {
        final isSelected = option == selected;
        return ChoiceChip(
          label: Text(option),
          selected: isSelected,
          onSelected: (_) => onSelected(option),
          selectedColor: AppColors.sage,
          backgroundColor: AppColors.card,
          labelStyle: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColors.ink,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.sage : AppColors.line,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          showCheckmark: false,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        );
      }).toList(),
    );
  }
}

/// Detail page for rows that have no dedicated screen yet. Shows only the
/// title and subtitle from the reference — no invented data.
class SimpleDetailScreen extends StatelessWidget {
  const SimpleDetailScreen({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 15, color: AppColors.muted),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.sageSoft,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.info_outline, color: AppColors.sageDark),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.ink,
                      ),
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
}

/// Rounded hero image used at the top of several screens.
Widget heroImage(String asset, double height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.asset(
      asset,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
    ),
  );
}

const double sidePadding = 20;

/// Screen 1 — Home. Greeting, hero illustration, student card, 9 quick
/// actions. Tiles open the matching screen; Grades / Messages / Events /
/// More switch to the matching tab.
class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.onSelectTab,
    required this.onPush,
  });

  final ValueChanged<int> onSelectTab;
  final PushPage onPush;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'S',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Simpedu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.ink,
                      ),
                    ),
                    Text(
                      'School ERP',
                      style: TextStyle(fontSize: 12, color: AppColors.muted),
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => onPush(const AnnouncementsScreen()),
                  icon: const Icon(Icons.notifications_outlined),
                  color: AppColors.ink,
                ),
                const CircleAvatar(
                  radius: 20,
                  backgroundImage:
                      AssetImage('assets/images/girl_portrait.webp'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style:
                            TextStyle(fontSize: 16, color: AppColors.muted),
                      ),
                      Text(
                        'Mrs. Singh',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Riya's School Dashboard",
                        style:
                            TextStyle(fontSize: 14, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: const BoxDecoration(
                    color: AppColors.amberSoft,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.wb_sunny,
                    color: AppColors.amber,
                    size: 32,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            heroImage('assets/images/girl_backpack.webp', 150),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage:
                        AssetImage('assets/images/girl_portrait.webp'),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riya Singh',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Class 8 • Section A',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 14,
              crossAxisSpacing: 8,
              childAspectRatio: 1.1,
              children: [
                _QuickAction(
                  icon: Icons.check_circle_outline,
                  color: AppColors.sageDark,
                  bg: AppColors.sageSoft,
                  label: 'Attendance',
                  onTap: () => onPush(const AttendanceScreen()),
                ),
                _QuickAction(
                  icon: Icons.grade_outlined,
                  color: AppColors.amber,
                  bg: AppColors.amberSoft,
                  label: 'Grades',
                  onTap: () => onSelectTab(1),
                ),
                _QuickAction(
                  icon: Icons.menu_book_outlined,
                  color: AppColors.rose,
                  bg: AppColors.roseSoft,
                  label: 'Homework',
                  onTap: () => onPush(const SimpleDetailScreen(
                    title: 'Homework',
                    subtitle: 'Assignments from teachers',
                  )),
                ),
                _QuickAction(
                  icon: Icons.calendar_month_outlined,
                  color: AppColors.blue,
                  bg: AppColors.blueSoft,
                  label: 'Timetable',
                  onTap: () => onPush(const TimetableScreen()),
                ),
                _QuickAction(
                  icon: Icons.currency_rupee,
                  color: AppColors.teal,
                  bg: AppColors.tealSoft,
                  label: 'Fees',
                  onTap: () => onPush(const FeesScreen()),
                ),
                _QuickAction(
                  icon: Icons.chat_bubble_outline,
                  color: AppColors.violet,
                  bg: AppColors.violetSoft,
                  label: 'Messages',
                  onTap: () => onSelectTab(3),
                ),
                _QuickAction(
                  icon: Icons.description_outlined,
                  color: AppColors.pink,
                  bg: AppColors.pinkSoft,
                  label: 'Circulars',
                  onTap: () => onPush(const AnnouncementsScreen()),
                ),
                _QuickAction(
                  icon: Icons.event_outlined,
                  color: AppColors.amber,
                  bg: AppColors.amberSoft,
                  label: 'Events',
                  onTap: () => onSelectTab(2),
                ),
                _QuickAction(
                  icon: Icons.grid_view,
                  color: AppColors.sageDark,
                  bg: AppColors.sageSoft,
                  label: 'More',
                  onTap: () => onSelectTab(2),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({
    required this.icon,
    required this.color,
    required this.bg,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color bg;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.ink,
            ),
          ),
        ],
      ),
    );
  }
}

/// Screen 2 — Academics. Header illustration, then the five rows. Each row
/// opens its detail page.
class AcademicsScreen extends StatelessWidget {
  const AcademicsScreen({super.key, required this.onPush});

  final PushPage onPush;

  void _open(String title, String subtitle) {
    onPush(SimpleDetailScreen(title: title, subtitle: subtitle));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Academics',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Riya • Class 8',
              style: TextStyle(fontSize: 14, color: AppColors.muted),
            ),
            const SizedBox(height: 16),
            heroImage('assets/images/girl_reading.webp', 150),
            const SizedBox(height: 20),
            RowCard(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.roseSoft,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'A+',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.rose,
                  ),
                ),
              ),
              title: 'Grades & Results',
              subtitle: 'View test, exam and term results',
              onTap: () => _open(
                'Grades & Results',
                'View test, exam and term results',
              ),
            ),
            RowCard(
              leading: iconTile(
                Icons.menu_book_outlined,
                AppColors.amber,
                AppColors.amberSoft,
              ),
              title: 'Homework',
              subtitle: 'Assignments from teachers',
              onTap: () => _open('Homework', 'Assignments from teachers'),
            ),
            RowCard(
              leading: iconTile(
                Icons.note_alt_outlined,
                AppColors.blue,
                AppColors.blueSoft,
              ),
              title: 'Study Material',
              subtitle: 'Notes, resources and PDFs',
              onTap: () =>
                  _open('Study Material', 'Notes, resources and PDFs'),
            ),
            RowCard(
              leading: iconTile(
                Icons.grid_view,
                AppColors.teal,
                AppColors.tealSoft,
              ),
              title: 'Syllabus',
              subtitle: 'Subject-wise syllabus',
              onTap: () => _open('Syllabus', 'Subject-wise syllabus'),
            ),
            RowCard(
              leading: iconTile(
                Icons.trending_up,
                AppColors.rose,
                AppColors.roseSoft,
              ),
              title: 'Progress Report',
              subtitle: 'Overall academic performance',
              onTap: () =>
                  _open('Progress Report', 'Overall academic performance'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Screen 3 — Attendance. November 2026 calendar, 92% this month,
/// 22/24 days present, last absent 21 Nov (Medical Leave).
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool _thisMonth = true;

  // November 2026: the 1st is a Sunday, so the grid the reference shows
  // runs Mon 2 – Sun 8, 9 – 15, 16 – 22, 23 – 29, then 30.
  static const List<int> _days = [
    2, 3, 4, 5, 6, 7, 8,
    9, 10, 11, 12, 13, 14, 15,
    16, 17, 18, 19, 20, 21, 22,
    23, 24, 25, 26, 27, 28, 29,
    30,
  ];

  // Weekday of a November 2026 day, Monday = 0. Nov 1 is a Sunday.
  static int _weekday(int day) => (day + 5) % 7;

  static bool _isWeekend(int day) => _weekday(day) >= 5;

  Widget _dayCell(int day) {
    final isToday = day == 27;
    // 21 Nov is the last absent day, per the reference.
    final isAbsent = day == 21;
    final isWeekend = _isWeekend(day);
    final Color textColor;
    BoxDecoration decoration;
    if (isToday) {
      textColor = AppColors.blue;
      decoration = BoxDecoration(
        border: Border.all(color: AppColors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      );
    } else if (isAbsent) {
      textColor = AppColors.rose;
      decoration = BoxDecoration(
        color: AppColors.roseSoft,
        borderRadius: BorderRadius.circular(10),
      );
    } else if (isWeekend) {
      textColor = AppColors.sageDark;
      decoration = BoxDecoration(
        border: Border.all(color: AppColors.sage, width: 1.5),
        borderRadius: BorderRadius.circular(18),
      );
    } else {
      textColor = AppColors.ink;
      decoration = const BoxDecoration();
    }
    return Container(
      height: 36,
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        '$day',
        style: TextStyle(
          fontSize: 14,
          fontWeight: isToday ? FontWeight.w800 : FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Attendance')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  _SegmentButton(
                    label: 'This Month',
                    selected: _thisMonth,
                    onTap: () => setState(() => _thisMonth = true),
                  ),
                  _SegmentButton(
                    label: 'Overall',
                    selected: !_thisMonth,
                    onTap: () => setState(() => _thisMonth = false),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.chevron_left, color: AppColors.muted),
                SizedBox(width: 12),
                Text(
                  'November 2026',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: AppColors.ink,
                  ),
                ),
                SizedBox(width: 12),
                Icon(Icons.chevron_right, color: AppColors.muted),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _WeekdayLabel('Mon'),
                      _WeekdayLabel('Tue'),
                      _WeekdayLabel('Wed'),
                      _WeekdayLabel('Thu'),
                      _WeekdayLabel('Fri'),
                      _WeekdayLabel('Sat'),
                      _WeekdayLabel('Sun'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 7,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                    childAspectRatio: 1.1,
                    children: _days.map(_dayCell).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Wrap(
              spacing: 20,
              runSpacing: 8,
              children: [
                _LegendDot(color: AppColors.sage, label: 'Present (22)'),
                _LegendDot(color: AppColors.rose, label: 'Absent (2)'),
                _LegendDot(color: AppColors.muted, label: 'Holiday (6)'),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 64,
                          height: 64,
                          child: CircularProgressIndicator(
                            value: 0.92,
                            strokeWidth: 6,
                            backgroundColor: AppColors.sageSoft,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.sage,
                            ),
                          ),
                        ),
                        const Text(
                          '92%',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: AppColors.sageDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Attendance',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'This Month',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '22 / 24',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Days Present',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.muted),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Row(
              children: [
                Icon(Icons.history, size: 18, color: AppColors.muted),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Last Absent: 21 Nov (Medical Leave)',
                    style: TextStyle(fontSize: 14, color: AppColors.muted),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: selected ? AppColors.sage : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: selected ? Colors.white : AppColors.ink,
            ),
          ),
        ),
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  const _WeekdayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: AppColors.muted,
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 13, color: AppColors.muted),
        ),
      ],
    );
  }
}

/// Screen 4 — Fees & Payments. ₹12,500 Total Fee (Term 2), Pay Now,
/// and the four fee rows.
class FeesScreen extends StatelessWidget {
  const FeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fees & Payments')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            heroImage('assets/images/books_stack.webp', 140),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '₹12,500',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: AppColors.ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Total Fee (Term 2)',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.muted),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Online payment is not part of this UI sample.',
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.sageDark,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward, size: 18),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            RowCard(
              leading: iconTile(
                Icons.currency_rupee,
                AppColors.sageDark,
                AppColors.sageSoft,
              ),
              title: 'Fee Summary',
              subtitle: 'Breakdown of charges',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SimpleDetailScreen(
                    title: 'Fee Summary',
                    subtitle: 'Breakdown of charges',
                  ),
                ),
              ),
            ),
            RowCard(
              leading: iconTile(
                Icons.history,
                AppColors.blue,
                AppColors.blueSoft,
              ),
              title: 'Payment History',
              subtitle: 'Past payments & receipts',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SimpleDetailScreen(
                    title: 'Payment History',
                    subtitle: 'Past payments & receipts',
                  ),
                ),
              ),
            ),
            RowCard(
              leading: iconTile(
                Icons.download_outlined,
                AppColors.teal,
                AppColors.tealSoft,
              ),
              title: 'Download Receipt',
              subtitle: 'PDF receipts',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SimpleDetailScreen(
                    title: 'Download Receipt',
                    subtitle: 'PDF receipts',
                  ),
                ),
              ),
            ),
            RowCard(
              leading: iconTile(
                Icons.calendar_month_outlined,
                AppColors.rose,
                AppColors.roseSoft,
              ),
              title: 'Fee Calendar',
              subtitle: 'Due dates & reminders',
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const SimpleDetailScreen(
                    title: 'Fee Calendar',
                    subtitle: 'Due dates & reminders',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Screen 5 — Timetable. Wednesday's six classes, exactly as the
/// reference shows. Other days have no timetable in this sample.
class TimetableScreen extends StatefulWidget {
  const TimetableScreen({super.key});

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  static const List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
  int _selected = 2; // Wednesday, as in the reference.

  static const List<({String start, String end, String subject, String room, IconData icon, Color color, Color bg})> _wednesday = [
    (start: '08:00 AM', end: '08:40 AM', subject: 'Mathematics', room: 'Room 201', icon: Icons.calculate_outlined, color: AppColors.blue, bg: AppColors.blueSoft),
    (start: '08:50 AM', end: '09:30 AM', subject: 'Science', room: 'Room 204', icon: Icons.science_outlined, color: AppColors.teal, bg: AppColors.tealSoft),
    (start: '09:40 AM', end: '10:20 AM', subject: 'English', room: 'Room 202', icon: Icons.menu_book_outlined, color: AppColors.amber, bg: AppColors.amberSoft),
    (start: '10:30 AM', end: '11:10 AM', subject: 'Social Science', room: 'Room 203', icon: Icons.public_outlined, color: AppColors.rose, bg: AppColors.roseSoft),
    (start: '11:20 AM', end: '12:00 PM', subject: 'Hindi', room: 'Room 205', icon: Icons.translate_outlined, color: AppColors.violet, bg: AppColors.violetSoft),
    (start: '12:00 PM', end: '12:40 PM', subject: 'Computer', room: 'Lab 1', icon: Icons.computer_outlined, color: AppColors.pink, bg: AppColors.pinkSoft),
  ];

  @override
  Widget build(BuildContext context) {
    final String day = _days[_selected];
    return Scaffold(
      appBar: AppBar(title: const Text('Timetable')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            FilterChips(
              options: _days,
              selected: day,
              onSelected: (value) {
                setState(() => _selected = _days.indexOf(value));
              },
            ),
            const SizedBox(height: 20),
            if (_selected == 2)
              ..._wednesday.map(
                (lesson) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 72,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.start,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ink,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lesson.end,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        iconTile(lesson.icon, lesson.color, lesson.bg),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lesson.subject,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.ink,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                lesson.room,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: AppColors.muted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.calendar_month_outlined,
                      size: 40,
                      color: AppColors.muted,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No timetable listed for $day in this sample.',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Screen 6 — Announcements. Filter chips filter the four notices.
class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  String _filter = 'All';

  static const List<({String title, String body, String time, String group, IconData icon, Color color, Color bg})> _notices = [
    (title: 'PTM Notice', body: 'PTM will be held on 30 Nov (Sun) from 9 AM to 1 PM.', time: '14h ago', group: 'Academics', icon: Icons.campaign_outlined, color: AppColors.amber, bg: AppColors.amberSoft),
    (title: 'Annual Day', body: 'Annual Day celebration on 12 Dec. More details soon.', time: '1d ago', group: 'Events', icon: Icons.celebration_outlined, color: AppColors.blue, bg: AppColors.blueSoft),
    (title: 'Winter Uniform', body: 'Winter uniform is mandatory from 1 Dec.', time: '2d ago', group: 'Circulars', icon: Icons.checkroom_outlined, color: AppColors.teal, bg: AppColors.tealSoft),
    (title: 'Holiday Notice', body: 'School will remain closed on 26 Nov (Guru Nanak Jayanti).', time: '3d ago', group: 'Circulars', icon: Icons.beach_access_outlined, color: AppColors.rose, bg: AppColors.roseSoft),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _filter == 'All'
        ? _notices
        : _notices.where((n) => n.group == _filter).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Announcements')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            FilterChips(
              options: const ['All', 'Academics', 'Events', 'Circulars'],
              selected: _filter,
              onSelected: (value) => setState(() => _filter = value),
            ),
            const SizedBox(height: 20),
            ...visible.map(
              (notice) => RowCard(
                leading: iconTile(notice.icon, notice.color, notice.bg),
                title: notice.title,
                subtitle: '${notice.body} • ${notice.time}',
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => SimpleDetailScreen(
                      title: notice.title,
                      subtitle: notice.body,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// Screen 7 — Messages. Filter chips (All / Teachers / School); tapping
/// a conversation opens its thread.
class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key, required this.onPush});

  final PushPage onPush;

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  String _filter = 'All';

  static const List<({String name, String preview, String time, String group, Color color, Color bg, bool unread})> _threads = [
    (name: 'Maths Teacher', preview: 'Homework for Chapter 7 is…', time: '10:24 AM', group: 'Teachers', color: AppColors.pink, bg: AppColors.pinkSoft, unread: true),
    (name: 'Class Teacher', preview: 'PTM schedule and details…', time: 'Yesterday', group: 'Teachers', color: AppColors.teal, bg: AppColors.tealSoft, unread: false),
    (name: 'School Admin', preview: 'Winter uniform notice…', time: '22 Nov', group: 'School', color: AppColors.blue, bg: AppColors.blueSoft, unread: false),
    (name: 'Science Teacher', preview: 'Lab activity on Friday…', time: '21 Nov', group: 'Teachers', color: AppColors.amber, bg: AppColors.amberSoft, unread: false),
  ];

  @override
  Widget build(BuildContext context) {
    final visible = _filter == 'All'
        ? _threads
        : _threads.where((t) => t.group == _filter).toList();
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Messages',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 16),
            FilterChips(
              options: const ['All', 'Teachers', 'School'],
              selected: _filter,
              onSelected: (value) => setState(() => _filter = value),
            ),
            const SizedBox(height: 20),
            ...visible.map(
              (thread) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  child: InkWell(
                    onTap: () => widget.onPush(
                      ChatThreadScreen(
                        name: thread.name,
                        preview: thread.preview,
                        time: thread.time,
                        color: thread.color,
                        bg: thread.bg,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundColor: thread.bg,
                            child: Text(
                              thread.name[0],
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: thread.color,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  thread.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.ink,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  thread.preview,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                thread.time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.muted,
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (thread.unread)
                                Container(
                                  width: 10,
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    color: AppColors.rose,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

/// A conversation thread. Shows the preview message from the reference;
/// messages typed here are appended locally.
class ChatThreadScreen extends StatefulWidget {
  const ChatThreadScreen({
    super.key,
    required this.name,
    required this.preview,
    required this.time,
    required this.color,
    required this.bg,
  });

  final String name;
  final String preview;
  final String time;
  final Color color;
  final Color bg;

  @override
  State<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends State<ChatThreadScreen> {
  late final List<({String text, bool mine})> _messages;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages = [(text: widget.preview, mine: false)];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add((text: text, mine: true));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: widget.bg,
              child: Text(
                widget.name[0],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: widget.color,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                widget.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return Align(
                  alignment: message.mine
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.75,
                    ),
                    decoration: BoxDecoration(
                      color: message.mine
                          ? AppColors.sageSoft
                          : AppColors.card,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      message.text,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.ink,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            color: AppColors.card,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type a message',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _send(),
                  ),
                ),
                IconButton(
                  onPressed: _send,
                  icon: const Icon(Icons.send),
                  color: AppColors.sageDark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Screen 8 — More Services (the School tab). Header illustration, then
/// the eight service tiles. Each tile opens its detail page.
class MoreServicesScreen extends StatelessWidget {
  const MoreServicesScreen({super.key, required this.onPush});

  final PushPage onPush;

  void _open(String title, String subtitle) {
    onPush(SimpleDetailScreen(title: title, subtitle: subtitle));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'More Services',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 16),
            heroImage('assets/images/girl_reading.webp', 140),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.15,
              children: [
                _ServiceTile(
                  icon: Icons.event_outlined,
                  color: AppColors.amber,
                  bg: AppColors.amberSoft,
                  title: 'Events',
                  subtitle: 'School events & activities',
                  onTap: () => _open('Events', 'School events & activities'),
                ),
                _ServiceTile(
                  icon: Icons.directions_bus_outlined,
                  color: AppColors.blue,
                  bg: AppColors.blueSoft,
                  title: 'Transport',
                  subtitle: 'Bus routes & tracking',
                  onTap: () =>
                      _open('Transport', 'Bus routes & tracking'),
                ),
                _ServiceTile(
                  icon: Icons.local_library_outlined,
                  color: AppColors.teal,
                  bg: AppColors.tealSoft,
                  title: 'Library',
                  subtitle: 'Issue & return books',
                  onTap: () => _open('Library', 'Issue & return books'),
                ),
                _ServiceTile(
                  icon: Icons.favorite_outline,
                  color: AppColors.rose,
                  bg: AppColors.roseSoft,
                  title: 'Health',
                  subtitle: 'Medical records & updates',
                  onTap: () =>
                      _open('Health', 'Medical records & updates'),
                ),
                _ServiceTile(
                  icon: Icons.workspace_premium_outlined,
                  color: AppColors.violet,
                  bg: AppColors.violetSoft,
                  title: 'Certificates',
                  subtitle: 'TC, Bonafide, ID card',
                  onTap: () =>
                      _open('Certificates', 'TC, Bonafide, ID card'),
                ),
                _ServiceTile(
                  icon: Icons.event_note_outlined,
                  color: AppColors.amber,
                  bg: AppColors.amberSoft,
                  title: 'Leave Request',
                  subtitle: 'Apply for leave online',
                  onTap: () =>
                      _open('Leave Request', 'Apply for leave online'),
                ),
                _ServiceTile(
                  icon: Icons.image_outlined,
                  color: AppColors.blue,
                  bg: AppColors.blueSoft,
                  title: 'Gallery',
                  subtitle: 'School photos & albums',
                  onTap: () =>
                      _open('Gallery', 'School photos & albums'),
                ),
                _ServiceTile(
                  icon: Icons.feedback_outlined,
                  color: AppColors.teal,
                  bg: AppColors.tealSoft,
                  title: 'Feedback',
                  subtitle: 'Share your suggestions',
                  onTap: () =>
                      _open('Feedback', 'Share your suggestions'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _ServiceTile extends StatelessWidget {
  const _ServiceTile({
    required this.icon,
    required this.color,
    required this.bg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final Color bg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconTile(icon, color, bg, size: 44),
              const SizedBox(height: 8),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.ink,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Screen 9 — Profile. Student header, then the five profile rows.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.onPush});

  final PushPage onPush;

  void _open(String title, String subtitle) {
    onPush(SimpleDetailScreen(title: title, subtitle: subtitle));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: sidePadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.w800,
                color: AppColors.ink,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundImage:
                        AssetImage('assets/images/girl_portrait.webp'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Riya Singh',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.ink,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Class 8 • Section A',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RowCard(
              leading: iconTile(
                Icons.people_outline,
                AppColors.sageDark,
                AppColors.sageSoft,
              ),
              title: 'My Children',
              subtitle: 'Manage linked students',
              onTap: () => _open('My Children', 'Manage linked students'),
            ),
            RowCard(
              leading: iconTile(
                Icons.notifications_outlined,
                AppColors.amber,
                AppColors.amberSoft,
              ),
              title: 'Notifications',
              subtitle: 'Attendance, fees, announcements',
              onTap: () =>
                  _open('Notifications', 'Attendance, fees, announcements'),
            ),
            RowCard(
              leading: iconTile(
                Icons.description_outlined,
                AppColors.blue,
                AppColors.blueSoft,
              ),
              title: 'Documents',
              subtitle: 'ID card, receipts, certificates',
              onTap: () =>
                  _open('Documents', 'ID card, receipts, certificates'),
            ),
            RowCard(
              leading: iconTile(
                Icons.settings_outlined,
                AppColors.teal,
                AppColors.tealSoft,
              ),
              title: 'App Settings',
              subtitle: 'Language, theme, privacy',
              onTap: () =>
                  _open('App Settings', 'Language, theme, privacy'),
            ),
            RowCard(
              leading: iconTile(
                Icons.help_outline,
                AppColors.rose,
                AppColors.roseSoft,
              ),
              title: 'Help & Support',
              subtitle: 'Get help or contact school',
              onTap: () =>
                  _open('Help & Support', 'Get help or contact school'),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
