import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omni_bridge_assignment/src/core/constants.dart';
import 'package:omni_bridge_assignment/src/core/theme.dart';
import 'package:omni_bridge_assignment/src/ui/screens/home/pet_container.dart';

import '../../../blocs/get_pets/get_pets_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectCategory = 0;
  final scrollController = ScrollController();

  final GetPetsBloc getPetsBloc = GetPetsBloc();

  @override
  void initState() {
    getPetsBloc.add(GetPets(
        category: selectCategory == 0
            ? "All"
            : Constants.petsCategories[selectCategory - 1]));
            scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(onScroll)
      ..dispose();
    getPetsBloc.close();
    super.dispose();
  }

  void onScroll() {
    if (isBottom) {
      getPetsBloc.add(GetPets(
          loadmore: true,
          category: selectCategory == 0
              ? "All"
              : Constants.petsCategories[selectCategory - 1]));
    }
  }

  bool get isBottom {
    if (!scrollController.hasClients) {
      log("here");
      return false;
    } else {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.offset;
      log("${currentScroll == maxScroll}");
      return currentScroll >= (maxScroll * 0.9);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 2,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Home",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              "Maharashtra, Shevgaon, Pathan Road",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: ColorTheme.primaryColor),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            Text(
              "Categories",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(Constants.petsCategories.length + 1,
                      (index) {
                    return InkWell(
                      onTap: () => setState(() {
                        selectCategory = index;
                        getPetsBloc.add(GetPets(
                            category: selectCategory == 0
                                ? "All"
                                : Constants
                                    .petsCategories[selectCategory - 1]));
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        constraints: const BoxConstraints(minWidth: 70),
                        margin: EdgeInsets.only(
                            left: index == 0 ? 0 : 5,
                            right: index == Constants.petsCategories.length + 1
                                ? 0
                                : 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: selectCategory == index
                                ? ColorTheme.primaryColor
                                : Colors.grey.shade200),
                        child: Text(
                          index == 0
                              ? "All"
                              : Constants.petsCategories[index - 1],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: selectCategory == index
                                      ? Colors.white
                                      : Colors.black),
                        ),
                      ),
                    );
                  })
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Resuls",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontSize: 18),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<GetPetsBloc, GetPetsState>(
                bloc: getPetsBloc,
                builder: (context, state) {
                  if (state is GetPetsInitial) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is ErrorOccuredPets) {
                    return Center(
                      child: Text(
                        state.exception.message ?? "Something went wrong",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    );
                  }
                  if (state is PetsLoaded && state.pets.isEmpty) {
                    return const Center(
                      child: Text(
                        "No More Pets To Show",
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    );
                  }
                  if (state is PetsLoaded && state.pets.isNotEmpty) {
                    return SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            runSpacing: 20,
                            spacing: 20,
                            runAlignment: WrapAlignment.center,
                            children: List.generate(state.pets.length, (index) {
                              return PetContainer(
                                pet: state.pets[index],
                              );
                            }),
                          ),
                          state.loadMore == true
                              ? Container(
                                  margin: const EdgeInsets.only(top: 15),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                          height: 20,
                                          width: 20,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1,
                                          )),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Loading more")
                                    ],
                                  ),
                                )
                              : const SizedBox()
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
