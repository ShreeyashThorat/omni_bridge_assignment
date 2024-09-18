import 'package:flutter/material.dart';

class PetsCategoryDropDown extends StatefulWidget {
  final bool showHistory;
  final List<String> categories;
  final Function(String) selectItem;
  const PetsCategoryDropDown(
      {super.key,
      required this.categories,
      required this.selectItem,
      required this.showHistory});

  @override
  State<PetsCategoryDropDown> createState() => _PetsCategoryDropDownState();
}

class _PetsCategoryDropDownState extends State<PetsCategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInCubic,
      width: size.width,
      constraints: BoxConstraints(
          maxHeight: widget.showHistory == true ? size.height * 0.35 : 0),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      decoration: widget.categories.isNotEmpty
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey.shade200),
            )
          : null,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(widget.categories.length, (index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    title: InkWell(
                        onTap: () {
                          widget.selectItem(widget.categories[index]);
                        },
                        child: Text(widget.categories[index])),
                  ),
                  index != widget.categories.length - 1
                      ? Divider(
                          height: 1,
                          color: Colors.grey.shade200,
                        )
                      : const SizedBox()
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
