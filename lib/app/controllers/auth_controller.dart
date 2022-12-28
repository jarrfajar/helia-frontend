import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:helia/app/routes/app_pages.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // TOASTIFY
  void toast({required String title, required Color colors, int second = 1}) {
    Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colors,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // REGISTER
  void register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;
      if (name == '' || email == '' || password == '') {
        isLoading.value = false;
        toast(title: 'Name, email dan password tidak boleh kosong', colors: Colors.redAccent, second: 5);
      } else {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        print(['sssss', userCredential]);
        if (userCredential.user != null) {
          String uid = userCredential.user!.uid;

          // ADD DATA USER
          await firestore.collection('user').doc(uid).set({
            'name': name,
            'email': email,
            'uid': uid,
            'role': 'user',
            'phone': 'Not set',
            'address': 'Not set',
            'image': '',
            'createAt': DateTime.now(),
          });
        }

        // KIRIM VERIFIKASI EMAIL
        await userCredential.user!.sendEmailVerification();
        // BERHASIL
        isLoading.value = false;
        toast(title: 'check you email for verification', colors: Colors.green, second: 3);
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        isLoading.value = false;
        toast(title: 'The password provided is too weak.', colors: Colors.redAccent);
      } else if (e.code == 'email-already-in-use') {
        isLoading.value = false;
        toast(title: 'The account already exists for that email.', colors: Colors.redAccent);
      }
    } catch (e) {
      isLoading.value = false;
      toast(title: 'server error', colors: Colors.redAccent);
    }
  }

  // LOGIN
  void login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      if (email == '' || password == '') {
        isLoading.value = false;
        toast(title: 'email dan password tidak boleh kosong', colors: Colors.redAccent, second: 5);
      } else {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
        if (userCredential.user!.emailVerified) {
          Get.offAllNamed(Routes.HOME);
          isLoading.value = false;
        } else {
          // toast(title: 'your email not verify', colors: Colors.red);
          Get.dialog(
            AlertDialog(
              content: const Text('your email not verify, send email verification right now?'),
              actions: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // <-- Radius
                    ),
                    side: const BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    isLoading.value = false;
                  },
                  child: const Text(
                    "Batal",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ), // <-- Radius
                    ),
                  ),
                  onPressed: () async {
                    await userCredential.user!.sendEmailVerification();
                    toast(title: 'check you email for verification', colors: Colors.green, second: 3);
                    Get.back();
                    isLoading.value = false;
                  },
                  child: const Text("Kirim"),
                ),
              ],
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        isLoading.value = false;
        toast(title: 'No user found for that email.', colors: Colors.red);
      } else if (e.code == 'wrong-password') {
        isLoading.value = false;
        toast(title: 'Wrong password provided for that user.', colors: Colors.red);
      }
    } catch (e) {
      isLoading.value = false;
      toast(title: 'server error', colors: Colors.red);
    }
  }

  // LOGOUT
  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
}
