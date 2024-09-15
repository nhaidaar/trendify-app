import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:trendify/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:trendify/features/notification/presentation/pages/notification_page.dart';
import 'package:trendify/features/post/presentation/pages/create_post_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/home/presentation/pages/home_page.dart';
import 'features/search/presentation/pages/search_page.dart';
import 'features/user/presentation/pages/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final homeNavKey = GlobalKey<NavigatorState>();
  final searchNavKey = GlobalKey<NavigatorState>();
  final notificationNavKey = GlobalKey<NavigatorState>();
  final profileNavKey = GlobalKey<NavigatorState>();

  int selectedTab = 0;
  List<NavModel> navigation = [];

  @override
  void initState() {
    super.initState();
    navigation = [
      NavModel(page: const HomePage(), navKey: homeNavKey),
      NavModel(page: const SearchPage(), navKey: searchNavKey),
      NavModel(page: const NotificationPage(), navKey: notificationNavKey),
      NavModel(page: const ProfilePage(), navKey: profileNavKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.of(context).pushAndRemoveUntil(
            PageTransition(
              child: const LoginPage(),
              type: PageTransitionType.fade,
            ),
            (route) => false,
          );
        }
      },
      // child: WillPopScope(
      //   onWillPop: () {
      //     if (navigation[selectedTab].navKey.currentState?.canPop() ?? false) {
      //       navigation[selectedTab].navKey.currentState?.pop();
      //       return Future.value(false);
      //     } else {
      //       return Future.value(true);
      //     }
      //   },
      child: PopScope(
        canPop: navigation[selectedTab].navKey.currentState?.canPop() ?? false,
        onPopInvoked: (didPop) {
          if (didPop) {
            navigation[selectedTab].navKey.currentState?.pop();
          }
        },
        child: Scaffold(
          body: IndexedStack(
            index: selectedTab,
            children: navigation.map((page) {
              return Navigator(
                key: page.navKey,
                onGenerateInitialRoutes: (navigator, initialRoute) {
                  return [
                    MaterialPageRoute(builder: (context) => page.page),
                  ];
                },
              );
            }).toList(),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: SizedBox(
            height: 64,
            width: 64,
            child: FloatingActionButton(
              onPressed: () {
                // context.read<AuthCubit>().logout();
                Navigator.of(context).push(
                  PageTransition(
                    child: const CreatePostPage(),
                    type: PageTransitionType.rightToLeft,
                  ),
                );
              },
              elevation: 1,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const ImageIcon(
                AssetImage('assets/icons/post.png'),
                color: Colors.white,
              ),
            ),
          ),
          bottomNavigationBar: NavBar(
            page: selectedTab,
            onTap: (index) {
              if (index == selectedTab) {
                navigation[index].navKey.currentState?.popUntil((route) => route.isFirst);
              } else {
                setState(() => selectedTab = index);
              }
            },
          ),
        ),
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final int page;
  final Function(int) onTap;
  const NavBar({
    super.key,
    required this.page,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      height: 70,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          NavItem(
            icon: 'assets/icons/home.png',
            activeIcon: 'assets/icons/home_active.png',
            selected: page == 0,
            onTap: () => onTap(0),
          ),
          NavItem(
            icon: 'assets/icons/search.png',
            activeIcon: 'assets/icons/search_active.png',
            selected: page == 1,
            onTap: () => onTap(1),
          ),
          const SizedBox(width: 64),
          NavItem(
            icon: 'assets/icons/like.png',
            activeIcon: 'assets/icons/like_active.png',
            selected: page == 2,
            onTap: () => onTap(2),
          ),
          NavItem(
            icon: 'assets/icons/profile.png',
            activeIcon: 'assets/icons/profile_active.png',
            selected: page == 3,
            onTap: () => onTap(3),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final String icon;
  final String activeIcon;
  final bool selected;
  final Function()? onTap;
  const NavItem({
    super.key,
    required this.icon,
    required this.activeIcon,
    required this.selected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: ImageIcon(
          AssetImage(selected ? activeIcon : icon),
          color: selected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        ),
      ),
    );
  }
}

class NavModel {
  final Widget page;
  final GlobalKey<NavigatorState> navKey;

  NavModel({required this.page, required this.navKey});
}
