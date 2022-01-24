import 'package:flutter/material.dart';
import 'package:timetable/configuration/configuration.dart';
import 'package:timetable/widgets/sign_in/submit_button.dart';

class LoginLayout extends StatelessWidget {
  const LoginLayout({
    Key? key,
    required this.onNextButtonPressed,
    required this.isLoading,
    required this.nextButtonLabel,
    required this.formChildren,
    required this.isWide,
  }) : super(key: key);

  final VoidCallback onNextButtonPressed;
  final String nextButtonLabel;
  final bool isLoading;
  final bool isWide;

  final List<Widget> formChildren;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.indigo050,
            AppColors.indigo200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: formPadding(context)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...formChildren,
          const SizedBox(height: AppMargins.margin),
          SubmitButton(
            onPressed: onNextButtonPressed,
            label: nextButtonLabel,
          ),
          const SizedBox(height: AppMargins.largeMargin),
          if (isLoading) const Center(child: CircularProgressIndicator())
        ],
      ),
    );
  }

  double formPadding(BuildContext context) {
    final widthFactor = isWide ? 6 : 4;
    return MediaQuery.of(context).size.width / widthFactor;
  }
}
