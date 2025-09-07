import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.sectionPadding(context),
      child: Column(
        children: [
          // Section Title
          Text(
            'About Me',
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
        // Introduction Text
        Expanded(
          flex: 3,
          child: _buildIntroduction(context),
        ),
        
        const SizedBox(width: 80),
        
        // Highlights
        Expanded(
          flex: 2,
          child: _buildHighlights(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildIntroduction(context),
        const SizedBox(height: 40),
        _buildHighlights(context),
      ],
    );
  }

  Widget _buildIntroduction(BuildContext context) {
    return Column(
      crossAxisAlignment: Responsive.isDesktop(context)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        Text(
          'Hello! I\'m Vishal Parekh',
          style: AppTextStyles.cardTitle.copyWith(
            fontSize: Responsive.getFontSize(
              context,
              mobile: 20,
              tablet: 24,
              desktop: 28,
            ),
          ),
        ),
        
        const SizedBox(height: 20),
        
        Text(
          'A passionate Computer Engineer and Application Developer with over 5+ years of experience in building scalable, user-friendly mobile and web applications. I specialize in Flutter development and have a strong background in creating innovative solutions that solve real-world problems.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: Responsive.getFontSize(
              context,
              mobile: 16,
              tablet: 17,
              desktop: 18,
            ),
            height: 1.8,
          ),
          textAlign: Responsive.isDesktop(context)
              ? TextAlign.left
              : TextAlign.center,
        ),
        
        const SizedBox(height: 20),
        
        Text(
          'Currently working as Team Lead at Evozard Consulting, I have led development teams and delivered successful projects for clients across various industries. I believe in writing clean, maintainable code and following best practices in software architecture. When I\'m not coding, you\'ll find me spending time with animals - I\'m a passionate animal lover!',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: Responsive.getFontSize(
              context,
              mobile: 16,
              tablet: 17,
              desktop: 18,
            ),
            height: 1.8,
          ),
          textAlign: Responsive.isDesktop(context)
              ? TextAlign.left
              : TextAlign.center,
        ),
        
        const SizedBox(height: 30),
        
        // // Download CV Button
        // SizedBox(
        //   width: Responsive.isDesktop(context) ? null : double.infinity,
        //   child: ElevatedButton.icon(
        //     onPressed: _downloadCV,
        //     icon: const FaIcon(FontAwesomeIcons.download, size: 18),
        //     label: const Text('Download CV'),
        //     style: ElevatedButton.styleFrom(
        //       padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildHighlights(BuildContext context) {
    final highlights = [
      HighlightItem(
        icon: FontAwesomeIcons.clock,
        title: '5+ Years',
        subtitle: 'Experience',
      ),
      HighlightItem(
        icon: FontAwesomeIcons.code,
        title: 'Flutter Expert',
        subtitle: 'Mobile & Web Development',
      ),
      HighlightItem(
        icon: FontAwesomeIcons.users,
        title: 'Team Leader',
        subtitle: 'Leading Development Teams',
      ),
      HighlightItem(
        icon: FontAwesomeIcons.rocket,
        title: '5+ Apps',
        subtitle: 'Published on Play Store',
      ),
      HighlightItem(
        icon: FontAwesomeIcons.building,
        title: 'Team Lead',
        subtitle: 'Evozard Consulting',
      ),
      HighlightItem(
        icon: FontAwesomeIcons.cog,
        title: 'Clean Architecture',
        subtitle: 'Best Practices',
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: AppDecoration.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Highlights',
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
          
          ...highlights.map((highlight) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildHighlightItem(context, highlight),
          )),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(BuildContext context, HighlightItem item) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.goldPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.goldPrimary.withValues(alpha: 0.3),
            ),
          ),
          child: Center(
            child: FaIcon(
              item.icon,
              size: 18,
              color: AppColors.goldPrimary,
            ),
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: AppTextStyles.cardSubtitle.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                item.subtitle,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _downloadCV() async {
    // In a real app, you would have a CV file in assets/files/
    // For now, we'll show a placeholder message
    const url = 'https://example.com/vishal-parekh-cv.pdf';
    
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    } catch (e) {
      // Handle error - in a real app you might show a snackbar
      print('Could not launch CV download: $e');
    }
  }
}

class HighlightItem {
  final IconData icon;
  final String title;
  final String subtitle;

  const HighlightItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}
