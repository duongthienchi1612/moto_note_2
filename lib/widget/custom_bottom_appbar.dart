import 'package:flutter/material.dart';

class CustomBottomAppBar extends StatelessWidget {
  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BottomBarShadowPainter(),
      child: ClipPath(
        clipper: BottomBarClipper(),
        child: Container(
          color: Colors.white,
          height: 50,
        ),
      ),
    );
  }
}

class BottomBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();

    final double width = size.width;
    final double height = size.height;

    path.moveTo(0, height);
    path.quadraticBezierTo(width * 0.5, 0 - 20, width, height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

class BottomBarShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint shadowPaint = Paint()
      ..color = Colors.grey
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10);

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final Path path = BottomBarClipper().getClip(size);

    canvas.drawPath(path, shadowPaint); // Vẽ shadow
    canvas.drawPath(path, borderPaint); // Vẽ border
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
