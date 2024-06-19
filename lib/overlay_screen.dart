import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class OverlayScreen extends StatefulWidget {
  const OverlayScreen({super.key});

  @override
  State<OverlayScreen> createState() => _OverlayScreenState();
}

class _OverlayScreenState extends State<OverlayScreen> {
  @override
  Widget build(BuildContext context) {
    final List<AppIcon> appIcons = [
      AppIcon(
        name: 'spotify',
        icon: FontAwesome.spotify_brand,
        iconColor: Colors.green,
      ),
      AppIcon(
        name: 'tiktok',
        icon: Icons.music_note,
        iconColor: Colors.black,
      ),
    ];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of columns
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: appIcons.length,
          itemBuilder: (context, index) {
            final appIcon = appIcons[index];
            return AppIconTile(
              appIcon: appIcon,
              iconColor: appIcon.iconColor,
            );
          },
        ),
      ),
    );
  }
}

class AppIconTile extends StatelessWidget {
  final AppIcon appIcon;
  final Color iconColor;

  const AppIconTile({
    super.key,
    required this.appIcon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, appIcon.name);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              appIcon.icon,
              size: 30,
              color: iconColor,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            appIcon.name,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AppIcon {
  final String name;
  final IconData icon;
  final Color iconColor;

  AppIcon({
    required this.name,
    required this.icon,
    required this.iconColor,
  });
}
