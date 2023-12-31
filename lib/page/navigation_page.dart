import 'package:flutter/material.dart';
import 'package:week2/api/google_auth.dart';
import 'package:week2/page/feed_add_page.dart';
import 'package:week2/page/feed_page.dart';
import 'package:week2/page/login_page.dart';
import 'package:week2/page/profile_page.dart';
import 'package:week2/page/search_page.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int currentPageIndex = 0;
  String? googleId;

  @override
  void initState() {
    super.initState();
    _loadGoogleId();
  }

  Future<void> _loadGoogleId() async {
    if (googleAuth.currentUser == null) {
      return;
    }
    setState(() {
      googleId = googleAuth.currentUser!.id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final developerDestination = NavigationDestination(
      icon: const Icon(Icons.developer_mode_outlined),
      selectedIcon: Icon(Icons.developer_mode,
          color: Theme.of(context).colorScheme.primary),
      label: '개발',
    );
    final destinations = [
      NavigationDestination(
        icon: const Icon(Icons.location_on),
        selectedIcon: Icon(Icons.location_on,
            color: Theme.of(context).colorScheme.primary),
        label: '주변',
      ),
      NavigationDestination(
          icon: const Icon(Icons.search),
          selectedIcon:
              Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
          label: '탐색'),
      NavigationDestination(
          icon: const Icon(Icons.add_box_outlined),
          selectedIcon:
              Icon(Icons.add_box, color: Theme.of(context).colorScheme.primary),
          label: '작성'),
      NavigationDestination(
        icon: const Icon(Icons.account_circle_outlined),
        selectedIcon: Icon(Icons.account_circle,
            color: Theme.of(context).colorScheme.primary),
        label: '프로필',
      ),
      developerDestination,
      developerDestination,
    ];
    final body = [
      const SearchPage(),
      FeedPage(googleId: googleId ?? ''),
      const FeedAddPage(),
      const NewProfilePage(),
      const LoginPage(),
    ];
    return Scaffold(
      bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          surfaceTintColor: Colors.white,
          indicatorColor: Theme.of(context).colorScheme.primaryContainer,
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: destinations),
      body: body[currentPageIndex],
    );
  }
}
