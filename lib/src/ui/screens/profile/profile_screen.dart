import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_bridge_assignment/src/core/constants.dart';
import 'package:omni_bridge_assignment/src/core/theme.dart';
import 'package:omni_bridge_assignment/src/ui/screens/profile/logout.dart';
import 'package:omni_bridge_assignment/src/ui/widgets/loading.dart';
import 'package:omni_bridge_assignment/src/ui/widgets/my_button.dart';
import '../../../blocs/profile/profile_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileBloc profileBloc = ProfileBloc();

  @override
  void initState() {
    profileBloc.add(GetProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        bloc: profileBloc,
        listener: (context, state) {
          if (state is ProfileErrorState) {
            Loading.showSnackBar(
                context, state.exception.message ?? "Something went wrong");
          } else if (state is LoggedOutState) {
            Navigator.pushNamed(context, "/login");
          }
        },
        builder: (context, state) {
          if (state is ProfileLoadingState || state is ProfileInitial) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Please wait!, searching for profile")
                ],
              ),
            );
          } else if (state is ProfileErrorState) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Failed to get data!"),
                  const SizedBox(
                    height: 5,
                  ),
                  MyOutlineButton(
                      buttonColor: Colors.white,
                      elevation: 0,
                      onPress: () {},
                      borderColor: ColorTheme.primaryColor,
                      borderWidth: 1,
                      child: Text(
                        "Try Again",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: ColorTheme.primaryColor),
                      ))
                ],
              ),
            );
          }
          if (state is GetProfileSuccefully) {
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Image(
                          width: 100,
                          height: 100,
                          fit: BoxFit.contain,
                          image: AssetImage(Constants.personImg)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        state.user.name!,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        state.user.email!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade300,
                ),
                ...List.generate(tabList.length, (index) {
                  return tabs(() {
                    if (index == 1) {
                      Navigator.pushNamed(context, "/add-pet", arguments: {
                        "owner_name": state.user.name,
                        "owner_contact": state.user.contact
                      });
                    }
                  }, tabList[index]["icon"], tabList[index]["title"]);
                }),
                const SizedBox(
                  height: 5,
                ),
                Divider(
                  thickness: 2,
                  color: Colors.grey.shade300,
                ),
                tabs(() {
                  Logout().logoutBox(context);
                }, Icons.logout_rounded, "Logout")
              ],
            );
          }
          return Center(
            child: MyElevatedButton(
                onPress: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )),
          );
        },
      ),
    );
  }

  Widget tabs(Function() onTap, IconData icon, String title) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black,
              size: 24,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> tabList = [
    {"icon": Icons.pets_rounded, "title": "My Pets"},
    {"icon": Icons.add_circle_rounded, "title": "Add Pet"},
    {"icon": Icons.favorite_rounded, "title": "My Favourites"}
  ];
}
