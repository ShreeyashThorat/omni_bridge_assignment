import 'package:bcrypt/bcrypt.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/error handler/app_exception.dart';
import '../models/user_model.dart';

class AuthenticationRepo {
  final auth = FirebaseAuth.instance;
  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name, String contact) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = auth.currentUser!.uid.toString();
      final String hashed = BCrypt.hashpw(password, BCrypt.gensalt());
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'email': email,
        'password': hashed,
        "name": name,
        "contact": contact
      });
    } on FirebaseException catch (e) {
      throw AppExceptionHandler.throwException(e);
    } catch (e) {
      AppExceptionHandler.throwException(e);
    }
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseException catch (e) {
      throw AppExceptionHandler.throwException(e);
    } catch (e) {
      AppExceptionHandler.throwException(e);
    }
  }

  Future<UserModel> getUserData(String uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> user =
          await FirebaseFirestore.instance.collection("users").doc(uid).get();
      if (user.exists) {
        UserModel userData =
            UserModel.fromJson(user.data() as Map<String, dynamic>);
        return userData;
      } else {
        throw AppException();
      }
    } on FirebaseException catch (e) {
      throw AppExceptionHandler.throwException(e);
    } catch (e) {
      AppExceptionHandler.throwException(e);
    }
    throw AppException();
  }

  Future<bool> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseAuthException catch (e) {
      throw AppExceptionHandler.throwException(e);
    } catch (e) {
      AppExceptionHandler.throwException(e);
    }
    return false;
  }
}
