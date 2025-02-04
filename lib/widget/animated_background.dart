import 'dart:math';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AnimatedWaveBackground extends StatefulWidget {
  const AnimatedWaveBackground({super.key});

  @override
  _AnimatedWaveBackgroundState createState() => _AnimatedWaveBackgroundState();
}

class _AnimatedWaveBackgroundState extends State<AnimatedWaveBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(_controller.value),
          child: Container(),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> colors = [
      AppColors.waveColorSoft,
      AppColors.waveColorMedium,
      AppColors.waveColorBold,
    ];

    final List<double> heightFactors = [0.5, 0.6, 0.7];
    final List<double> phaseShifts = [pi / 2, pi / 4, 3 * pi / 4];
    const double waveHeight = 20;

    for (int i = 0; i < colors.length; i++) {
      final Paint paint = Paint()..color = colors[i];
      final Path path = Path();

      path.moveTo(0, size.height);
      for (double j = 0; j < size.width; j++) {
        path.lineTo(
          j,
          size.height * heightFactors[i] +
              sin((j / size.width * 2 * pi) + (animationValue * 2 * pi) + phaseShifts[i]) * waveHeight,
        );
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
