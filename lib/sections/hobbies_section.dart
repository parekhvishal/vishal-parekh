import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class HobbiesSection extends StatelessWidget {
  const HobbiesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.sectionPadding(context),
      child: Column(
        children: [
          // Section Title
          Text(
            'Hobbies & Interests',
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
          
          // Hobbies Grid
          _buildHobbiesGrid(context),
        ],
      ),
    );
  }

  Widget _buildHobbiesGrid(BuildContext context) {
    final hobbies = [
      HobbyItem(
        icon: FontAwesomeIcons.camera,
        title: 'Photography',
        description: 'Capturing moments and exploring creative perspectives',
      ),
      HobbyItem(
        icon: FontAwesomeIcons.dumbbell,
        title: 'Fitness',
        description: 'Maintaining physical and mental health through exercise',
      ),
      HobbyItem(
        icon: FontAwesomeIcons.paw,
        title: 'Animal Lover',
        description: 'Passionate about animals and spending time with them',
      ),
      HobbyItem(
        icon: FontAwesomeIcons.book,
        title: 'Reading',
        description: 'Learning from books on technology and personal development',
      ),
      HobbyItem(
        icon: FontAwesomeIcons.plane,
        title: 'Travelling',
        description: 'Exploring new places and experiencing different cultures',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = Responsive.isDesktop(context) ? 5 : 
                               Responsive.isTablet(context) ? 2 : 1;
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: Responsive.isDesktop(context) ? 0.7 : 0.6,
            crossAxisSpacing: Responsive.isDesktop(context) ? 16 : 12,
            mainAxisSpacing: Responsive.isDesktop(context) ? 16 : 12,
          ),
          itemCount: hobbies.length,
          itemBuilder: (context, index) {
            return _buildHobbyCard(context, hobbies[index]);
          },
        );
      },
    );
  }

  Widget _buildHobbyCard(BuildContext context, HobbyItem hobby) {
    return Container(
      padding: EdgeInsets.all(Responsive.isDesktop(context) ? 16 : 12),
      decoration: AppDecoration.containerDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Icon
          Container(
            width: Responsive.isDesktop(context) ? 60 : 50,
            height: Responsive.isDesktop(context) ? 60 : 50,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.goldPrimary.withValues(alpha: 0.3),
                  spreadRadius: 1,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: FaIcon(
                hobby.icon,
                color: AppColors.appBackground,
                size: Responsive.isDesktop(context) ? 24 : 20,
              ),
            ),
          ),
          
          // Title
          Flexible(
            child: Text(
              hobby.title,
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 13,
                  tablet: 15,
                  desktop: 15,
                ),
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          
          // Description
          Flexible(
            flex: 2,
            child: Text(
              hobby.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 11,
                  tablet: 12,
                  desktop: 12,
                ),
                height: 1.3,
              ),
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class HobbyItem {
  final IconData icon;
  final String title;
  final String description;

  const HobbyItem({
    required this.icon,
    required this.title,
    required this.description,
  });
}
