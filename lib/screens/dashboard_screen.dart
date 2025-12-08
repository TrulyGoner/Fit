import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/stats_card.dart';

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
            SvgPicture.asset(
              'assets/icons/Navigation.svg',
              width: 56,
              height: 56,
              colorFilter: const ColorFilter.mode(
                Color(0xFF111827),
                BlendMode.srcIn,
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
          const Text(
            'Saber & Oro',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
        final screenWidth = constraints.maxWidth;
        final verticalGap = screenWidth * 0.035; 
        final horizontalGap = screenWidth * 0.053; 
        final bigCardHeight = screenWidth * 0.533; 
        final smallCardHeight = screenWidth * 0.373; 

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            // Левый контейнер
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: bigCardHeight,
                    child: const StatsCard(
                      value: '22',
                      label: 'Done',
                      startColor: Color(0xFFA9FFEA),
                      endColor: Color(0xFF00B388),
                    ),
                  ),
                  SizedBox(height: verticalGap),
                  SizedBox(
                    width: double.infinity,
                    height: smallCardHeight,
                    child: const StatsCard(
                      value: '12',
                      label: 'Ongoing',
                      startColor: Color(0xFFFFA0BC),
                      endColor: Color(0xFFFF1B5E),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: horizontalGap),
            // Правый контейнер
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: smallCardHeight,
                    child: const StatsCard(
                      value: '7',
                      label: 'In Progress',
                      startColor: Color(0xFFFFD29D),
                      endColor: Color(0xFFFF9E2D),
                    ),
                  ),
                  SizedBox(height: verticalGap),
                  SizedBox(
                    width: double.infinity,
                    height: bigCardHeight,
                    child: const StatsCard(
                      value: '14',
                      label: 'Waiting For Review',
                      startColor: Color(0xFFB1EEFF),
                      endColor: Color(0xFF29BAE2),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

