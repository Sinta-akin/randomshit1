import 'package:flutter/material.dart';
import 'package:automate/core/constants/app_constants.dart';
import 'package:automate/core/widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      setState(() => _isLoading = false);
      if (_emailController.text == AppConstants.simulatedEmail &&
          _passwordController.text == AppConstants.simulatedPassword) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppConstants.welcomeBack,
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
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
              const AppHeader(title: 'Welcome back', showBack: true),
              const SizedBox(height: 24),
              const Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Log in to continue your journey.',
                style: TextStyle(fontSize: 16, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 32),
              Form(
                key: _formKey,
                child: Column(
                  children: [
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
                      hint: 'Enter your password',
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstants.requiredField;
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.pushNamed(context, AppConstants.forgotPassword),
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Color(0xFF94A3B8),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    PrimaryButton(
                      text: 'Log in',
                      onPressed: _handleLogin,
                      isLoading: _isLoading,
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider(color: Color(0xFF333333))),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text('or', style: TextStyle(color: Color(0xFF94A3B8))),
                        ),
                        Expanded(child: Divider(color: Color(0xFF333333))),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'New to AutoMate? ',
                          style: TextStyle(color: Color(0xFF94A3B8), fontSize: 14),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppConstants.register),
                          child: const Text(
                            'Create account',
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
