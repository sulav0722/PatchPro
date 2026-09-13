import 'dart:ui';
import 'package:flutter/material.dart';
import '../screens/games_screen.dart';
import '../screens/home_screen.dart'; // Adjust import to your actual HomeScreen file

class BottomNavBar extends StatelessWidget {
  final int activeIndex;
  final ValueChanged<int>? onTap;

  const BottomNavBar({
    super.key,
    required this.activeIndex,
    this.onTap,
  });

  void _handleNavigation(BuildContext context, int index) {
    if (onTap != null) {
      onTap!(index);
      return;
    }

    if (index == 0) {
      // Only block if already on the actual HomeScreen widget
      if (context.findAncestorWidgetOfExactType<HomeScreen>() != null) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else if (index == 1) {
      // Only block if already on the actual GamesScreen widget
      // Sub-screens like Dota2Screen will now navigate to GamesScreen properly
      if (context.findAncestorWidgetOfExactType<GamesScreen>() != null) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GamesScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 24,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            height: 68,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.75),
              borderRadius: BorderRadius.circular(36),
              border: Border.all(
                color: Colors.white.withOpacity(0.12),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  context: context,
                  index: 0,
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home_rounded,
                  label: 'Home',
                ),
                _buildNavItem(
                  context: context,
                  index: 1,
                  icon: Icons.sports_esports_outlined,
                  activeIcon: Icons.sports_esports_rounded,
                  label: 'Games',
                ),
                _buildNavItem(
                  context: context,
                  index: 2,
                  icon: Icons.local_offer_outlined,
                  activeIcon: Icons.local_offer_rounded,
                  label: 'Offers',
                ),
                _buildNavItem(
                  context: context,
                  index: 3,
                  icon: Icons.person_outline_rounded,
                  activeIcon: Icons.person_rounded,
                  label: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
  }) {
    final bool isActive = activeIndex == index;
    final Color itemColor = isActive ? Colors.white : Colors.white38;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _handleNavigation(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? activeIcon : icon,
            color: itemColor,
            size: 22,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: itemColor,
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}