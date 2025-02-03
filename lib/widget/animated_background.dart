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
    List<Color> colors = [
      AppColors.waveColorBold,
      AppColors.waveColorMedium,
      AppColors.waveColorSoft,
    ];

    final List<double> height = [0.8, 0.7, 0.6];


    // for (int i = 0; i < colors.length; i++) {
    //   final Paint paint = Paint()..color = colors[i];
    //   final Path path = Path();

    //   final double waveHeight = 20;
    //   final double waveWidth = size.width;

    //   path.moveTo(0, size.height * 0.5);
    //   for (double j = 0; j < size.width; j++) {
    //     path.lineTo(j,
    //         size.height * 0.8 + sin((j / waveWidth * 2 * pi) + (animationValue * 2 * pi) + (i * pi / 4)) * waveHeight);
    //   }
    //   path.lineTo(size.width, size.height);
    //   path.lineTo(0, size.height);
    //   path.close();

    //   canvas.drawPath(path, paint);
    // }

      



      final Paint paint0 = Paint()..color = AppColors.waveColorSoft;
      final Path path0 = Path();

      final double waveHeight0 = 20;
      final double waveWidth0 = size.width;


      path0.moveTo(0, size.height);
      for (double j = 0; j < size.width; j++) {
        path0.lineTo(j,
            size.height * 0.5 + sin((j / waveWidth0 * 2 * pi) + (animationValue * 2 * pi) + (3 * pi / 4)) * waveHeight0);
      }
      path0.lineTo(size.width, size.height);
      path0.lineTo(0, size.height);
      path0.close();

      canvas.drawPath(path0, paint0);

      final Paint paint1 = Paint()..color = AppColors.waveColorMedium;
      final Path path1 = Path();

      final double waveHeight1 = 20;
      final double waveWidth1 = size.width;


      path1.moveTo(0, size.height);
      for (double j = 0; j < size.width; j++) {
        path1.lineTo(j,
            size.height * 0.6 + sin((j / waveWidth1 * 2 * pi) + (animationValue * 2 * pi) + (1 * pi / 4)) * waveHeight1);
      }
      path1.lineTo(size.width, size.height);
      path1.lineTo(0, size.height);
      path1.close();

      canvas.drawPath(path1, paint1);

      final Paint paint = Paint()..color = AppColors.waveColorBold;
      final Path path = Path();

      final double waveHeight = 20;
      final double waveWidth = size.width;


      path.moveTo(0, size.height * 0.5);
      for (double j = 0; j < size.width; j++) {
        path.lineTo(j,
            size.height * 0.7 + sin((j / waveWidth * 2 * pi) + (animationValue * 2 * pi) + (2 * pi / 4)) * waveHeight);
      }
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
      path.close();

      canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
