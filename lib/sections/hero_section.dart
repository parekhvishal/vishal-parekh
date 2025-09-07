import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/animated_background.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _rotateController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );
    
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));
    
    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _rotateController,
      curve: Curves.linear,
    ));
    
    _pulseController.repeat(reverse: true);
    _rotateController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: Responsive.screenHeight(context) - 80,
      ),
      child: Stack(
        children: [
          // Animated particle background
          const Positioned.fill(
            child: AnimatedBackground(),
          ),
          
          // Main content
          Container(
            padding: Responsive.sectionPadding(context),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Responsive.isDesktop(context) ? 1200 : double.infinity,
                ),
                child: Responsive.isDesktop(context)
                    ? _buildDesktopLayout(context)
                    : _buildMobileLayout(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Photo
        Expanded(
          flex: 2,
          child: _buildProfilePhoto(context),
        ),
        
        const SizedBox(width: 60),
        
        // Content
        Expanded(
          flex: 3,
          child: _buildContent(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 40),
        
        // Profile Photo
        _buildProfilePhoto(context),
        const SizedBox(height: 40),
        
        // Content
        _buildContent(context),
        
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    final size = Responsive.responsive<double>(
      context,
      mobile: 220,
      tablet: 280,
      desktop: 340,
    );
    
    return AnimatedBuilder(
      animation: _pulseAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Animated rotating outer rings
              AnimatedBuilder(
                animation: _rotateAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotateAnimation.value * 2 * 3.14159,
                    child: Stack(
                      alignment: Alignment.center,
                      children: List.generate(3, (index) {
                        return Container(
                          width: size + (index * 25),
                          height: size + (index * 25),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.goldPrimary.withValues(
                                alpha: 0.15 - (index * 0.03),
                              ),
                              width: 1.5,
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
              ),
        
        // Main photo container with enhanced styling
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.goldPrimary,
                AppColors.goldSecondary,
                AppColors.goldPrimary.withValues(alpha: 0.8),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.goldPrimary.withValues(alpha: 0.4),
                spreadRadius: 0,
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
              BoxShadow(
                color: AppColors.goldPrimary.withValues(alpha: 0.2),
                spreadRadius: 10,
                blurRadius: 40,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: ClipOval(
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/vishal.jpeg',
                        width: size - 20,
                        height: size - 20,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: AppColors.goldSecondary.withValues(alpha: 0.1),
                            child: const Center(
                              child: FaIcon(
                                FontAwesomeIcons.user,
                                size: 80,
                                color: AppColors.goldPrimary,
                              ),
                            ),
                          );
                        },
                      ),
                      // Subtle overlay for enhanced look
                      Container(
                        width: size - 20,
                        height: size - 20,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              AppColors.goldPrimary.withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        
        // Floating decorative elements with gentle animations
        Positioned(
          top: 20,
          right: 30,
          child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (0.2 * (_rotateAnimation.value % 1)),
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: AppColors.goldPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldPrimary.withValues(alpha: 0.6),
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        Positioned(
          bottom: 40,
          left: 20,
          child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (0.15 * ((_rotateAnimation.value + 0.5) % 1)),
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.goldSecondary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldSecondary.withValues(alpha: 0.6),
                        spreadRadius: 1,
                        blurRadius: 6,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        Positioned(
          top: 60,
          left: 15,
          child: AnimatedBuilder(
            animation: _rotateAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: 1.0 + (0.1 * ((_rotateAnimation.value + 0.3) % 1)),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.goldPrimary.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.goldPrimary.withValues(alpha: 0.4),
                        spreadRadius: 1,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: Responsive.isDesktop(context)
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Name
        Text(
          'Vishal Parekh',
          style: AppTextStyles.heroTitle.copyWith(
            fontSize: Responsive.getFontSize(
              context,
              mobile: 32,
              tablet: 48,
              desktop: 56,
            ),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Animated Title
        SizedBox(
          height: 60,
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Computer Engineer',
                textStyle: AppTextStyles.heroSubtitle.copyWith(
                  fontSize: Responsive.getFontSize(
                    context,
                    mobile: 18,
                    tablet: 22,
                    desktop: 24,
                  ),
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Application Developer',
                textStyle: AppTextStyles.heroSubtitle.copyWith(
                  fontSize: Responsive.getFontSize(
                    context,
                    mobile: 18,
                    tablet: 22,
                    desktop: 24,
                  ),
                ),
                speed: const Duration(milliseconds: 100),
              ),
              TypewriterAnimatedText(
                'Team Leader',
                textStyle: AppTextStyles.heroSubtitle.copyWith(
                  fontSize: Responsive.getFontSize(
                    context,
                    mobile: 18,
                    tablet: 22,
                    desktop: 24,
                  ),
                ),
                speed: const Duration(milliseconds: 100),
              ),
            ],
            repeatForever: true,
            pause: const Duration(milliseconds: 1000),
          ),
        ),
        
        const SizedBox(height: 24),
        
        // Tagline
        Text(
          'I build scalable, user-friendly mobile and web applications.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            fontSize: Responsive.getFontSize(
              context,
              mobile: 16,
              tablet: 18,
              desktop: 18,
            ),
          ),
          textAlign: Responsive.isDesktop(context)
              ? TextAlign.left
              : TextAlign.center,
        ),
        
        const SizedBox(height: 40),
        
        // CTA Buttons
        _buildCTAButtons(context),
      ],
    );
  }

  Widget _buildCTAButtons(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildPrimaryButton(context, 'View Projects', () => _scrollToProjects(context)),
              const SizedBox(width: 20),
              _buildSecondaryButton(context, 'Contact Me', () => _scrollToContact(context)),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildPrimaryButton(context, 'View Projects', () => _scrollToProjects(context)),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: _buildSecondaryButton(context, 'Contact Me', () => _scrollToContact(context)),
              ),
            ],
          );
  }

  Widget _buildPrimaryButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const FaIcon(FontAwesomeIcons.code, size: 18),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        elevation: 8,
        shadowColor: AppColors.goldPrimary.withValues(alpha: 0.3),
        minimumSize: Responsive.isDesktop(context) 
          ? const Size(180, 60)
          : const Size(double.infinity, 60),
      ),
    );
  }

  Widget _buildSecondaryButton(
      BuildContext context, String text, VoidCallback onPressed) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const FaIcon(FontAwesomeIcons.envelope, size: 18),
      label: Text(text),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
        minimumSize: Responsive.isDesktop(context) 
          ? const Size(180, 60)
          : const Size(double.infinity, 60),
      ),
    );
  }
  
  void _scrollToProjects(BuildContext context) {
    // Scroll to projects section
    try {
      Scrollable.of(context).position.animateTo(
        3200, // Approximate position of projects section
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      // Handle scroll error gracefully
      print('Error scrolling to projects: $e');
    }
  }
  
  void _scrollToContact(BuildContext context) {
    // Scroll to contact section
    try {
      Scrollable.of(context).position.animateTo(
        4800, // Approximate position of contact section
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    } catch (e) {
      // Handle scroll error gracefully
      print('Error scrolling to contact: $e');
    }
  }
}
