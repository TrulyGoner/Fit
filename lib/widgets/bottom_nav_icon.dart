import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    super.key,
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
          scale: isActive ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutBack,
          child: SvgPicture.asset(
            iconPath,
            width: isActive ? 24 : 22,
            height: isActive ? 24 : 22,
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

