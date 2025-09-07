import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class SectionWrapper extends StatelessWidget {
  final Widget child;
  final String? sectionId;
  final EdgeInsets? padding;
  final double? maxWidth;

  const SectionWrapper({
    Key? key,
    required this.child,
    this.sectionId,
    this.padding,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? Responsive.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxWidth ?? (Responsive.isDesktop(context) ? 1200 : double.infinity),
          ),
          child: child,
        ),
      ),
    );
  }
}
