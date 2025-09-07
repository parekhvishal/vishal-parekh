import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';

class BackToTopButton extends StatelessWidget {
  final bool show;
  final VoidCallback onPressed;

  const BackToTopButton({
    Key? key,
    required this.show,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: AnimatedOpacity(
        opacity: show ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 300),
        child: AnimatedSlide(
          offset: show ? Offset.zero : const Offset(0, 1),
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: FloatingActionButton(
            onPressed: show ? onPressed : null,
            backgroundColor: AppColors.goldPrimary,
            foregroundColor: AppColors.appBackground,
            elevation: 8,
            child: const FaIcon(
              FontAwesomeIcons.arrowUp,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
