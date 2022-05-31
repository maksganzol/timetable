import 'package:flutter/material.dart';
import 'package:timetable/configuration/configuration.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.isActive = true,
  }) : super(key: key);

  final String label;
  final VoidCallback onPressed;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onPressed : null,
      child: _GradientBorders(
        borderRadius: BorderRadius.circular(19),
        borderWidth: 1,
        gradient: const LinearGradient(
          colors: [AppColors.indigo200, AppColors.indigo400],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppMargins.margin,
            vertical: AppMargins.smallMargin,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: AppColors.indigo400,
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: AppColors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientBorders extends StatelessWidget {
  const _GradientBorders({
    Key? key,
    required this.borderRadius,
    required this.child,
    required this.borderWidth,
    required this.gradient,
  }) : super(key: key);

  final Widget child;
  final BorderRadius borderRadius;
  final double borderWidth;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: gradient,
      ),
      child: child,
    );
  }
}
