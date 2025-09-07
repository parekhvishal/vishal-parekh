import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.sectionPadding(context),
      child: Column(
        children: [
          // Section Title
          Text(
            'Education',
            style: AppTextStyles.sectionTitle.copyWith(
              fontSize: Responsive.getFontSize(
                context,
                mobile: 28,
                tablet: 36,
                desktop: 40,
              ),
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Education Card
          Container(
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(32),
            decoration: AppDecoration.containerDecoration(),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: AppColors.goldGradient,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldPrimary.withValues(alpha: 0.3),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: FaIcon(
                      FontAwesomeIcons.graduationCap,
                      color: AppColors.appBackground,
                      size: 32,
                    ),
                  ),
                ),
                
                const SizedBox(width: 32),
                
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bachelor of Engineering',
                        style: AppTextStyles.cardTitle.copyWith(
                          fontSize: Responsive.getFontSize(
                            context,
                            mobile: 18,
                            tablet: 20,
                            desktop: 22,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Computer Engineering',
                        style: AppTextStyles.cardSubtitle.copyWith(
                          fontSize: Responsive.getFontSize(
                            context,
                            mobile: 16,
                            tablet: 18,
                            desktop: 18,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      Text(
                        'Government Eng College • Modasa, Gujarat',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontSize: Responsive.getFontSize(
                            context,
                            mobile: 14,
                            tablet: 16,
                            desktop: 16,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Text(
                        'Graduated: 2020',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: Responsive.getFontSize(
                            context,
                            mobile: 12,
                            tablet: 14,
                            desktop: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
