import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Initialized without default text so the fields start empty
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State for the language dropdown
  String _selectedLanguage = 'English';
  final List<String> _languages = ['English', 'Chinese', 'Japanese', 'Russian'];

  // Authentication logic
  void _handleLogin() {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username == 'ringmaster@gmail.com' && password == 'ringmaster111') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid credentials, Try Again'),
          backgroundColor: AppColors.rubyLight,
        ),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Main content overlay
          SafeArea(
            child: Column(
              children: [
                // Top language dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedLanguage,
                          dropdownColor: AppColors.surface, // Dark dropdown menu
                          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          items: _languages.map((String lang) {
                            return DropdownMenuItem<String>(
                              value: lang,
                              child: Text(lang),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              setState(() => _selectedLanguage = newValue);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // Main form area perfectly centered vertically
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minHeight: constraints.maxHeight),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // White Login Card
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(24.0),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9F9F9),
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Title
                                      RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            fontSize: 28,
                                            fontWeight: FontWeight.w800,
                                            letterSpacing: -0.5,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "Let's ",
                                              style: TextStyle(color: AppColors.rubyLight),
                                            ),
                                            TextSpan(
                                              text: "dive in.",
                                              style: TextStyle(color: AppColors.rubyDark),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Subtitle
                                      const Text(
                                        'Discover the updates of\nvarious games in one app',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppColors.rubyLight,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3,
                                        ),
                                      ),
                                      const SizedBox(height: 32),

                                      // Username / Email Input
                                      _buildTextField('Email or Username', _usernameController),
                                      const SizedBox(height: 16),

                                      // Password Input
                                      _buildTextField('Password', _passwordController, obscureText: true),
                                      const SizedBox(height: 12),

                                      // Forgot Password
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),

                                      // Sign In Button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: ElevatedButton(
                                          onPressed: _handleLogin,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.rubyDark,
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(25),
                                            ),
                                            elevation: 0,
                                          ),
                                          child: const Text(
                                            'Sign In',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 24),

                                      // Or sign in with
                                      Center(
                                        child: Text(
                                          'or sign in with',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),

                                      // Social Buttons
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          _buildSocialButton(imagePath: 'assets/images/google.png'),
                                          const SizedBox(width: 16),
                                          _buildSocialButton(icon: Icons.apple, iconColor: Colors.black),
                                          const SizedBox(width: 16),
                                          _buildSocialButton(icon: Icons.facebook, iconColor: Colors.blue[800]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const SizedBox(height: 20),

                                // Floating Sign Up Button at the bottom
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
                                      );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color(0xFFF9F9F9),
                                      side: const BorderSide(color: Colors.transparent),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: AppColors.rubyDark,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 40), 
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for text fields 
  Widget _buildTextField(String hint, TextEditingController controller, {bool obscureText = false}) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.rubyDark, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.rubyDark, width: 2.0),
        ),
      ),
    );
  }

  // Helper widget for social login buttons
  Widget _buildSocialButton({String? imagePath, IconData? icon, Color? iconColor}) {
    return Container(
      width: 65,
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08), 
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: imagePath != null
            ? Image.asset(imagePath, height: 24, fit: BoxFit.contain)
            : Icon(icon, color: iconColor, size: 28),
      ),
    );
  }
}

// ----------------------------------------------------------------------
// PLACEHOLDER SCREENS
// ----------------------------------------------------------------------

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: const Center(
        child: Text('Sign Up Page Placeholder', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}