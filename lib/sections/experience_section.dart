import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.sectionPadding(context),
      child: Column(
        children: [
          // Section Title
          Text(
            'Experience',
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
          
          Responsive.isDesktop(context)
              ? _buildDesktopLayout(context)
              : _buildMobileLayout(context),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Experience Timeline
        Expanded(
          flex: 3,
          child: _buildExperienceTimeline(context),
        ),
        
        const SizedBox(width: 60),
        
        // Skills
        Expanded(
          flex: 2,
          child: _buildSkills(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildExperienceTimeline(context),
        const SizedBox(height: 40),
        _buildSkills(context),
      ],
    );
  }

  Widget _buildExperienceTimeline(BuildContext context) {
    final experiences = [
      ExperienceItem(
        title: 'Team Lead',
        company: 'Evozard Consulting',
        location: 'Vadodara, Gujarat',
        duration: '2024 - Present',
        icon: FontAwesomeIcons.userTie,
        description: 'Leading development teams and managing multiple projects in mobile and web application development with focus on delivering high-quality solutions.',
      ),
      ExperienceItem(
        title: 'Sr. Application Developer & Team Lead',
        company: 'ChainClave',
        location: 'Vadodara, Gujarat',
        duration: '2021 - 2024',
        icon: FontAwesomeIcons.users,
        description: 'Led a development team and worked on various mobile and web applications using Flutter and modern technologies.',
      ),
      ExperienceItem(
        title: 'Flutter Developer',
        company: 'Freelance',
        location: 'Remote',
        duration: '2020 - 2021',
        icon: FontAwesomeIcons.code,
        description: 'Developed various mobile applications for clients across different industries, specializing in Flutter development.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: experiences.asMap().entries.map((entry) {
        int index = entry.key;
        ExperienceItem experience = entry.value;
        bool isLast = index == experiences.length - 1;
        
        return _buildExperienceCard(context, experience, isLast);
      }).toList(),
    );
  }

  Widget _buildExperienceCard(BuildContext context, ExperienceItem experience, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline Icon
        Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: AppColors.goldGradient,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.goldPrimary.withValues(alpha: 0.3),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: FaIcon(
                  experience.icon,
                  color: AppColors.appBackground,
                  size: 24,
                ),
              ),
            ),
            
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.goldPrimary,
                      AppColors.goldPrimary.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
          ],
        ),
        
        const SizedBox(width: 24),
        
        // Content
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 32),
            padding: const EdgeInsets.all(24),
            decoration: AppDecoration.containerDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  experience.title,
                  style: AppTextStyles.cardTitle.copyWith(
                    fontSize: Responsive.getFontSize(
                      context,
                      mobile: 16,
                      tablet: 18,
                      desktop: 18,
                    ),
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  experience.company,
                  style: AppTextStyles.cardSubtitle.copyWith(
                    fontSize: Responsive.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 16,
                      desktop: 16,
                    ),
                  ),
                ),
                
                const SizedBox(height: 4),
                
                Text(
                  '${experience.location} • ${experience.duration}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: Responsive.getFontSize(
                      context,
                      mobile: 12,
                      tablet: 14,
                      desktop: 14,
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                Text(
                  experience.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Responsive.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 15,
                      desktop: 15,
                    ),
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSkills(BuildContext context) {
    final skillCategories = [
      SkillCategory(
        title: 'Frontend',
        skills: ['Flutter', 'Dart', 'HTML/CSS', 'JavaScript', 'React'],
      ),
      SkillCategory(
        title: 'Backend',
        skills: ['Firebase', 'Node.js', 'REST APIs', 'GraphQL'],
      ),
      SkillCategory(
        title: 'Mobile',
        skills: ['iOS Development', 'Android Development', 'Cross-platform'],
      ),
      SkillCategory(
        title: 'Tools & Others',
        skills: ['Git', 'Clean Architecture', 'UI/UX Design', 'Project Management'],
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppDecoration.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Skills & Technologies',
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: Responsive.getFontSize(
                context,
                mobile: 18,
                tablet: 20,
                desktop: 22,
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          ...skillCategories.map((category) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildSkillCategory(context, category),
          )),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(BuildContext context, SkillCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.title,
          style: AppTextStyles.cardSubtitle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: category.skills.map((skill) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.goldPrimary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.goldPrimary.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              skill,
              style: TextStyle(
                color: AppColors.goldPrimary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}

class ExperienceItem {
  final String title;
  final String company;
  final String location;
  final String duration;
  final IconData icon;
  final String description;

  const ExperienceItem({
    required this.title,
    required this.company,
    required this.location,
    required this.duration,
    required this.icon,
    required this.description,
  });
}

class SkillCategory {
  final String title;
  final List<String> skills;

  const SkillCategory({
    required this.title,
    required this.skills,
  });
}
