import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/bottom nav/bottom_nav_cubit.dart';
import '../../../core/error handler/app_exception.dart';
import '../../../repositories/authentication_repo.dart';
import '../../widgets/loading.dart';
import '../../widgets/my_button.dart';

class Logout {
  Future logoutBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          backgroundColor: Colors.white,
          alignment: Alignment.center,
          title: const Text(
            'Are you sure you want to log out?',
          ),
          titleTextStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          actions: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: MyElevatedButton(
                        elevation: 0,
                        onPress: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: MyOutlineButton(
                        buttonColor: Colors.white,
                        elevation: 0,
                        onPress: () async {
                          try {
                            Loading.showLoading(context);
                            final logout = await AuthenticationRepo().logout();
                            if (logout) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                BlocProvider.of<BottomNavCubit>(context)
                                    .getNavBarItem(NavbarItem.home);
                                Navigator.pushNamedAndRemoveUntil(context,
                                    "/home", (Route<dynamic> route) => false);
                              });
                            }
                          } on AppException catch (e) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Loading.showSnackBar(
                                  context, e.message ?? "Something went wrong");
                            });
                          } catch (e) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Loading.showSnackBar(context, "Logout failed");
                            });
                          }
                        },
                        borderColor: Colors.grey.shade400,
                        borderWidth: 1,
                        child: Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.grey.shade400,
                              fontWeight: FontWeight.w500),
                        )),
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
