import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dota2_7_41e.dart';

class Dota2Screen extends StatefulWidget {
  const Dota2Screen({super.key});

  @override
  State<Dota2Screen> createState() => _Dota2ScreenState();
}

class _Dota2ScreenState extends State<Dota2Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Static Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/battle_mobile.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 2. Dark Overlay Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withOpacity(0.75),
                  Colors.black.withOpacity(0.25),
                  Colors.black.withOpacity(0.95),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.0, 0.45, 1.0],
              ),
            ),
          ),

          // 3. Foreground Content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDefaultTopNavigation(),
                const Spacer(),

                // Logo, Slogan & Dropdown Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Dota 2 Name Logo
                      Image.asset(
                        'assets/images/dota2_name.png',
                        height: 36,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => const Text(
                          'DOTA 2',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      const Text(
                        '"THE ULTIMATE\nARENA OF\nINFINITE TACTICS."',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          height: 1.15,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildPatchNotesDropdown(context),
                    ],
                  ),
                ),

                const Spacer(),

                // Latest News Section
                _buildLatestNewsSection(),
                const SizedBox(height: 100), // Clears the floating BottomNavBar
              ],
            ),
          ),

          // 4. Floating Bottom Navigation Bar
          const BottomNavBar(activeIndex: 1),
        ],
      ),
    );
  }

  Widget _buildDefaultTopNavigation() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(Icons.notifications_none, color: Colors.white, size: 28),
          const SizedBox(width: 16),
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[800],
            backgroundImage: const NetworkImage(
              'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/crystal_maiden.png',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPatchNotesDropdown(BuildContext context) {
    return PopupMenuButton<String>(
      offset: const Offset(0, 50),
      color: const Color(0xFF1E1E1E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.white.withOpacity(0.1)),
      ),
      onSelected: (String value) {
        if (value == '7.41e (Latest)' || value == '7.41e') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dota2741eScreen()),
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        _buildPopupMenuItem('7.41e (Latest)', '7.41e (Latest)'),
        const PopupMenuDivider(height: 1),
        _buildPopupMenuItem('7.41e', '7.41e'),
        _buildPopupMenuItem('7.41d', '7.41d'),
        _buildPopupMenuItem('7.41c', '7.41c'),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.white, width: 2.0),
        ),
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.menu_book_rounded, color: Colors.white, size: 16),
            SizedBox(width: 8),
            Text(
              'VIEW PATCH NOTES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }

  PopupMenuItem<String> _buildPopupMenuItem(String value, String text) {
    return PopupMenuItem<String>(
      value: value,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  Widget _buildLatestNewsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                'LATEST NEWS',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              SizedBox(width: 8),
              Text(
                'VIEW ALL',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                  letterSpacing: 1.0,
                ),
              ),
              Icon(Icons.arrow_forward, color: Colors.white38, size: 12),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 140,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                _buildNewsCard(
                  'The International 2026 Grand Champions',
                  'AUGUST 27, 2026',
                  'assets/images/teamspirit.png',
                ),
                _buildNewsCard(
                  'The International Main Event',
                  'AUGUST 19, 2026',
                  'assets/images/mainevent.png',
                ),
                _buildNewsCard(
                  'The International: Streams, Secret Shop, and More',
                  'AUGUST 12, 2026',
                  'assets/images/secretshop.png',
                ),
                _buildNewsCard(
                  'The International: Predictions, Fantasy, and Supporter Bundles',
                  'JULY 31, 2026',
                  'assets/images/predictions.png',
                ),
                _buildNewsCard(
                  'The Dark Carnival',
                  'JUNE 26, 2026',
                  'assets/images/dark_carnival.png',
                ),
                _buildNewsCard(
                  'The International 2026 Ticket Sales',
                  'MAY 26, 2026',
                  'assets/images/ticket.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewsCard(String title, String date, String imagePath) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Asset Image covering the entire card
          Positioned.fill(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.grey[850],
                child: const Icon(Icons.image, color: Colors.white24, size: 40),
              ),
            ),
          ),

          // Gradient Overlay fading upwards from the bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.95),
                    Colors.black.withOpacity(0.7),
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      color: Colors.white60,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}