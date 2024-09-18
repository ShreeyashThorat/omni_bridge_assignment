import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:omni_bridge_assignment/src/models/pets_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../core/error handler/app_exception.dart';

class PetsRepo {
  final auth = FirebaseAuth.instance;
  Future<void> addNewPet(PetsModel pet) async {
    try {
      String uid = auth.currentUser!.uid.toString();
      var petJson = pet.toJson();

      final Reference storageRef = FirebaseStorage.instance
          .ref()
          .child('pets/$uid/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final UploadTask uploadTask = storageRef.putFile(File(pet.image!));
      final TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      petJson["image"] = downloadUrl;
      petJson["ownerId"] = uid;
      await FirebaseFirestore.instance
          .collection("pet")
          .doc(pet.id)
          .set(petJson);
    } on FirebaseException catch (e) {
      throw AppExceptionHandler.throwException(e);
    } catch (e) {
      throw AppExceptionHandler.throwException(e);
    }
  }

  Future<List<PetsModel>> getPets(String category, {String? lastPetId}) async {
    try {
      Query query = FirebaseFirestore.instance
          .collection("pet")
          .orderBy(FieldPath.documentId)
          .limit(5);
      if (category != "All") {
        query = query.where('category', isEqualTo: category);
      }
      if (lastPetId != null) {
        query = query.startAfter([lastPetId]);
      }

      QuerySnapshot querySnapshot = await query.get();
      List<PetsModel> pets = querySnapshot.docs.map((doc) {
        return PetsModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      return pets;
    } on FirebaseException catch (e) {
      throw AppExceptionHandler.throwException(e);
    } catch (e) {
      throw AppExceptionHandler.throwException(e);
    }
  }
}
