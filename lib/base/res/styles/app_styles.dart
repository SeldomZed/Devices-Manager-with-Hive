import 'package:flutter/material.dart';

class AppStyles {
  static Color primaryColor = const Color(0xFF00D3DD);
  static Color secondaryColor = const Color(0xFF0097E9);
  static Color thirdColor = const Color(0xFF00BEE3);
  static Color textColor = Colors.lightBlue;

  static TextStyle headlinesStyle1 = TextStyle(
    fontSize: 30,
    color: AppStyles.primaryColor,
  );
  static TextStyle headlinesStyle2 = TextStyle(
    fontSize: 20,
    color: AppStyles.textColor,
    fontWeight: FontWeight.w500,
  );
}

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Gradient gradient;

  const GradientText(this.text, {super.key, required this.gradient, required this.style});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: style.copyWith(color: Colors.white),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  final IconData icon;
  final double size;
  final Gradient gradient;

  const GradientIcon({super.key, required this.icon, required this.size, required this.gradient});

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, size, size),
      ),
      child: Icon(
        icon,
        size: size,
        color: Colors.white,
      ),
    );
  }
}
