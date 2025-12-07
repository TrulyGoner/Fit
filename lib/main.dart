import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const FitApp());
}

class FitApp extends StatelessWidget {
  const FitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fit Tasks',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4F6FB),
        useMaterial3: true,
         textTheme: ThemeData.light().textTheme.apply(
          fontFamily: 'ProductSans',
        ),
        fontFamily: 'ProductSans',
      ),
      home: const WelcomeScreen(),
    );
  }
}

/// Экран приветствия (Artboard 1)
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(36),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                  child: SizedBox(
                    height: 320,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/images/home_bg.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 4,
                      width: 20,
                      decoration: BoxDecoration(
                        color: const Color(0xFF4F46E5),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    children: [
                      Text(
                        'Building Better\nWorkplaces',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          height: 1.3,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF111827),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Create a unique emotional story that\n'
                        'describes better than words',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.5,
                          color: Color(0xFF9CA3AF),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
                  child: SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (_) => const MainShell(),
                          ),
                        );
                      },
                      child: Ink(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF8B5CFF),
                              Color(0xFF5C6CFF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}


class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: const [
          DashboardScreen(),
          CalendarScreen(),
          ChatScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: _CurvedBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ),
    );
  }
}

/// Кастомный нижний бар с волной под активной иконкой.
class _CurvedBottomNavBar extends StatelessWidget {
  const _CurvedBottomNavBar({
    required this.currentIndex,
    required this.onItemSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  static const _barHeight = 78.0;
  static const _itemCount = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: _barHeight,
          child: Stack(
            children: [
              // Волна под активной иконкой
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutQuad,
                left: _calculateWavePosition(context),
                bottom: 0,
                child: SizedBox(
                  width: _calculateWaveWidth(context),
                  height: _barHeight * 0.5,
                  child: CustomPaint(
                    painter: _BottomWavePainter(
                      startColor: const Color(0xFF8B5CFF),
                      endColor: const Color(0xFF5C6CFF),
                    ),
                  ),
                ),
              ),

              // Ряд иконок поверх
              Row(
                children: [
                  Expanded(
                    child: Center(
                      child: _BottomNavIcon(
                        iconPath: 'assets/icons/Home.svg',
                        isActive: currentIndex == 0,
                        onTap: () => onItemSelected(0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _BottomNavIcon(
                        iconPath: 'assets/icons/calendar.svg',
                        isActive: currentIndex == 1,
                        onTap: () => onItemSelected(1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _BottomNavIcon(
                        iconPath: 'assets/icons/messages.svg',
                        isActive: currentIndex == 2,
                        onTap: () => onItemSelected(2),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: _BottomNavIcon(
                        iconPath: 'assets/icons/profile.svg',
                        isActive: currentIndex == 3,
                        onTap: () => onItemSelected(3),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  double _calculateWaveWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / _itemCount;
    return itemWidth * 0.9;
  }

  double _calculateWavePosition(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / _itemCount;
    final waveWidth = itemWidth * 0.9;
    return currentIndex * itemWidth + (itemWidth - waveWidth) / 2;
  }
}

class _BottomWavePainter extends CustomPainter {
  _BottomWavePainter({required this.startColor, required this.endColor});

  final Color startColor;
  final Color endColor;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    final rect = Rect.fromLTWH(0, height * 0.2, width, height * 0.8);
    paint.shader = LinearGradient(
      colors: [startColor, endColor],
      begin: const Alignment(-0.6, -0.8),
      end: const Alignment(0.8, 1.0),
    ).createShader(rect);

    final path = Path();

    path.moveTo(0, height);

    path.quadraticBezierTo(
      width * 0.15,
      height - 10,
      width * 0.30,
      height - 16,
    );
    path.quadraticBezierTo(
      width * 0.50,
      height - 20,
      width * 0.70,
      height - 16,
    );
    path.quadraticBezierTo(
      width * 0.85,
      height - 10,
      width,
      height,
    );

    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Главный экран (Artboard 2)
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFF8F7FF),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTopBar(),
                const SizedBox(height: 24),
                _buildGreetingSection(),
                const SizedBox(height: 24),
                _buildCurrentTaskCard(),
                const SizedBox(height: 24),
                Expanded(
                  child: _buildBottomContent(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Monday',
              style: TextStyle(
                color: Color(0xFF6B7280),
                fontSize: 14,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '25 October',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.search,
                color: Color(0xFF4B5563),
              ),
            ),
            const SizedBox(width: 16),
            Stack(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Color(0xFF4F46E5),
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 8,
                  child: Container(
                    height: 10,
                    width: 10,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF5C5C),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Hi Surf.',
          style: TextStyle(
            color: Color(0xFF111827),
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '5 Tasks are pending',
          style: TextStyle(
            color: Color(0xFF6B7280),
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentTaskCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8B5CFF),
            Color(0xFF5C6CFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF5C6CFF).withOpacity(0.35),
            blurRadius: 24,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Information Architecture',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Now',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFFFFD4A8),
                child: Text(
                  'S',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 14,
                backgroundColor: Color(0xFFB5E4FF),
                child: Text(
                  'O',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Text(
            'Monthly Preview',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 17),
          _buildStatsGrid(),
          const SizedBox(height: 33),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const leftCardWidth = 162.0;
        const rightCardWidth = 161.0;

        const tallLeftHeight = 150.0;     // Done
        const shortLeftHeight = 105.0;    // Ongoing

        const shortRightHeight = 102.0;   // In Progress
        const tallRightHeight = 150.0;    // Waiting for Review

        const horizontalGap = 20.0;
        const verticalGap = 13.0;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ----- Левая колонка -----
            Column(
              children: [
                SizedBox(
                  width: leftCardWidth,
                  height: tallLeftHeight,
                  child: const _StatsCard(
                    value: '22',
                    label: 'Done',
                    startColor: Color(0xFFA9FFEA),
                    endColor: Color(0xFF00B388),
                  ),
                ),
                SizedBox(height: verticalGap),
                SizedBox(
                  width: leftCardWidth,
                  height: shortLeftHeight,
                  child: const _StatsCard(
                    value: '12',
                    label: 'Ongoing',
                    startColor: Color(0xFFFFA0BC),
                    endColor: Color(0xFFFF1B5E),
                  ),
                ),
              ],
            ),

            SizedBox(width: horizontalGap),

            // ----- Правая колонка -----
            Column(
              children: [
                SizedBox(
                  width: rightCardWidth,
                  height: shortRightHeight,
                  child: const _StatsCard(
                    value: '10',
                    label: 'In Progress',
                    startColor: Color(0xFFFFD29D),
                    endColor: Color(0xFFFF9E2D),
                  ),
                ),
                SizedBox(height: verticalGap),
                SizedBox(
                  width: rightCardWidth,
                  height: tallRightHeight,
                  child: const _StatsCard(
                    value: '8',
                    label: 'Waiting For Review',
                    startColor: Color(0xFFB1EEFF),
                    endColor: Color(0xFF29BAE2),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}


/// Экран календаря / расписания (Artboard 3)
class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedDayIndex = 1; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 59),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      color: Color(0xFF4F46E5),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 59),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Mar',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                  Text(
                    'April',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'May',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildDaySelector(),
              const SizedBox(height: 24),
              const Text(
                'Ongoing',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: _buildTimeline(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDaySelector() {
    final days = [
      {'day': '1', 'label': 'Thu'},
      {'day': '2', 'label': 'Fri'},
      {'day': '3', 'label': 'Sat'},
      {'day': '4', 'label': 'Sat'},
      {'day': '5', 'label': 'Sun'},
      {'day': '6', 'label': 'Mon'},
      {'day': '7', 'label': 'Tue'},
      {'day': '8', 'label': 'Wed'},
      {'day': '9', 'label': 'Thu'},
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isActive = index == _selectedDayIndex;
          final item = days[index];

          return GestureDetector(
            onTap: () {
              setState(() => _selectedDayIndex = index);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutQuad,
              width: 70,
              height: 120,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: isActive
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF8B5CFF),
                          Color(0xFF5C6CFF),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )
                    : null,
                color: isActive ? null : Colors.white,
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color:
                              const Color(0xFF5C6CFF).withOpacity(0.45),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item['day']!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          isActive ? Colors.white : const Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item['label']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: isActive
                          ? Colors.white70
                          : const Color(0xFF6B7280),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimeline() {
    return ListView(
      padding: const EdgeInsets.only(bottom: 24, right: 8, left: 8),
      children: const [
        _TimelineItem(
          timeLabel: '9AM',
          card: _OngoingCard(
            title: 'Information Architecture',
            time: '9:00 AM - 10:00 AM',
            startColor: Color(0xFFFFD29D),
            endColor: Color(0xFFFF9E2D),
          ),
        ),
        _TimelineItem(
          timeLabel: '10AM',
          showDivider: true,
          card: _OngoingCard(
            title: 'Software Testing',
            time: '11:00 AM - 12:00 PM',
            startColor: Color(0xFFB1EEFF),
            endColor: Color(0xFF29BAE2),
          ),
        ),
        _TimelineItem(
          timeLabel: '12PM',
          showDivider: true,
          card: SizedBox.shrink(),
        ),
        _TimelineItem(
          timeLabel: '1PM',
          card: _OngoingCard(
            title: 'Mobile App Design',
            time: '1:00 PM - 3:00 PM',
            startColor: Color(0xFFFFA0BC),
            endColor: Color(0xFFFF1B5E),
          ),
        ),
      ],
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({
    required this.timeLabel,
    required this.card,
    this.showDivider = false,
  });

  final String timeLabel;
  final Widget card;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Text(
              timeLabel,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDivider) ...[
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF4F46E5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Container(
                          height: 2,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F46E5),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
                card,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatsCard extends StatelessWidget {
  const _StatsCard({
    required this.value,
    required this.label,
    required this.startColor,
    required this.endColor,
  });

  final String value;
  final String label;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            startColor,
            endColor,
          ],
          begin: const Alignment(-0.6, -0.8),
          end: const Alignment(0.8, 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 25,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _OngoingCard extends StatelessWidget {
  const _OngoingCard({
    required this.title,
    required this.time,
    required this.startColor,
    required this.endColor,
  });

  final String title;
  final String time;
  final Color startColor;
  final Color endColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: const Alignment(-0.6, -0.8),
          end: const Alignment(0.8, 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const CircleAvatar(
                radius: 12,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 14,
                  color: Color(0xFF4F46E5),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                time,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomNavIcon extends StatelessWidget {
  const _BottomNavIcon({
    required this.iconPath,
    this.isActive = false,
    this.onTap,
  });

  final String iconPath;
  final bool isActive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AnimatedSlide(
        offset: isActive ? const Offset(0, -0.18) : Offset.zero,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutQuad,
        child: AnimatedScale(
          scale: isActive ? 1.30 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          child: SvgPicture.asset(
            iconPath,
            width: 26,
            height: 26,
            colorFilter: ColorFilter.mode(
              isActive ? const Color(0xFF6C5CE7) : const Color(0xFFD1D5DB),
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

/// Экран чата
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: const Center(
        child: Text(
          'Chat Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

/// Экран профиля
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
      ),
      body: const Center(
        child: Text(
          'Profile Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}