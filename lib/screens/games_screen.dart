import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dota2_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFA57B0A), Color(0xFFAF8E34), Color(0xFFB9A05D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final List<Map<String, dynamic>> games = const [
    {'name': 'DOTA 2', 'icon': 'assets/images/dota2.png', 'fit': BoxFit.cover},
    {'name': 'Deadlock', 'icon': 'assets/images/deadlock.png', 'fit': BoxFit.cover},
    {'name': 'AOE 4', 'icon': 'assets/images/aoe4.png', 'fit': BoxFit.contain},
    {'name': 'Valorant', 'icon': 'assets/images/valorant.jpg', 'fit': BoxFit.cover},
    {'name': 'Overwatch 2', 'icon': 'assets/images/overwatch2.webp', 'fit': BoxFit.contain},
    {'name': 'TFT', 'icon': 'assets/images/tft.png', 'fit': BoxFit.contain},
    {'name': 'LOL', 'icon': 'assets/images/lol.webp', 'fit': BoxFit.cover},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'All Games',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: games.length,
                        itemBuilder: (context, index) {
                          final game = games[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.4),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              leading: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: goldGradient,
                                ),
                                child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.black,
                                  child: ClipOval(
                                    child: Image.asset(
                                      game['icon']!,
                                      width: 40,
                                      height: 40,
                                      fit: game['fit'],
                                    ),
                                  ),
                                ),
                              ),
                              title: Text(
                                game['name']!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70, size: 16),
                              onTap: () {
                                if (index == 0 || game['name'] == 'DOTA 2') {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => const Dota2Screen()),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 120),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const BottomNavBar(activeIndex: 1),
        ],
      ),
    );
  }
}