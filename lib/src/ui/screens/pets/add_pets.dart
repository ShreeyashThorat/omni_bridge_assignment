import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:omni_bridge_assignment/src/core/constants.dart';
import 'package:omni_bridge_assignment/src/models/pets_model.dart';
import 'package:omni_bridge_assignment/src/ui/widgets/loading.dart';
import 'package:omni_bridge_assignment/src/ui/widgets/my_textfield.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';

import '../../../blocs/add pets/add_pets_bloc.dart';
import '../../../core/theme.dart';
import '../../widgets/my_button.dart';

class AddPetsScreen extends StatefulWidget {
  final String ownerName;
  final String ownerContact;
  const AddPetsScreen(
      {super.key, required this.ownerContact, required this.ownerName});

  @override
  State<AddPetsScreen> createState() => _AddPetsScreenState();
}

class _AddPetsScreenState extends State<AddPetsScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final colorController = TextEditingController();
  final ageController = TextEditingController();
  final ownerNameController = TextEditingController();
  final ownerPhoneController = TextEditingController();
  final petFormKey = GlobalKey<FormState>();
  File? selectedImage;

  bool isButtonDisabled = true;
  String selectedCategory = "";

  final AddPetsBloc addPetsBloc = AddPetsBloc();

  @override
  void initState() {
    setState(() {
      ownerNameController.text = widget.ownerName;
      ownerPhoneController.text = widget.ownerContact;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        shadowColor: Colors.black12,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Add Pet",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: ListView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: 20),
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Please fill the required details to continue",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () => requestStoragePermissionAndOpenGallery(),
            child: Container(
              height: 110,
              width: 110,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.shade200),
              child: selectedImage != null
                  ? CircleAvatar(
                      radius: 55,
                      backgroundImage: FileImage(selectedImage!),
                    )
                  : const Icon(
                      Icons.image,
                      size: 24,
                      color: Colors.black,
                    ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Form(
              key: petFormKey,
              onChanged: () {
                setState(() {
                  isButtonDisabled = !petFormKey.currentState!.validate() &&
                      selectedImage == null;
                });
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedCategory.isEmpty ? null : selectedCategory,
                    onChanged: (String? value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                    hint: Text(
                      "Category",
                      style: TextStyle(
                        fontSize: 15,
                        color: ColorTheme.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    focusColor: Colors.transparent,
                    decoration: MyInputDecoration.getInputDecoration(
                        hintText: "Categories",
                        prefix: const Icon(
                          Icons.category_rounded,
                          size: 18,
                          color: Colors.black,
                        )),
                    items: Constants.petsCategories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    }).toList(),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return "Category is required";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MyTextField(
                      controller: nameController,
                      hintText: "Name",
                      inputType: TextInputType.name,
                      preffix: const Icon(
                        Icons.pets_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Pet name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MyTextField(
                      controller: descriptionController,
                      hintText: "Desciption",
                      maxLines: 3,
                      inputType: TextInputType.text,
                      preffix: const Icon(
                        Icons.description_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Description is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MyTextField(
                      controller: colorController,
                      hintText: "Color",
                      inputType: TextInputType.text,
                      preffix: const Icon(
                        Icons.color_lens_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Pet color is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MyTextField(
                      controller: ageController,
                      hintText: "Age (in months)",
                      inputType: TextInputType.number,
                      preffix: const Icon(
                        Icons.calendar_today_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Pet age is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MyTextField(
                      controller: ownerNameController,
                      hintText: "Owner name",
                      readOnly: true,
                      inputType: TextInputType.text,
                      preffix: const Icon(
                        Icons.person_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Owner name is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: MyTextField(
                      controller: ownerPhoneController,
                      hintText: "Owner contact",
                      readOnly: true,
                      inputType: TextInputType.phone,
                      preffix: const Icon(
                        Icons.phone_rounded,
                        size: 18,
                        color: Colors.black,
                      ),
                      validator: (val) {
                        if (val == null || val.trim().isEmpty) {
                          return "Owner contact is required";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocListener<AddPetsBloc, AddPetsState>(
                    bloc: addPetsBloc,
                    listener: (context, state) {
                      if (state is AddPetsLoading) {
                        Loading.showLoading(context);
                      } else if (state is AddPetsSuccessfully) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, "/home", (Route<dynamic> route) => false);
                        Loading.showSnackBar(context, "New pet has been added");
                      } else if (state is AddPetsError) {
                        Navigator.pop(context);
                        Loading.showSnackBar(context,
                            state.exception.message ?? "Something went wrong");
                      }
                    },
                    child: MyElevatedButton(
                        onPress: isButtonDisabled
                            ? null
                            : () {
                                final id = const Uuid().v4();
                                addPetsBloc.add(AddPet(
                                    pet: PetsModel(
                                        id: id,
                                        category: selectedCategory.trim(),
                                        name: nameController.text.trim(),
                                        description:
                                            descriptionController.text.trim(),
                                        color: colorController.text.trim(),
                                        age: ageController.text.trim(),
                                        ownerName:
                                            ownerNameController.text.trim(),
                                        ownerContact:
                                            ownerPhoneController.text.trim(),
                                        image: selectedImage!.path)));
                              },
                        width: size.width,
                        elevation: 0,
                        height: 50,
                        child: Text(
                          "Add Pet",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white),
                        )),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Future<void> requestStoragePermissionAndOpenGallery() async {
    PermissionStatus status = await Permission.storage.request();
    if (status == PermissionStatus.denied) {
      status = await Permission.photos.request();
    }
    log(status.toString());
    handlePermissionStatus(status);
  }

  void handlePermissionStatus(PermissionStatus status) {
    if (status.isGranted) {
      openGallery();
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Permission denied!"),
            content: const Text(
                "Please go to settings and allow required permissions to this functionality."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text("Open Settings"),
              ),
            ],
          );
        },
      );
    }
  }

  void openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }
}
