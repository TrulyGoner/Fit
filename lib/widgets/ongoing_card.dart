import 'package:flutter/material.dart';

class OngoingCard extends StatelessWidget {
  const OngoingCard({
    super.key,
    required this.title,
    required this.time,
    required this.startColor,
    required this.endColor,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
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
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 4),
          ],
          Text(
            time,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

