import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'login_screen.dart';

class StartupScreen extends StatelessWidget {
  const StartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Added black fallback background to ensure no white flash during loads
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/startup.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Logo (shifted to top/center)
          SafeArea(
            child: Align(
              alignment: const Alignment(0, -0.65), // Shifted further towards the top
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/patchpro.png',
                    height: 65, 
                    fit: BoxFit.contain,
                  ),
                  // Forcefully pulls the text upward to eat the transparent padding
                  Transform.translate(
                    offset: const Offset(0, -15),
                    child: const Text(
                      'PatchPRO',
                      style: TextStyle(
                        fontFamily: 'JockeyOne',
                        fontSize: 32,
                        color: AppColors.rubyDark,
                        height: 0.8, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // 3. Bottom White Sheet (Pulled all the way down)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF9F9F9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              // Moving SafeArea INSIDE the container allows the white background to stretch 
              // completely to the bottom edge, while keeping the button safely above the home notch.
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 36, 24, 24), // Reduced bottom padding since SafeArea handles the notch
                  child: SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.rubyDark,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Let the game begin',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.sports_esports, size: 22),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}