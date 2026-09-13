import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart'; // Import shared nav bar
import 'dota2_screen.dart';
import 'dota2_7_41e.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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

  final List<Map<String, dynamic>> latestUpdates = const [
    {
      'title': 'Gameplay Patch 7.41e\nand Summer Scrub',
      'image': 'assets/images/gp_dota2.png',
      'bullets': ['Patch 7.41e Balance Update', 'Summer Scrub Fixes', 'The International 2026 Content'],
      'logo': 'assets/images/dota2.png',
    },
    {
      'title': 'Matchmaking\nUpdate',
      'image': 'assets/images/gp_deadlock.png',
      'bullets': ['Matchmaking Overhaul', 'Standard (Unranked)', 'Ranked (Competitive)'],
      'logo': 'assets/images/deadlock.png',
    },
    {
      'title': 'Patch 16.2.148\nReleased',
      'image': 'assets/images/gp_AOE.jpg',
      'bullets': ['New seasonal biome', 'Cavalry rebalancing', 'UI improvements'],
      'logo': 'assets/images/aoe4.png',
    },
  ];

  final List<Map<String, String>> trendingNews = const [
    {
      'title': 'The International Main Event',
      'description': 'The sixteen best Dota teams in the world spent the last week battling through an intense Group Stage, and now only eight contenders remain.',
      'image': 'assets/images/ti.png',
    },
    {
      'title': 'New Champion in TFT?',
      'description': 'A sudden chill has hit the arena! Recent teasers suggest a brand-new ice-type champion is preparing to freeze the current meta in the next update.',
      'image': 'assets/images/sanu.png',
    },
    {
      'title': 'Will Rockstar Games address the GTA 6 leaks?',
      'description': 'Fresh map and gameplay leaks have surfaced online. Will Rockstar officially address the breach, or maintain their silence?',
      'image': 'assets/images/gta6.jpg',
    },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEllipseHeader(),
                  const SizedBox(height: 10),
                  _buildGamesScroll(context),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Latest Updates', 'See all'),
                  const SizedBox(height: 10),
                  _buildLatestUpdatesScroll(context),
                  const SizedBox(height: 20),
                  _buildSectionTitle('Trending News', 'See all'),
                  const SizedBox(height: 10),
                  _buildTrendingNewsList(),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          const BottomNavBar(activeIndex: 0),
        ],
      ),
    );
  }

  Widget _buildEllipseHeader() {
    return SizedBox(
      height: 320, 
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Positioned(
            top: 40,
            child: Container(
              width: 639,
              height: 280,
              decoration: const BoxDecoration(
                color: Color(0xFFFFABAB),
                borderRadius: BorderRadius.all(Radius.elliptical(639, 280)),
              ),
            ),
          ),
          Positioned(
            top: 25,
            child: Container(
              width: 580,
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFFC64747),
                borderRadius: BorderRadius.all(Radius.elliptical(580, 260)),
              ),
            ),
          ),
          Positioned(
            top: -120, 
            child: Container(
              width: 520,
              height: 350,
              decoration: const BoxDecoration(
                color: Color(0xFF8A0303),
                borderRadius: BorderRadius.all(Radius.elliptical(520, 350)),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Hi, Ringmaster453',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Row(
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
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        )
                      ],
                    ),
                    child: TextField(
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        hintText: 'Look for Games?',
                        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 15),
                        prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGamesScroll(BuildContext context) {
    return SizedBox(
      height: 105,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return InkWell(
            onTap: () {
              if (index == 0 || game['name'].toString().trim().toUpperCase() == 'DOTA 2') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Dota2Screen()),
                );
              }
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2.5), 
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: goldGradient,
                    ),
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.black,
                      child: ClipOval(
                        child: Padding(
                          padding: EdgeInsets.all(game['fit'] == BoxFit.contain ? 6.0 : 0.0),
                          child: Image.asset(
                            game['icon']!,
                            width: 52,
                            height: 52,
                            fit: game['fit'],
                            cacheWidth: 120,
                            errorBuilder: (context, error, stackTrace) => Center(
                              child: Text(
                                game['name']!.substring(0, 2),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Stack(
                    children: [
                      Text(
                        game['name']!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2.5
                            ..color = const Color(0xFFAF8E34),
                        ),
                      ),
                      Text(
                        game['name']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, String actionText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Text(
            actionText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLatestUpdatesScroll(BuildContext context) {
    return SizedBox(
      height: 350,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: latestUpdates.length,
        itemBuilder: (context, index) {
          final item = latestUpdates[index];
          return Container(
            width: 210,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 5 / 4,
                  child: Image.asset(
                    item['image'],
                    fit: BoxFit.cover,
                    cacheWidth: 400,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.rubyDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        ...List.generate(
                          item['bullets'].length,
                          (i) => Padding(
                            padding: const EdgeInsets.only(bottom: 2.5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ', style: TextStyle(color: Colors.grey, fontSize: 11)),
                                Expanded(
                                  child: Text(
                                    item['bullets'][i],
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(color: Colors.grey, fontSize: 11),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              item['logo'],
                              width: 24,
                              height: 24,
                              cacheWidth: 50,
                              errorBuilder: (context, error, stackTrace) => const SizedBox(width: 24, height: 24),
                            ),
                            SizedBox(
                              height: 28,
                              width: 70,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (index == 0) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const Dota2741eScreen()),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.rubyDark,
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'Read',
                                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTrendingNewsList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: trendingNews.map((item) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                SizedBox(
                  width: 110,
                  height: 110,
                  child: Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                    cacheWidth: 220,
                    errorBuilder: (context, error, stackTrace) => Container(color: Colors.grey[300]),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppColors.rubyDark,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item['description']!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 11,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}