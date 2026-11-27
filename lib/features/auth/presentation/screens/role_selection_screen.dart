import 'package:flutter/material.dart';
import 'package:automate/core/constants/app_constants.dart';
import 'package:automate/core/widgets/common_widgets.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;
  bool _isLoading = false;

  final List<Map<String, dynamic>> _roles = [
    {
      'title': 'Customer',
      'subtitle': 'Rent cars and book trusted services',
      'icon': Icons.person,
      'iconColor': Colors.blue,
    },
    {
      'title': 'Vehicle Owner',
      'subtitle': 'List your cars and earn with ease',
      'icon': Icons.directions_car,
      'iconColor': Colors.orange,
    },
    {
      'title': 'Workshop',
      'subtitle': 'Grow your service business',
      'icon': Icons.build,
      'iconColor': Colors.green,
    },
  ];

  void _handleContinue() {
    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a role')),
      );
      return;
    }
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.pushReplacementNamed(context, AppConstants.landing);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(title: 'Choose your role', showBack: true),
            const SizedBox(height: 16),
            const Text(
              'ONE LAST STEP',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFF64748B),
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'How will you use AutoMate?',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'You can change this later in your profile.',
              style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: _roles.length,
                itemBuilder: (context, index) {
                  final role = _roles[index];
                  final isSelected = _selectedRole == role['title'];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedRole = role['title']),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected ? const Color(0xFF2B5DFF) : const Color(0xFF333333),
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: (role['iconColor'] as Color).withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Icon(
                                role['icon'],
                                color: role['iconColor'],
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    role['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    role['subtitle'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF94A3B8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.radio_button_checked,
                                color: Color(0xFF2B5DFF),
                                size: 24,
                              )
                            else
                              const Icon(
                                Icons.radio_button_unchecked,
                                color: Color(0xFF64748B),
                                size: 24,
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: PrimaryButton(
                text: 'Continue as ${_selectedRole ?? 'Customer'}',
                onPressed: _handleContinue,
                isLoading: _isLoading,
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
