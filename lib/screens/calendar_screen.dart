import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/timeline_item.dart';
import '../widgets/ongoing_card.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key, this.onBackToHome});

  final VoidCallback? onBackToHome;

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  int _selectedDayIndex = 1; // 5 Sun по умолчанию

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
                  GestureDetector(
                    onTap: widget.onBackToHome,
                    child: Container(
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
                children: [
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to previous month
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.rotate(
                          angle: 3.14159, // 180 degrees
                          child: SvgPicture.asset(
                            'assets/icons/arrow.svg',
                            width: 14,
                            height: 14,
                            colorFilter: const ColorFilter.mode(
                              Color(0xFF111827),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'March',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF111827),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'April',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // TODO: Navigate to next month
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'May',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset(
                          'assets/icons/arrow.svg',
                          width: 14,
                          height: 14,
                          colorFilter: const ColorFilter.mode(
                            Color(0xFF111827),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
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
      {'day': '4', 'label': 'Sat'},
      {'day': '5', 'label': 'Sun'},
      {'day': '6', 'label': 'Mon'},
      {'day': '7', 'label': 'Tue'},
      {'day': '8', 'label': 'Wed'},
      {'day': '9', 'label': 'Thu'},
      {'day': '10', 'label': 'Fri'},
      {'day': '11', 'label': 'Sat'},
      {'day': '12', 'label': 'Sun'},
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(bottom: 20, top: 0),
        clipBehavior: Clip.none,
        itemCount: days.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isActive = index == _selectedDayIndex;
          final item = days[index];

          return GestureDetector(
            onTap: () {
              setState(() => _selectedDayIndex = index);
            },
            child: Container(
              width: 70,
              height: 120,
              margin: const EdgeInsets.symmetric(vertical: 0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutQuad,
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
                            color: const Color(0xFF5C6CFF).withOpacity(0.35),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                            spreadRadius: 0,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                            spreadRadius: 0,
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
                        color: isActive
                            ? Colors.white
                            : const Color(0xFF111827),
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
        TimelineItem(
          timeLabel: '9AM',
          card: OngoingCard(
            title: 'Information Architecture',
            subtitle: 'Saber & Oro',
            time: '9.00 AM - 10.00 AM',
            startColor: Color(0xFFFFD29D),
            endColor: Color(0xFFFF9E2D),
          ),
        ),
        TimelineItem(
          timeLabel: '10AM',
          showDivider: true,
          card: OngoingCard(
            title: 'Software Testing',
            subtitle: 'Saber & Mike',
            time: '11.00 AM - 12.00 PM',
            startColor: Color(0xFFB1EEFF),
            endColor: Color(0xFF29BAE2),
          ),
        ),
        TimelineItem(
          timeLabel: '1PM',
          card: OngoingCard(
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


