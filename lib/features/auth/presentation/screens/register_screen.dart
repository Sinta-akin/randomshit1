import 'package:flutter/material.dart';
import 'package:automate/core/constants/app_constants.dart';
import 'package:automate/core/widgets/common_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please agree to the Terms of Service and Privacy Policy')),
      );
      return;
    }
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      Navigator.pushNamed(context, AppConstants.emailVerification);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(title: 'Create your account', showBack: true),
              const SizedBox(height: 24),
              const Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Join AutoMate and get moving.',
                style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    AppTextField(
                      label: 'Full name',
                      hint: 'Enter your full name',
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.requiredField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Email address',
                      hint: 'you@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.requiredField;
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return AppConstants.invalidEmail;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Password',
                      hint: 'At least 8 characters',
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.requiredField;
                        }
                        if (value.length < 8) {
                          return AppConstants.passwordTooShort;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Confirm password',
                      hint: 'Re-enter your password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.requiredField;
                        }
                        if (value != _passwordController.text) {
                          return AppConstants.passwordMismatch;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Checkbox(
                          value: _agreedToTerms,
                          onChanged: (val) => setState(() => _agreedToTerms = val ?? false),
                          activeColor: const Color(0xFF2B5DFF),
                        ),
                        const Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree to the ',
                              style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12),
                              children: [
                                TextSpan(
                                  text: 'Terms of Service',
                                  style: TextStyle(
                                    color: Color(0xFF2B5DFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Privacy Policy',
                                  style: TextStyle(
                                    color: Color(0xFF2B5DFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(text: '.'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      text: 'Register',
                      onPressed: _handleRegister,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              color: Color(0xFF2B5DFF),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
