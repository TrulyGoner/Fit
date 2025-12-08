import 'package:flutter/material.dart';
import 'dart:math' as math;

// Главный виджет для навигационной панели с волной
class AnimatedWaveBottomBar extends StatefulWidget {
  final List<BottomNavItem> items;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final Color startColor;
  final Color endColor;
  final Color selectedIconColor;
  final Color unselectedIconColor;
  final Duration animationDuration;
  final Curve animationCurve;
  final double height;

  const AnimatedWaveBottomBar({
    Key? key,
    required this.items,
    required this.selectedIndex,
    required this.onTap,
    this.startColor = const Color(0xFF6B5CE7),
    this.endColor = const Color(0xFF8B7FF4),
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.grey,
    this.animationDuration = const Duration(milliseconds: 600),
    this.animationCurve = Curves.easeInOutCubic,
    this.height = 70,
  }) : super(key: key);

  @override
  State<AnimatedWaveBottomBar> createState() => _AnimatedWaveBottomBarState();
}

class _AnimatedWaveBottomBarState extends State<AnimatedWaveBottomBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.selectedIndex;
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.animationCurve,
    );
  }

  @override
  void didUpdateWidget(AnimatedWaveBottomBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {
        _previousIndex = oldWidget.selectedIndex;
      });
      _controller.forward(from: 0.0);
    }

    if (oldWidget.animationDuration != widget.animationDuration) {
      _controller.duration = widget.animationDuration;
    }

    if (oldWidget.animationCurve != widget.animationCurve) {
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.animationCurve,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Анимированная волна
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return CustomPaint(
                painter: AnimatedWavePainter(
                  selectedIndex: widget.selectedIndex,
                  previousIndex: _previousIndex,
                  progress: _animation.value,
                  itemCount: widget.items.length,
                  startColor: widget.startColor,
                  endColor: widget.endColor,
                ),
                size: Size(MediaQuery.of(context).size.width, widget.height),
              );
            },
          ),
          // Иконки навигации
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(widget.items.length, (index) {
              final item = widget.items[index];
              final isSelected = widget.selectedIndex == index;
              
              return Expanded(
                child: GestureDetector(
                  onTap: () => widget.onTap(index),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Анимация иконки
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            // Если это выбранный элемент или предыдущий
                            final shouldAnimate = index == widget.selectedIndex || 
                                                 index == _previousIndex;
                            
                            double scale = 1.0;
                            if (shouldAnimate) {
                              if (index == widget.selectedIndex) {
                                scale = 1.0 + (_animation.value * 0.2);
                              } else {
                                scale = 1.2 - (_animation.value * 0.2);
                              }
                            }

                            return Transform.scale(
                              scale: scale,
                              child: Icon(
                                item.icon,
                                color: isSelected
                                    ? widget.selectedIconColor
                                    : widget.unselectedIconColor,
                                size: 28,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 4),
                        // Анимация текста
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            color: isSelected
                                ? widget.selectedIconColor
                                : widget.unselectedIconColor,
                            fontSize: isSelected ? 13 : 12,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                          child: Text(item.label),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// Painter для анимированной волны
class AnimatedWavePainter extends CustomPainter {
  final int selectedIndex;
  final int previousIndex;
  final double progress;
  final int itemCount;
  final Color startColor;
  final Color endColor;

  AnimatedWavePainter({
    required this.selectedIndex,
    required this.previousIndex,
    required this.progress,
    required this.itemCount,
    required this.startColor,
    required this.endColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    // Вычисляем позицию волны
    final itemWidth = width / itemCount;
    final oldPosition = previousIndex * itemWidth + itemWidth / 2;
    final newPosition = selectedIndex * itemWidth + itemWidth / 2;
    
    // Плавная интерполяция с помощью progress
    final currentPosition = oldPosition + (newPosition - oldPosition) * progress;

    // Параметры волны
    final waveWidth = itemWidth * 1.8;
    final waveHeight = height * 0.75; // Высота основной части
    final peakHeight = height * 0.25; // Высота пика волны

    // Градиент
    final rect = Rect.fromLTWH(0, 0, width, height);
    paint.shader = LinearGradient(
      colors: [startColor, endColor],
      begin: const Alignment(-0.6, -0.8),
      end: const Alignment(0.8, 1.0),
    ).createShader(rect);

    final path = Path();

    // Начинаем снизу слева
    path.moveTo(0, height);
    
    // Плоская часть слева до волны
    if (currentPosition - waveWidth / 2 > 0) {
      path.lineTo(0, waveHeight);
      path.lineTo(currentPosition - waveWidth / 2, waveHeight);
    } else {
      path.lineTo(0, waveHeight);
    }

    // Левая часть волны (подъем)
    final leftControlX = currentPosition - waveWidth / 3;
    final leftControlY = waveHeight - (waveHeight - peakHeight) * 0.6;
    
    path.quadraticBezierTo(
      leftControlX,
      leftControlY,
      currentPosition - waveWidth / 6,
      peakHeight,
    );

    // Пик волны
    path.quadraticBezierTo(
      currentPosition,
      0, // Самая верхняя точка
      currentPosition + waveWidth / 6,
      peakHeight,
    );

    // Правая часть волны (спуск)
    final rightControlX = currentPosition + waveWidth / 3;
    final rightControlY = waveHeight - (waveHeight - peakHeight) * 0.6;
    
    path.quadraticBezierTo(
      rightControlX,
      rightControlY,
      currentPosition + waveWidth / 2,
      waveHeight,
    );

    // Плоская часть справа от волны
    if (currentPosition + waveWidth / 2 < width) {
      path.lineTo(width, waveHeight);
    }
    
    path.lineTo(width, height);
    path.lineTo(0, height);
    path.close();

    canvas.drawPath(path, paint);

    _drawShineEffect(canvas, size, currentPosition, waveWidth, waveHeight, peakHeight);
  }

  void _drawShineEffect(Canvas canvas, Size size, double centerX, double waveWidth, 
                       double waveHeight, double peakHeight) {
    final shinePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(0.1);

    final shinePath = Path();
    
    // Узкая полоска блеска на гребне волны
    final shineWidth = waveWidth * 0.4;
    
    shinePath.moveTo(centerX - shineWidth / 2, peakHeight);
    shinePath.quadraticBezierTo(
      centerX - shineWidth / 4,
      peakHeight * 0.7,
      centerX,
      peakHeight * 0.5,
    );
    shinePath.quadraticBezierTo(
      centerX + shineWidth / 4,
      peakHeight * 0.7,
      centerX + shineWidth / 2,
      peakHeight,
    );
    shinePath.quadraticBezierTo(
      centerX + shineWidth / 3,
      peakHeight * 1.3,
      centerX,
      peakHeight * 1.5,
    );
    shinePath.quadraticBezierTo(
      centerX - shineWidth / 3,
      peakHeight * 1.3,
      centerX - shineWidth / 2,
      peakHeight,
    );
    shinePath.close();

    canvas.drawPath(shinePath, shinePaint);
  }

  @override
  bool shouldRepaint(AnimatedWavePainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
           oldDelegate.previousIndex != previousIndex ||
           oldDelegate.progress != progress;
  }
}

// Модель элемента навигации
class BottomNavItem {
  final IconData icon;
  final String label;

  const BottomNavItem({
    required this.icon,
    required this.label,
  });
}

// Простой painter для волны (используется в CurvedBottomNavBar)
class BottomWavePainter extends CustomPainter {
  BottomWavePainter({required this.startColor, required this.endColor});

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
