import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'config/app_theme.dart';
import 'config/app_colors.dart';
import 'widgets/custom_nav_bar.dart';
import 'sections/hero_section.dart';
import 'sections/about_section.dart';
import 'sections/education_section.dart';
import 'sections/experience_section.dart';
import 'sections/projects_section.dart';
import 'sections/hobbies_section.dart';
import 'sections/contact_section.dart';
import 'widgets/back_to_top_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vishal Parekh - Portfolio',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const PortfolioHomePage(),
    );
  }
}

class PortfolioHomePage extends StatefulWidget {
  const PortfolioHomePage({Key? key}) : super(key: key);

  @override
  State<PortfolioHomePage> createState() => _PortfolioHomePageState();
}

class _PortfolioHomePageState extends State<PortfolioHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _currentSectionIndex = 0;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    setState(() {
      _showBackToTop = _scrollController.offset > 400;
    });
  }

  void _onSectionVisible(int index) {
    if (_currentSectionIndex != index) {
      setState(() {
        _currentSectionIndex = index;
      });
    }
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundGradient,
            ),
          ),
          
          // Main content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Sticky Navigation Bar
              SliverAppBar(
                pinned: true,
                floating: false,
                snap: false,
                elevation: 0,
                backgroundColor: Colors.transparent,
                expandedHeight: 80,
                collapsedHeight: 80,
                flexibleSpace: FlexibleSpaceBar(
                  background: CustomNavBar(
                    onItemTapped: (index) => setState(() => _currentSectionIndex = index),
                    currentIndex: _currentSectionIndex,
                    scrollController: _scrollController,
                  ),
                  collapseMode: CollapseMode.pin,
                ),
                automaticallyImplyLeading: false,
              ),
              
              // Sections
              SliverList(
                delegate: SliverChildListDelegate([
                  // Hero Section
                  VisibilityDetector(
                    key: const Key('hero-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(0);
                      }
                    },
                    child: const HeroSection(),
                  ),
                  
                  // About Section
                  VisibilityDetector(
                    key: const Key('about-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(1);
                      }
                    },
                    child: const AboutSection(),
                  ),
                  
                  // Education Section
                  VisibilityDetector(
                    key: const Key('education-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(2);
                      }
                    },
                    child: const EducationSection(),
                  ),
                  
                  // Experience Section
                  VisibilityDetector(
                    key: const Key('experience-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(3);
                      }
                    },
                    child: const ExperienceSection(),
                  ),
                  
                  // Projects Section
                  VisibilityDetector(
                    key: const Key('projects-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(4);
                      }
                    },
                    child: const ProjectsSection(),
                  ),
                  
                  // Hobbies Section
                  VisibilityDetector(
                    key: const Key('hobbies-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(5);
                      }
                    },
                    child: const HobbiesSection(),
                  ),
                  
                  // Contact Section
                  VisibilityDetector(
                    key: const Key('contact-section'),
                    onVisibilityChanged: (info) {
                      if (info.visibleFraction > 0.3) {
                        _onSectionVisible(6);
                      }
                    },
                    child: const ContactSection(),
                  ),
                ]),
              ),
            ],
          ),
          
          // Back to top button
          BackToTopButton(
            show: _showBackToTop,
            onPressed: _scrollToTop,
          ),
        ],
      ),
    );
  }
}
