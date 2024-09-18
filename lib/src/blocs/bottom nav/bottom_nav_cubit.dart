import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(const BottomNavState(NavbarItem.home, 0));
  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.home:
        emit(const BottomNavState(NavbarItem.home, 0));
        break;
      case NavbarItem.nearbyPets:
        emit(const BottomNavState(NavbarItem.nearbyPets, 1));
        break;
      case NavbarItem.profile:
        emit(const BottomNavState(NavbarItem.profile, 2));
        break;
    }
  }
}
