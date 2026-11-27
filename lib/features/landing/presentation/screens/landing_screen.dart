import 'package:flutter/material.dart';
import 'package:automate/core/theme/app_theme.dart';
import 'package:automate/core/constants/app_constants.dart';
import 'package:automate/core/widgets/common_widgets.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() => _currentPage = page);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top header with logo and skip
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppLogo(),
                  SkipLink(
                    onTap: () => Navigator.pushNamed(context, AppConstants.login),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Carousel pages
            Expanded(
              child: PageView(
                controller: _pageController,
                children: const [
                  _LandingPage1(),
                  _LandingPage2(),
                  _LandingPage3(),
                ],
              ),
            ),

            // Page indicators
            _PageIndicators(currentPage: _currentPage),
            const SizedBox(height: 32),

            // CTA button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: 'Continue',
                onPressed: () => Navigator.pushNamed(context, AppConstants.login),
                trailingArrow: true,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

/// Page 1: DRIVE YOUR WAY - "The right car, right when you need it"
class _LandingPage1 extends StatelessWidget {
  const _LandingPage1();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: AssetImage(AppConstants.landingHeroImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.verified, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        '500+ verified cars',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                'DRIVE YOUR WAY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'The right car, right when you need it',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Choose from verified cars near you and book in just a few taps.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF94A3B8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Page 2: AI MATCHED - "Smarter choices for every journey"
class _LandingPage2 extends StatelessWidget {
  const _LandingPage2();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(24),
                  image: const DecorationImage(
                    image: AssetImage(AppConstants.serviceHeroImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Personalised for you',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                'AI MATCHED',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Smarter choices for every journey',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Tell us your plans and our AI will find the perfect ride for your needs.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF94A3B8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Page 3: SERVICE MADE SIMPLE - "Expert car care, without the wait"
class _LandingPage3 extends StatelessWidget {
  const _LandingPage3();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.build, color: Color(0xFFFF6B00), size: 48),
                      SizedBox(height: 16),
                      Icon(Icons.check_circle, color: Color(0xFF10B981), size: 32),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.build, color: Colors.white, size: 16),
                      SizedBox(width: 6),
                      Text(
                        '150+ trusted workshops',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Text(
                'SERVICE MADE SIMPLE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'Expert car care, without the wait',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'Book trusted workshops, track service progress and get back on the road.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF94A3B8),
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Page indicator dots.
class _PageIndicators extends StatelessWidget {
  final int currentPage;

  const _PageIndicators({required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 24,
          height: 4,
          decoration: BoxDecoration(
            color: index == currentPage ? const Color(0xFF2B5DFF) : const Color(0xFF333333),
            borderRadius: BorderRadius.circular(2),
          ),
        );
      }),
    );
  }
}
