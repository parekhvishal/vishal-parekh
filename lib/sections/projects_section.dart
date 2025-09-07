import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.sectionPadding(context),
      child: Column(
        children: [
          // Section Title
          Text(
            'Projects',
            style: AppTextStyles.sectionTitle.copyWith(
              fontSize: Responsive.getFontSize(
                context,
                mobile: 28,
                tablet: 36,
                desktop: 40,
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Text(
            'Published Apps on Google Play Store',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: Responsive.getFontSize(
                context,
                mobile: 16,
                tablet: 17,
                desktop: 18,
              ),
            ),
          ),
          
          const SizedBox(height: 60),
          
          // Projects Grid
          _buildProjectsGrid(context),
        ],
      ),
    );
  }

  Widget _buildProjectsGrid(BuildContext context) {
    final projects = [
      ProjectItem(
        title: 'Myky – eCommerce App',
        description: 'A comprehensive eCommerce application with modern UI/UX and seamless shopping experience.',
        icon: FontAwesomeIcons.shoppingCart,
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.myky.app',
        technologies: ['Flutter', 'Firebase', 'Payment Gateway'],
      ),
      ProjectItem(
        title: 'Bitonk – Crypto Exchange',
        description: 'Cryptocurrency trading platform with real-time market data and secure transactions.',
        icon: FontAwesomeIcons.bitcoin,
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.bitonk.app',
        technologies: ['Flutter', 'REST API', 'WebSocket'],
      ),
      ProjectItem(
        title: 'Neskbit – Trading Platform',
        description: 'Advanced trading platform for cryptocurrency and financial instruments.',
        icon: FontAwesomeIcons.chartLine,
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.neskbit.app',
        technologies: ['Flutter', 'Charts', 'Real-time Data'],
      ),
      ProjectItem(
        title: 'PurpleX – CPI Marketing',
        description: 'Cost Per Install marketing application with analytics and campaign management.',
        icon: FontAwesomeIcons.bullhorn,
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.purplex.app',
        technologies: ['Flutter', 'Analytics', 'Firebase'],
      ),
      ProjectItem(
        title: 'Walk Wallet – Step Counter',
        description: 'Fitness app that rewards users for walking with points and prizes.',
        icon: FontAwesomeIcons.walking,
        playStoreUrl: 'https://play.google.com/store/apps/details?id=com.walkwallet.app',
        technologies: ['Flutter', 'Health Kit', 'Rewards System'],
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = Responsive.getGridColumns(context);
        
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: Responsive.isDesktop(context) ? 1.1 : 0.9,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
          ),
          itemCount: projects.length,
          itemBuilder: (context, index) {
            return _buildProjectCard(context, projects[index]);
          },
        );
      },
    );
  }

  Widget _buildProjectCard(BuildContext context, ProjectItem project) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _openPlayStoreLink(project.playStoreUrl),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: AppDecoration.containerDecoration().copyWith(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon and Play Store Link
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      gradient: AppColors.goldGradient,
                      borderRadius: BorderRadius.circular(12),
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
                        project.icon,
                        color: AppColors.appBackground,
                        size: 24,
                      ),
                    ),
                  ),
                  
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.goldPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.goldPrimary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.googlePlay,
                      color: AppColors.goldPrimary,
                      size: 16,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Title
              Text(
                project.title,
                style: AppTextStyles.cardTitle.copyWith(
                  fontSize: Responsive.getFontSize(
                    context,
                    mobile: 16,
                    tablet: 17,
                    desktop: 18,
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Description
              Expanded(
                child: Text(
                  project.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: Responsive.getFontSize(
                      context,
                      mobile: 14,
                      tablet: 15,
                      desktop: 15,
                    ),
                    height: 1.5,
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Technologies
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: project.technologies.map((tech) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.goldPrimary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.goldPrimary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Text(
                    tech,
                    style: TextStyle(
                      color: AppColors.goldPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )).toList(),
              ),
              
              const SizedBox(height: 16),
              
              // View on Play Store Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _openPlayStoreLink(project.playStoreUrl),
                  icon: const FaIcon(FontAwesomeIcons.googlePlay, size: 14),
                  label: const Text('View on Play Store'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPlayStoreLink(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch Play Store link: $e');
    }
  }
}

class ProjectItem {
  final String title;
  final String description;
  final IconData icon;
  final String playStoreUrl;
  final List<String> technologies;

  const ProjectItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.playStoreUrl,
    required this.technologies,
  });
}
