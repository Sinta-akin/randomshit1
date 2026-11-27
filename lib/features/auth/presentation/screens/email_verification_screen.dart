import 'package:flutter/material.dart';
import 'package:automate/core/constants/app_constants.dart';
import 'package:automate/core/widgets/common_widgets.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool _isVerified = false;
  bool _isResending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(title: 'Check your inbox', showBack: true),
            const SizedBox(height: 24),
            const Text(
              'Check your inbox',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Verification email sent',
              style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E1E1E),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: const Center(
                      child: Icon(Icons.email, color: Colors.white, size: 48),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We sent a verification link to',
                    style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8)),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'arjun.kumar@example.com',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  PrimaryButton(
                    text: "I've verified",
                    onPressed: _isVerified
                        ? () => Navigator.pushNamed(context, AppConstants.roleSelection)
                        : () => setState(() => _isVerified = true),
                    isLoading: _isResending,
                  ),
                  const SizedBox(height: 16),
                  SecondaryButton(
                    text: 'Resend email',
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Verification email resent')),
                      );
                      setState(() => _isResending = true);
                      Future.delayed(const Duration(seconds: 1), () {
                        if (!mounted) return;
                        setState(() => _isResending = false);
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Didn't get it? Check your spam folder.",
                    style: TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
