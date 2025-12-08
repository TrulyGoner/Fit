import 'package:flutter/material.dart';
import 'bottom_nav_icon.dart';
import 'bottom_wave_painter.dart';

class CurvedBottomNavBar extends StatelessWidget {
  const CurvedBottomNavBar({
    super.key,
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
                    painter: BottomWavePainter(
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
                      child: BottomNavIcon(
                        iconPath: 'assets/icons/Home.svg',
                        isActive: currentIndex == 0,
                        onTap: () => onItemSelected(0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: BottomNavIcon(
                        iconPath: currentIndex == 1
                            ? 'assets/icons/calendaron.svg'
                            : 'assets/icons/calendar.svg',
                        isActive: currentIndex == 1,
                        onTap: () => onItemSelected(1),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: BottomNavIcon(
                        iconPath: 'assets/icons/messages.svg',
                        isActive: currentIndex == 2,
                        onTap: () => onItemSelected(2),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: BottomNavIcon(
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

