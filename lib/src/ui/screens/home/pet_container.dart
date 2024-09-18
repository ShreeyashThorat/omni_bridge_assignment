import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:omni_bridge_assignment/src/models/pets_model.dart';

class PetContainer extends StatefulWidget {
  final PetsModel pet;
  const PetContainer({super.key, required this.pet});

  @override
  State<PetContainer> createState() => _PetContainerState();
}

class _PetContainerState extends State<PetContainer> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      constraints: const BoxConstraints(minWidth: 120, maxWidth: 200),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(1, 4),
                blurRadius: 10)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: CachedNetworkImage(
                cacheKey: widget.pet.id,
                alignment: Alignment.center,
                fit: BoxFit.cover,
                width: 75,
                height: 75,
                fadeInDuration: const Duration(milliseconds: 200),
                fadeInCurve: Curves.easeInOut,
                imageUrl: widget.pet.image!,
                errorWidget: (context, url, error) => const Icon(Icons.error),
                progressIndicatorBuilder: (context, url, progress) {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.pet.name!,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            widget.pet.description!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Color: ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextSpan(
                  text: widget.pet.color!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: "Age: ",
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextSpan(
                  text: "${widget.pet.age!} Months",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
