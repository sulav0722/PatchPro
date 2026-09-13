import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';

class Dota2741eHeroUpdatesScreen extends StatefulWidget {
  const Dota2741eHeroUpdatesScreen({super.key});

  @override
  State<Dota2741eHeroUpdatesScreen> createState() => _Dota2741eHeroUpdatesScreenState();
}

class _Dota2741eHeroUpdatesScreenState extends State<Dota2741eHeroUpdatesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> allHeroes = [
    {
      'heroName': 'ANCIENT APPARITION',
      'heroIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/ancient_apparition.png',
      'attributeIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_intelligence.png',
      'abilities': [
        {
          'name': 'ICE BLAST',
          'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/ancient_apparition_ice_blast.png',
          'changes': ['Cooldown decreased from 60/50/40s to 50/45/40s']
        }
      ],
    },
    {
      'heroName': 'AXE',
      'heroIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/axe.png',
      'attributeIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_strength.png',
      'statChanges': ['Base Agility decreased from 20 to 18'],
      'abilities': [
        {
          'name': 'Battle Hunger',
          'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/axe_battle_hunger.png',
          'changes': ['Damage per second decreased from 12/18/24/30 to 12/16/20/24']
        }
      ],
    },
    {
      'heroName': 'BANE',
      'heroIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/bane.png',
      'attributeIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_universal.png',
      'abilities': [
        {
          'name': 'Ichor of Nyctasha',
          'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/bane_ichor_of_nyctasha.png',
          'isInnate': true,
          'changes': [
            'Max Terrors per hero increased from 5 to 6',
            'Status Resistance per Terror decreased from 5% to 4%'
          ]
        },
        {
          'name': 'Nightmare',
          'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/bane_nightmare.png',
          'changes': [
            'Duration decreased from 3.5/4.5/5.5/6.5s to 3/4/5/6s',
            'Now completely disables the target\'s sight, instead of overriding the vision range value'
          ]
        },
        {
          'name': 'Fiend\'s Grip',
          'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/abilities/bane_fiends_grip.png',
          'changes': [
            'Aghanim\'s Scepter cooldown reduction decreased from 45s to 40s'
          ]
        }
      ],
    },
    {
      'heroName': 'BATRIDER',
      'heroIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/batrider.png',
      'attributeIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_universal.png',
      'abilities': [
        {
          'name': 'Smoldering Resin',
          'icon': 'https://cdn.steamstatic.com/apps/dota2/images/dota_react/icons/innate_icon.png',
          'isPureInnateIcon': true,
          'changes': ['No longer applies when attacking allies']
        }
      ],
    },
    {
      'heroName': 'BEASTMASTER',
      'heroIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/beastmaster.png',
      'attributeIconUrl': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/icons/hero_universal.png',
      'isTalents': true,
      'abilities': [
        {
          'name': '',
          'isAssetTalentIcon': true,
          'changes': [
            'Level 20 Talent Damage to Beastmaster and his summons decreased from +30 to +25',
            'Level 25 Talent Primal Roar Cooldown Reduction decreased from 25s to 20s'
          ]
        }
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase().trim();
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Sort heroes by prefix matching (starts with query takes top priority)
    final sortedHeroes = List<Map<String, dynamic>>.from(allHeroes);
    if (_searchQuery.isNotEmpty) {
      sortedHeroes.sort((a, b) {
        final aName = a['heroName'].toString().toLowerCase();
        final bName = b['heroName'].toString().toLowerCase();

        final aStarts = aName.startsWith(_searchQuery);
        final bStarts = bName.startsWith(_searchQuery);

        final aContains = aName.contains(_searchQuery);
        final bContains = bName.contains(_searchQuery);

        if (aStarts && !bStarts) return -1;
        if (!aStarts && bStarts) return 1;
        if (aContains && !bContains) return -1;
        if (!aContains && bContains) return 1;
        return aName.compareTo(bName);
      });
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Container(
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top App Bar (Back Button, Notification, Profile)
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 22),
                        ),
                        const Spacer(),
                        const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: const NetworkImage('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/crystal_maiden.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Main Container constrained perfectly above the bottom navigation bar
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 95.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.65),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Capsule Header Container matching prototype reference
                              Container(
                                width: double.infinity,
                                margin: const EdgeInsets.all(12.0),
                                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: AppColors.rubyDark,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: const Text(
                                  'Hero Changes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                              ),

                              // Search Bar with "Search hero" placeholder
                              Padding(
                                padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
                                child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.08),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
                                  ),
                                  child: TextField(
                                    controller: _searchController,
                                    style: const TextStyle(color: Colors.white, fontSize: 13),
                                    decoration: InputDecoration(
                                      hintText: 'Search hero',
                                      hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
                                      prefixIcon: Icon(Icons.search, color: Colors.white.withValues(alpha: 0.4), size: 18),
                                      suffixIcon: _searchQuery.isNotEmpty
                                          ? GestureDetector(
                                              onTap: () => _searchController.clear(),
                                              child: Icon(Icons.clear, color: Colors.white.withValues(alpha: 0.5), size: 16),
                                            )
                                          : null,
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                                    ),
                                  ),
                                ),
                              ),

                              // Scrollable Detailed Hero List with hero-name-only sorting
                              Expanded(
                                child: ListView.separated(
                                  controller: _scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.all(16),
                                  itemCount: sortedHeroes.length,
                                  separatorBuilder: (context, index) => const Divider(color: Colors.white24, height: 32),
                                  itemBuilder: (context, index) {
                                    final hero = sortedHeroes[index];
                                    return _buildHeroSection(
                                      heroName: hero['heroName'],
                                      heroIconUrl: hero['heroIconUrl'],
                                      attributeIconUrl: hero['attributeIconUrl'],
                                      statChanges: hero['statChanges'],
                                      isTalents: hero['isTalents'] ?? false,
                                      abilities: hero['abilities'],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const BottomNavBar(activeIndex: 1),
        ],
      ),
    );
  }

  Widget _buildHeroSection({
    required String heroName,
    required String heroIconUrl,
    required String attributeIconUrl,
    List<String>? statChanges,
    bool isTalents = false,
    required List<Map<String, dynamic>> abilities,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 52,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(heroIconUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 18,
              height: 18,
              child: Image.network(
                attributeIconUrl,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.circle,
                  size: 14,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                heroName,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  letterSpacing: 0.6,
                ),
              ),
            ),
          ],
        ),
        if (statChanges != null && statChanges.isNotEmpty) ...[
          const SizedBox(height: 10),
          ...statChanges.map((change) => Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 4),
                child: Row(
                  children: [
                    const Text('• ', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                    Expanded(
                      child: Text(
                        change,
                        style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12),
                      ),
                    ),
                  ],
                ),
              )),
        ],
        const SizedBox(height: 12),
        Text(
          isTalents ? 'TALENTS' : 'ABILITIES',
          style: const TextStyle(
            color: Colors.white60,
            fontSize: 11,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        ...abilities.map((ability) => Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: ability['isAssetTalentIcon'] == true
                              ? Container(
                                  color: Colors.grey[900],
                                  child: Image.asset(
                                    'assets/images/talenttree.png',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.yard, color: Colors.greenAccent, size: 20),
                                  ),
                                )
                              : ability['isPureInnateIcon'] == true
                                  ? Container(
                                      color: Colors.grey[900],
                                      padding: const EdgeInsets.all(4),
                                      child: Image.network(
                                        ability['icon'] ?? '',
                                        fit: BoxFit.contain,
                                        errorBuilder: (context, error, stackTrace) =>
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                      ),
                                    )
                                  : Image.network(
                                      ability['icon'] ?? '',
                                      width: 32,
                                      height: 32,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        width: 32,
                                        height: 32,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                        ),
                        if (ability['isInnate'] == true)
                          Positioned(
                            bottom: -4,
                            right: -4,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xFF1E2229),
                              ),
                              child: Center(
                                child: Image.network(
                                  'https://cdn.steamstatic.com/apps/dota2/images/dota_react/icons/innate_icon.png',
                                  width: 10,
                                  height: 10,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.star, size: 8, color: Colors.amber),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (ability['name'] != null && ability['name'].toString().isNotEmpty) ...[
                          Text(
                            ability['name'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        ...(ability['changes'] as List<String>).map((change) => Padding(
                              padding: const EdgeInsets.only(bottom: 2),
                              child: Text(
                                '• $change',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.7),
                                  fontSize: 12,
                                  height: 1.3,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}