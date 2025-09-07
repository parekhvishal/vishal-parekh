import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';
import '../config/app_colors.dart';
import '../config/app_theme.dart';
import '../utils/responsive.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Responsive.sectionPadding(context),
      child: Column(
        children: [
          // Section Title
          Text(
            'Contact Me',
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
          
          const SizedBox(height: 60),
          
          // Social Links
          _buildSocialLinks(context),
          
          const SizedBox(height: 40),
          
          // Footer
          Text(
            '© 2024 Vishal Parekh. All rights reserved.',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Form
        Expanded(
          flex: 2,
          child: _buildContactForm(context),
        ),
        
        const SizedBox(width: 60),
        
        // Contact Info
        Expanded(
          flex: 1,
          child: _buildContactInfo(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildContactForm(context),
        const SizedBox(height: 40),
        _buildContactInfo(context),
      ],
    );
  }

  Widget _buildContactForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: AppDecoration.containerDecoration(),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send Message',
              style: AppTextStyles.cardTitle.copyWith(
                fontSize: Responsive.getFontSize(
                  context,
                  mobile: 20,
                  tablet: 22,
                  desktop: 24,
                ),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Name Field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Your Name',
                prefixIcon: Icon(Icons.person_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Email Field
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Your Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Subject Field
            TextFormField(
              controller: _subjectController,
              decoration: const InputDecoration(
                labelText: 'Subject',
                prefixIcon: Icon(Icons.subject_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a subject';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Message Field
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                labelText: 'Your Message',
                prefixIcon: Icon(Icons.message_outlined),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your message';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 24),
            
            // Send Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _sendEmail,
                icon: const FaIcon(FontAwesomeIcons.paperPlane, size: 16),
                label: const Text('Send Message'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    final contactItems = [
      ContactInfoItem(
        icon: FontAwesomeIcons.envelope,
        title: 'Email',
        value: 'vmparekh8888@gmail.com',
        onTap: () => _launchEmail('vmparekh8888@gmail.com'),
      ),
      ContactInfoItem(
        icon: FontAwesomeIcons.linkedin,
        title: 'LinkedIn',
        value: 'linkedin.com/in/vishal-parekh-9b4bb0189',
        onTap: () => _launchUrl('https://www.linkedin.com/in/vishal-parekh-9b4bb0189/'),
      ),
      ContactInfoItem(
        icon: FontAwesomeIcons.github,
        title: 'GitHub',
        value: 'github.com/parekhvishal',
        onTap: () => _launchUrl('https://github.com/parekhvishal'),
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: AppDecoration.containerDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get In Touch',
            style: AppTextStyles.cardTitle.copyWith(
              fontSize: Responsive.getFontSize(
                context,
                mobile: 20,
                tablet: 22,
                desktop: 24,
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Text(
            'Feel free to reach out for collaborations, opportunities, or just to say hello!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: Responsive.getFontSize(
                context,
                mobile: 14,
                tablet: 15,
                desktop: 16,
              ),
              height: 1.6,
            ),
          ),
          
          const SizedBox(height: 32),
          
          ...contactItems.map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _buildContactInfoItem(context, item),
          )),
        ],
      ),
    );
  }

  Widget _buildContactInfoItem(BuildContext context, ContactInfoItem item) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
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
                  size: 16,
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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    item.value,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socialLinks = [
      SocialLink(
        icon: FontAwesomeIcons.linkedin,
        url: 'https://www.linkedin.com/in/vishal-parekh-9b4bb0189/',
      ),
      SocialLink(
        icon: FontAwesomeIcons.github,
        url: 'https://github.com/parekhvishal',
      ),
      SocialLink(
        icon: FontAwesomeIcons.xTwitter,
        url: 'https://x.com/vmparekh8888',
      ),
      SocialLink(
        icon: FontAwesomeIcons.instagram,
        url: 'https://www.instagram.com/vishalparekh.ai/',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: socialLinks.map((link) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: InkWell(
          onTap: () => _launchUrl(link.url),
          borderRadius: BorderRadius.circular(30),
          child: Container(
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
                link.icon,
                color: AppColors.appBackground,
                size: 20,
              ),
            ),
          ),
        ),
      )).toList(),
    );
  }

  void _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      final mailtoLink = Mailto(
        to: ['vmparekh8888@gmail.com'],
        subject: _subjectController.text,
        body: '''
Name: ${_nameController.text}
Email: ${_emailController.text}

Message:
${_messageController.text}
        ''',
      );
      
      _launchUrl(mailtoLink.toString());
      
      // Clear form after sending
      _nameController.clear();
      _emailController.clear();
      _subjectController.clear();
      _messageController.clear();
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email client opened. Thank you for your message!'),
            backgroundColor: AppColors.goldPrimary,
          ),
        );
      }
    }
  }

  void _launchEmail(String email) async {
    final mailtoLink = Mailto(to: [email]);
    _launchUrl(mailtoLink.toString());
  }

  void _launchUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('Could not launch URL: $e');
    }
  }
}

class ContactInfoItem {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ContactInfoItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });
}

class SocialLink {
  final IconData icon;
  final String url;

  const SocialLink({
    required this.icon,
    required this.url,
  });
}
