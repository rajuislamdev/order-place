import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:place_order/services/local_storage.dart';

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider(this.ref);
  bool isLoading = false;

  // Future<bool> createAccount({
  //   required String email,
  //   required String password,
  // }) async {
  //   isLoading = true;
  //   notifyListeners();
  //   DatabaseReference usersRef = FirebaseDatabase.instance.ref().child('users');
  //   try {
  //     await usersRef.push().set({
  //       'email': email,
  //       'password': password,
  //     });
  //     isLoading = false;
  //     notifyListeners();
  //     return true;
  //   } catch (error) {
  //     isLoading = false;
  //     notifyListeners();
  //     return false;
  //   }
  // }

  FirebaseAuth auth = FirebaseAuth.instance;
  Future<bool> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      ref.read(localStorageProvider).saveToken(user!.uid);
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // ...
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> loginWithEmailAndPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;
      ref.read(localStorageProvider).saveToken(user!.uid);
      isLoading = false;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        const snackbar = SnackBar(
          content: Text('User not found!'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      } else if (e.code == 'wrong-password') {
        const snackbar = SnackBar(
          content: Text('Please enter correct password!'),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
      isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}

final authProvider = ChangeNotifierProvider((ref) => AuthProvider(ref));
