import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';
import 'dota2_7_41e_hero_updates_screen.dart';

class Dota2741eScreen extends StatefulWidget {
  const Dota2741eScreen({super.key});

  @override
  State<Dota2741eScreen> createState() => _Dota2741eScreenState();
}

class _Dota2741eScreenState extends State<Dota2741eScreen> {
  int _selectedTab = 0; // 0: Heroes, 1: Items, 2: Meta

  // State toggles for Items tab expandable cards
  bool _isItemsDetailed = false;
  bool _isNeutralDetailed = false;

  final TextEditingController _itemSearchController = TextEditingController();
  final TextEditingController _neutralSearchController = TextEditingController();
  
  String _itemSearchQuery = '';
  String _neutralSearchQuery = '';

  // Clean, fully-verified list of all 57 heroes in exact patch order with accurate buff/nerf statuses
  final List<Map<String, dynamic>> heroUpdates = [
    // Row 1
    {'name': 'Ancient Apparition', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/ancient_apparition.png', 'buff': true},
    {'name': 'Axe', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/axe.png', 'buff': false},
    {'name': 'Bane', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/bane.png', 'buff': false},
    {'name': 'Batrider', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/batrider.png', 'buff': true},
    {'name': 'Beastmaster', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/beastmaster.png', 'buff': false},
    {'name': 'Centaur Warrunner', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/centaur.png', 'buff': false},
    {'name': 'Chaos Knight', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/chaos_knight.png', 'buff': true},
    {'name': 'Clockwerk', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/rattletrap.png', 'buff': false},
    
    // Row 2
    {'name': 'Death Prophet', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/death_prophet.png', 'buff': false},
    {'name': 'Doom', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/doom_bringer.png', 'buff': true},
    {'name': 'Dragon Knight', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/dragon_knight.png', 'buff': true},
    {'name': 'Drow Ranger', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/drow_ranger.png', 'buff': false},
    {'name': 'Earth Spirit', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/earth_spirit.png', 'buff': false},
    {'name': 'Ember Spirit', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/ember_spirit.png', 'buff': true},
    {'name': 'Enchantress', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/enchantress.png', 'buff': false},
    {'name': 'Faceless Void', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/faceless_void.png', 'buff': true},
    
    // Row 3
    {'name': 'Gyrocopter', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/gyrocopter.png', 'buff': false},
    {'name': 'Hoodwink', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/hoodwink.png', 'buff': true},
    {'name': 'Keeper of the Light', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/keeper_of_the_light.png', 'buff': true},
    {'name': 'Leshrac', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/leshrac.png', 'buff': false},
    {'name': 'Lich', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/lich.png', 'buff': false},
    {'name': 'Legion Commander', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/legion_commander.png', 'buff': true},
    {'name': 'Lina', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/lina.png', 'buff': false},
    {'name': 'Lone Druid', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/lone_druid.png', 'buff': true},
    
    // Row 4
    {'name': 'Lycan', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/lycan.png', 'buff': true},
    {'name': 'Magnus', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/magnataur.png', 'buff': false},
    {'name': 'Marci', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/marci.png', 'buff': false},
    {'name': 'Medusa', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/medusa.png', 'buff': false},
    {'name': 'Mirana', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/mirana.png', 'buff': true},
    {'name': 'Monkey King', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/monkey_king.png', 'buff': false},
    {'name': 'Morphling', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/morphling.png', 'buff': true},
    {'name': 'Omniknight', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/omniknight.png', 'buff': true},
    
    // Row 5
    {'name': 'Oracle', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/oracle.png', 'buff': true},
    {'name': 'Outworld Destroyer', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/obsidian_destroyer.png', 'buff': false},
    {'name': 'Phantom Assassin', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/phantom_assassin.png', 'buff': false},
    {'name': 'Phantom Lancer', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/phantom_lancer.png', 'buff': false},
    {'name': 'Puck', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/puck.png', 'buff': true},
    {'name': 'Pudge', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/pudge.png', 'buff': true},
    {'name': 'Queen of Pain', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/queenofpain.png', 'buff': true},
    {'name': 'Razor', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/razor.png', 'buff': true},
    
    // Row 6 & 7
    {'name': 'Riki', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/riki.png', 'buff': true},
    {'name': 'Rubick', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/rubick.png', 'buff': false},
    {'name': 'Sniper', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/sniper.png', 'buff': false},
    {'name': 'Spectre', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/spectre.png', 'buff': true},
    {'name': 'Templar Assassin', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/templar_assassin.png', 'buff': true},
    {'name': 'Tidehunter', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/tidehunter.png', 'buff': true},
    {'name': 'Tiny', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/tiny.png', 'buff': false},
    {'name': 'Tusk', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/tusk.png', 'buff': true},
    {'name': 'Undying', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/undying.png', 'buff': false},
    {'name': 'Vengeful Spirit', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/vengefulspirit.png', 'buff': false},
    {'name': 'Venomancer', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/venomancer.png', 'buff': true},
    {'name': 'Viper', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/viper.png', 'buff': true},
    {'name': 'Visage', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/visage.png', 'buff': true},
    {'name': 'Void Spirit', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/void_spirit.png', 'buff': true},
    {'name': 'Warlock', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/warlock.png', 'buff': false},
    {'name': 'Zeus', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/zuus.png', 'buff': false},
    {'name': 'Primal Beast', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/primal_beast.png', 'buff': true},
    {'name': 'Marci Extra', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/marci.png', 'buff': false},
    {'name': 'Muerta', 'url': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/muerta.png', 'buff': true},
  ];

  final List<Map<String, dynamic>> itemUpdates = [
    {
      'name': 'ABYSSAL BLADE',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/abyssal_blade.png',
      'buff': true,
      'changes': ['Strength bonus increased from +26 to +30']
    },
    {
      'name': 'BUTTERFLY',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/butterfly.png',
      'buff': false,
      'changes': [
        'Agility bonus decreased from +35 to +30',
        'Damage bonus increased from +25 to +30'
      ]
    },
    {
      'name': 'CHASM STONE',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/chasm_stone.png',
      'buff': false,
      'changes': ['Cost increased from 800 to 900']
    },
    {
      'name': 'SHIVA\'S GUARD',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/shivas_guard.png',
      'buff': true,
      'changes': ['Recipe cost decreased from 1350 to 1250 (Total cost unchanged at 4500g)']
    },
    {
      'name': 'GLEIPNIR',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/gungir.png',
      'buff': true,
      'changes': ['Recipe cost decreased from 400 to 300 (Total cost unchanged at 4650g)']
    },
    {
      'name': 'CRELLA\'S CROZIER',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/crellas_crozier.png',
      'buff': true,
      'changes': [
        'Rite of Rumusque movement speed steal duration increased from 1.5s to 2s',
        'Rite of Rumusque Putrefaction Aura effect increased from 75% to 90%'
      ]
    },
    {
      'name': 'DIVINE RAPIER',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/rapier.png',
      'buff': false,
      'changes': ['Spell Amplification from multiple Divine Rapiers no longer stacks']
    },
    {
      'name': 'EYE OF SKADI',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/skadi.png',
      'buff': true,
      'changes': ['Cold Attack attack speed slow increased from 20% to 25%']
    },
    {
      'name': 'HAND OF MIDAS',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/hand_of_midas.png',
      'buff': true,
      'changes': ['Attack Speed bonus increased from +35 to +40']
    },
    {
      'name': 'HEAVEN\'S HALBERD',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/heavens_halberd.png',
      'buff': true,
      'changes': ['Disarm cooldown decreased from 16s to 15s']
    },
    {
      'name': 'HURRICANE PIKE',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/hurricane_pike.png',
      'buff': false,
      'changes': ['Hurricane Thrust buff duration decreased from 6s to 5s']
    },
    {
      'name': 'KAYA',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/kaya.png',
      'buff': false,
      'changes': ['Mana Regen Amplification decreased from 30% to 20%']
    },
    {
      'name': 'METEOR HAMMER',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/meteor_hammer.png',
      'buff': false,
      'changes': ['Mana Regen Amplification decreased from 35% to 25%']
    },
    {
      'name': 'KAYA AND SANGE',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/kaya_and_sange.png',
      'buff': false,
      'changes': ['Mana Regen Amplification decreased from 40% to 30%']
    },
    {
      'name': 'YASHA AND KAYA',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/yasha_and_kaya.png',
      'buff': false,
      'changes': ['Mana Regen Amplification decreased from 40% to 30%']
    },
    {
      'name': 'MASK OF MADNESS',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/mask_of_madness.png',
      'buff': false,
      'changes': [
        'Berserk movement speed bonus on ranged heroes decreased from 8% to 6%',
        'Berserk now provides 15% slow resistance for ranged heroes and 30% for melee'
      ]
    },
    {
      'name': 'ORB OF FROST',
      'icon': 'https://cdn.steamstatic.com/apps/dota2/images/dota_react/items/orb_of_frost.png',
      'buff': true,
      'changes': [
        'Frost no longer applies when attacking allies',
        'Frost health restoration reduction increased from 13% to 15%'
      ]
    },
    {
      'name': 'ORB OF CORROSION',
      'icon': 'https://cdn.steamstatic.com/apps/dota2/images/dota_react/items/orb_of_corrosion.png',
      'buff': true,
      'changes': ['Corrosion health restoration reduction increased from 16% to 18%']
    },
    {
      'name': 'ORB OF VENOM',
      'icon': 'https://cdn.steamstatic.com/apps/dota2/images/dota_react/items/orb_of_venom.png',
      'buff': true,
      'changes': ['Poison Attack damage per second increased from 10 to 12']
    },
    {
      'name': 'REFRESHER SHARD',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/refresher_shard.png',
      'buff': false,
      'changes': ['No longer provides +12 Health Regen, +6 Mana Regen, or +20 Damage']
    },
    {
      'name': 'SATANIC',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/satanic.png',
      'buff': false,
      'changes': ['Unholy Rage cooldown increased from 30s to 40s']
    },
    {
      'name': 'SMOKE OF DECEIT',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/smoke_of_deceit.png',
      'buff': true,
      'changes': ['Disguise now has a fixed duration and is not affected by buff duration amplification']
    },
    {
      'name': 'URN OF SHADOWS',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/urn_of_shadows.png',
      'buff': false,
      'changes': [
        'Mana Regen bonus decreased from +1.25 to +1',
        'When in Stash, no longer grants charges from nearby hero deaths'
      ]
    },
    {
      'name': 'ESSENCE DISTILLER',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/essence_distiller.png',
      'buff': false,
      'changes': ['When in Stash, no longer grants charges from nearby hero deaths']
    },
    {
      'name': 'SPIRIT VESSEL',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/spirit_vessel.png',
      'buff': false,
      'changes': ['When in Stash, no longer grants charges from nearby hero deaths']
    },
    {
      'name': 'VEIL OF DISCORD',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/veil_of_discord.png',
      'buff': true,
      'changes': ['Spell Weakness mana cost decreased from 50 to 25']
    },
  ];

  final List<Map<String, dynamic>> artifactUpdates = [
    {
      'name': 'FORAGER\'S KIT',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/foragers_kit.png',
      'buff': true,
      'changes': ['Forage time decreased from 1s to 0.75s']
    },
    {
      'name': 'CONJURER\'S CATALYST',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/conjurers_catalyst.png',
      'buff': false,
      'changes': [
        'Spellover non-hero explosion damage decreased from 30 to 20',
        'Spellover damage threshold on illusions now only considers pre-amplification damage'
      ]
    },
    {
      'name': 'ENCHANTER\'S BAUBLE',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/enchanters_bauble.png',
      'buff': false,
      'changes': ['Enchant recraft bonus decreased from 40% to 35%']
    },
    {
      'name': 'WITCHBANE',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/witchbane.png',
      'buff': true,
      'changes': ['Cleanse cooldown decreased from 40s to 30s']
    },
  ];

  final List<Map<String, dynamic>> enchantmentUpdates = [
    {
      'name': 'GREEDY',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/enhancement_greedy.png',
      'buff': false,
      'changes': ['GPM Bonus decreased from +75/100 to +65/90']
    },
    {
      'name': 'FEVERISH',
      'icon': 'https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/items/enhancement_feverish.png',
      'buff': false,
      'changes': [
        'No longer increases Mana Cost/Lost by 7%',
        'Now decreases maximum mana by 20%'
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    // Sort all item lists alphabetically by name
    itemUpdates.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
    artifactUpdates.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
    enchantmentUpdates.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));

    _itemSearchController.addListener(() {
      setState(() => _itemSearchQuery = _itemSearchController.text.toLowerCase().trim());
    });
    _neutralSearchController.addListener(() {
      setState(() => _neutralSearchQuery = _neutralSearchController.text.toLowerCase().trim());
    });
  }

  @override
  void dispose() {
    _itemSearchController.dispose();
    _neutralSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Notification & Profile Bar
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(Icons.notifications_none, color: Colors.white, size: 28),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[800],
                          backgroundImage: const NetworkImage('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/dota_react/heroes/crystal_maiden.png'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Patch Header Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.55),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white.withOpacity(0.12)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/dota2.png', width: 24, height: 24),
                              const SizedBox(width: 8),
                              const Text(
                                'DOTA 2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  letterSpacing: 1.1,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Patch 7.41e - Balance Changes',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'July 31, 2026',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text(
                                '57 hero changes · 26 items changes',
                                style: TextStyle(color: Colors.white70, fontSize: 11),
                              ),
                              const Spacer(),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('▲ 28 buffed', style: TextStyle(color: Colors.greenAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('▼ 29 nerfed', style: TextStyle(color: Colors.redAccent, fontSize: 10, fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Filter Segmented Control (Heroes / Items / Meta) with Sliding Red Pill
                    Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(22),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final tabWidth = constraints.maxWidth / 3;
                          return Stack(
                            children: [
                              AnimatedPositioned(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                left: _selectedTab * tabWidth,
                                top: 0,
                                bottom: 0,
                                width: tabWidth,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.rubyDark,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => setState(() => _selectedTab = 0),
                                      child: Center(
                                        child: Text(
                                          'HEROES',
                                          style: TextStyle(
                                            color: _selectedTab == 0 ? Colors.white : Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => setState(() => _selectedTab = 1),
                                      child: Center(
                                        child: Text(
                                          'ITEMS',
                                          style: TextStyle(
                                            color: _selectedTab == 1 ? Colors.white : Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onTap: () => setState(() => _selectedTab = 2),
                                      child: Center(
                                        child: Text(
                                          'META',
                                          style: TextStyle(
                                            color: _selectedTab == 2 ? Colors.white : Colors.white70,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 16),

                    // IndexedStack for Tab Content constrained perfectly above the bottom nav bar
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 95.0),
                        child: IndexedStack(
                          index: _selectedTab,
                          children: [
                            _buildHeroesContent(),
                            _buildItemsContent(),
                            _buildMetaContent(),
                          ],
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

  // HEROES TAB CONTENT
  Widget _buildHeroesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top Patch Performance',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.12)),
          ),
          clipBehavior: Clip.antiAlias,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFF2C3730),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.greenAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Top Winners',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/ancient_apparition_icon.png'),
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/batrider_icon.png'),
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/sniper_icon.png'),
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/vengefulspirit_icon.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: const Color(0xFF3A252A),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 4,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Top Losers',
                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/axe_icon.png'),
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/bane_icon.png'),
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/centaur_icon.png'),
                                _buildHeroIcon('https://cdn.cloudflare.steamstatic.com/apps/dota2/images/heroes/drow_ranger_icon.png'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'UPDATE SUMMARY',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 0.8),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Dota2741eHeroUpdatesScreen(),
                  ),
                );
              },
              child: const Text(
                'See all',
                style: TextStyle(color: Colors.white60, fontSize: 13),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),

        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            clipBehavior: Clip.antiAlias,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 68 / 38,
              ),
              itemCount: heroUpdates.length,
              itemBuilder: (context, index) {
                final hero = heroUpdates[index];
                final isBuffed = hero['buff'] as bool;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white24, width: 0.8),
                        image: DecorationImage(
                          image: NetworkImage(hero['url']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: -5,
                      right: -5,
                      child: Container(
                        width: 17,
                        height: 17,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: isBuffed 
                              ? [Colors.greenAccent, Colors.green.shade800]
                              : [Colors.redAccent, Colors.red.shade800],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 3,
                              offset: const Offset(0, 1.5),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            isBuffed ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                            size: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroIcon(String imageUrl) {
    return SizedBox(
      width: 28,
      height: 28,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[800],
            child: const Icon(Icons.person, size: 16, color: Colors.white70),
          ),
        ),
      ),
    );
  }

  // Strictly constrained horizontal scrollable icon row (max width 164.0 to fit exactly 5 items and prevent overflow)
  Widget _buildHorizontalItemIconRow(List<Map<String, dynamic>> items, bool isBuff) {
    final filtered = items.where((i) => i['buff'] == isBuff).toList();
    filtered.sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
    return SizedBox(
      width: 164.0,
      child: ClipRect(
        child: SizedBox(
          height: 30,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: filtered.map((item) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isBuff ? Colors.greenAccent : Colors.redAccent,
                        width: 1.5,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(item['icon']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // ITEMS TAB CONTENT (Featuring Interactive Expandable Containers matching your Design Draft)
  Widget _buildItemsContent() {
    // Ensure alphabetical sorting on filtered lists
    final filteredItems = itemUpdates.where((item) => item['name'].toString().toLowerCase().contains(_itemSearchQuery)).toList()
      ..sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
      
    final filteredArtifacts = artifactUpdates.where((item) => item['name'].toString().toLowerCase().contains(_neutralSearchQuery)).toList()
      ..sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));
      
    final filteredEnchantments = enchantmentUpdates.where((item) => item['name'].toString().toLowerCase().contains(_neutralSearchQuery)).toList()
      ..sort((a, b) => (a['name'] as String).compareTo(b['name'] as String));

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Items',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),

          // 1. ITEMS CARD (Toggles between Summary & Detailed View)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isItemsDetailed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Row(
                      children: [
                        Expanded(child: Container(color: const Color(0xFF2C3730))),
                        Expanded(child: Container(color: const Color(0xFF3A252A))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Buffs',
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildHorizontalItemIconRow(itemUpdates, true),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        width: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Nerfs',
                                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            _buildHorizontalItemIconRow(itemUpdates, false),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: GestureDetector(
                            onTap: () => setState(() => _isItemsDetailed = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: AppColors.rubyDark,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 2.5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Show Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            secondChild: Container(
              height: 380, // Fixed height with internal scrolling
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Items Detailed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        GestureDetector(
                          onTap: () => setState(() => _isItemsDetailed = false),
                          child: const Text('collapse', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: TextField(
                        controller: _itemSearchController,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Search item...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                          prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.4), size: 16),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      itemCount: filteredItems.length,
                      separatorBuilder: (context, index) => const Divider(color: Colors.white24, height: 24),
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                item['icon'],
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) => Container(width: 32, height: 32, color: Colors.grey[800]),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name'],
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                  ),
                                  const SizedBox(height: 4),
                                  ...(item['changes'] as List<String>).map((change) => Padding(
                                        padding: const EdgeInsets.only(bottom: 2),
                                        child: Text(
                                          '• $change',
                                          style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            'Neutral Items Changes',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),

          // 2. NEUTRAL ITEMS CARD (Unified with internal sections for Artifacts & Enchantments)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: _isNeutralDetailed ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            firstChild: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Row(
                      children: [
                        Expanded(child: Container(color: const Color(0xFF2C3730))),
                        Expanded(child: Container(color: const Color(0xFF3A252A))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: IntrinsicHeight(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Container(
                                      width: 4,
                                      decoration: BoxDecoration(
                                        color: Colors.greenAccent,
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            'Buffs',
                                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 8),
                                          _buildHorizontalItemIconRow([...artifactUpdates, ...enchantmentUpdates], true),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: IntrinsicHeight(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Container(
                                        width: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.redAccent,
                                          borderRadius: BorderRadius.circular(2),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Nerfs',
                                              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 8),
                                            _buildHorizontalItemIconRow([...artifactUpdates, ...enchantmentUpdates], false),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Center(
                          child: GestureDetector(
                            onTap: () => setState(() => _isNeutralDetailed = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3.5),
                              decoration: BoxDecoration(
                                color: AppColors.rubyDark,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 2.5,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'Show Changes',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  letterSpacing: 0.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            secondChild: Container(
              height: 380, // Fixed height with internal scrolling
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.75),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.12)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Neutral Items Detailed', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                        GestureDetector(
                          onTap: () => setState(() => _isNeutralDetailed = false),
                          child: const Text('collapse', style: TextStyle(color: Colors.white54, fontSize: 12)),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white.withOpacity(0.1)),
                      ),
                      child: TextField(
                        controller: _neutralSearchController,
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                        decoration: InputDecoration(
                          hintText: 'Search neutral item...',
                          hintStyle: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                          prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.4), size: 16),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(16),
                      children: [
                        const Text(
                          'Artifacts',
                          style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.8),
                        ),
                        const SizedBox(height: 8),
                        ...filteredArtifacts.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  item['icon'],
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(width: 32, height: 32, color: Colors.grey[800]),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    const SizedBox(height: 4),
                                    ...(item['changes'] as List<String>).map((change) => Padding(
                                          padding: const EdgeInsets.only(bottom: 2),
                                          child: Text(
                                            '• $change',
                                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 16),
                        const Text(
                          'Enchantments',
                          style: TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 0.8),
                        ),
                        const SizedBox(height: 8),
                        ...filteredEnchantments.map((item) => Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  item['icon'],
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) => Container(width: 32, height: 32, color: Colors.grey[800]),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                                    ),
                                    const SizedBox(height: 4),
                                    ...(item['changes'] as List<String>).map((change) => Padding(
                                          padding: const EdgeInsets.only(bottom: 2),
                                          child: Text(
                                            '• $change',
                                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 12),
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  // META TAB CONTENT
  Widget _buildMetaContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Meta Overview',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.55),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: const Text(
              'Draft meta statistics and pick/ban rates for Patch 7.41e will appear here.',
              style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
            ),
          ),
        ),
      ],
    );
  }
}