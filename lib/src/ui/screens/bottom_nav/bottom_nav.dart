import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_bridge_assignment/src/core/theme.dart';

import '../../../blocs/bottom nav/bottom_nav_cubit.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({super.key});

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        if (state.navbarItem == NavbarItem.home) {
          return const HomeScreen();
        } else if (state.navbarItem == NavbarItem.nearbyPets) {
          return const Center(
            child: Text("Nearby Pets"),
          );
        } else if (state.navbarItem == NavbarItem.profile) {
          return const ProfileScreen();
        }
        return Container();
      },
    ), bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNavState>(
      builder: (context, state) {
        return Theme(
          data: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedIconTheme:
                IconThemeData(size: 23, color: ColorTheme.primaryColor),
            unselectedIconTheme:
                IconThemeData(size: 20, color: Colors.grey.shade500),
            elevation: 3,
            backgroundColor: Colors.white,
            currentIndex: state.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.near_me_outlined),
                activeIcon: Icon(Icons.near_me),
                label: 'Nearby Pets',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_outlined),
                activeIcon: Icon(Icons.account_circle_rounded),
                label: 'Profile',
              ),
            ],
            onTap: (index) {
              if (index == 0) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.home);
              } else if (index == 1) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.nearbyPets);
              } else if (index == 2) {
                BlocProvider.of<BottomNavCubit>(context)
                    .getNavBarItem(NavbarItem.profile);
              }
            },
          ),
        );
      },
    ));
  }
}
