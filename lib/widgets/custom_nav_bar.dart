import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class CustomNavBar extends StatelessWidget {
  final Function(int) onItemTapped;
  final int currentIndex;
  final ScrollController scrollController;

  const CustomNavBar({
    Key? key,
    required this.onItemTapped,
    required this.currentIndex,
    required this.scrollController,
  }) : super(key: key);

  final List<NavItem> navItems = const [
    NavItem(title: 'Home', icon: FontAwesomeIcons.home),
    NavItem(title: 'About', icon: FontAwesomeIcons.user),
    NavItem(title: 'Education', icon: FontAwesomeIcons.graduationCap),
    NavItem(title: 'Experience', icon: FontAwesomeIcons.briefcase),
    NavItem(title: 'Projects', icon: FontAwesomeIcons.code),
    NavItem(title: 'Hobbies', icon: FontAwesomeIcons.heart),
    NavItem(title: 'Contact', icon: FontAwesomeIcons.envelope),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.appBackground.withValues(alpha: 0.95),
        border: Border(
          bottom: BorderSide(
            color: AppColors.goldPrimary.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.goldPrimary.withValues(alpha: 0.1),
            spreadRadius: 0,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? 40 : 20,
            vertical: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Logo/Name
              _buildLogo(context),
              
              // Navigation Items
              if (Responsive.isDesktop(context))
                _buildDesktopNav(context)
              else
                _buildMobileNav(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return InkWell(
      onTap: () => _scrollToSection(0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: AppColors.goldGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.goldPrimary.withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 10,
                ),
              ],
            ),
            child: const Center(
              child: Text(
                'VP',
                style: TextStyle(
                  color: AppColors.appBackground,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (Responsive.isDesktop(context)) ...[
            const SizedBox(width: 12),
            Text(
              'Vishal Parekh',
              style: AppTextStyles.cardTitle,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    return Row(
      children: navItems.asMap().entries.map((entry) {
        int index = entry.key;
        NavItem item = entry.value;
        bool isActive = currentIndex == index;
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: _buildNavItem(context, item, index, isActive, false),
        );
      }).toList(),
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(
        FontAwesomeIcons.bars,
        color: AppColors.goldPrimary,
      ),
      color: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.goldPrimary),
      ),
      onSelected: (index) => _scrollToSection(index),
      itemBuilder: (context) {
        return navItems.asMap().entries.map((entry) {
          int index = entry.key;
          NavItem item = entry.value;
          bool isActive = currentIndex == index;
          
          return PopupMenuItem<int>(
            value: index,
            child: _buildNavItem(context, item, index, isActive, true),
          );
        }).toList();
      },
    );
  }

  Widget _buildNavItem(BuildContext context, NavItem item, int index, 
      bool isActive, bool isMobile) {
    return InkWell(
      onTap: () => _scrollToSection(index),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 16 : 20,
          vertical: isMobile ? 12 : 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isActive ? AppColors.goldPrimary.withValues(alpha: 0.1) : null,
          border: isActive ? Border.all(
            color: AppColors.goldPrimary.withValues(alpha: 0.3),
          ) : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FaIcon(
              item.icon,
              size: 16,
              color: isActive ? AppColors.goldPrimary : AppColors.textMuted,
            ),
            const SizedBox(width: 8),
            Text(
              item.title,
              style: TextStyle(
                color: isActive ? AppColors.goldPrimary : AppColors.textSecondary,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _scrollToSection(int index) {
    onItemTapped(index);
    
    // Calculate scroll position based on section
    double position = 0;
    switch (index) {
      case 0: // Home
        position = 0;
        break;
      case 1: // About
        position = 800;
        break;
      case 2: // Education
        position = 1600;
        break;
      case 3: // Experience
        position = 2400;
        break;
      case 4: // Projects
        position = 3200;
        break;
      case 5: // Hobbies
        position = 4000;
        break;
      case 6: // Contact
        position = 4800;
        break;
    }

    scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }
}

class NavItem {
  final String title;
  final IconData icon;

  const NavItem({
    required this.title,
    required this.icon,
  });
}
