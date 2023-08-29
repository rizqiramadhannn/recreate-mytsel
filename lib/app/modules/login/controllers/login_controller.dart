import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../api/ApiProvider.dart';
import '../../../routes/app_pages.dart';
import '../../home/views/home_view.dart';

class LoginController extends GetxController {
  var checkC = false.obs;
  var selectedLanguage = Get.locale?.languageCode.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  set changeLanguage(String? lang) {
    if (lang != null) {
      Locale locale = Locale(lang);
      Get.updateLocale(locale);
      selectedLanguage?.value = lang;
    }
  }

  final GoogleSignIn googleSignIn =
      GoogleSignIn(); // Create an instance of GoogleSignIn

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Handle successful login, e.g., navigate to the next screen

      // Example navigation to a home page
      Get.offAllNamed(Routes.HOME);
    } on FirebaseAuthException catch (e) {
      // Handle login error, show a snackbar or error message
      Get.snackbar(
        "Login Error",
        e.message!,
        snackPosition: SnackPosition.TOP,
      );
      print("Error: ${e.message}");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        // Handle successful Google Sign-In, e.g., navigate to the next screen
        Get.offAllNamed(Routes.HOME);
      } else {
        // User canceled Google Sign-In or didn't choose an account
        print("User canceled Google Sign-In or didn't choose an account.");
      }
    } catch (e) {
      // Handle Google Sign-In error, show a snackbar or error message
      Get.snackbar(
        "Google Sign-In Error",
        "Failed to sign in with Google.",
        snackPosition: SnackPosition.TOP,
      );
      print("Google Sign-In Error: $e");
    }
  }

  void accept_eula() {
    Get.snackbar(
      "Anda belum menyetujui syarat, ketentuan, dan privasi Telkomsel",
      "Silahkan membaca dan menyetujui syarat, ketentuan dan privasi Telkomsel",
      snackPosition: SnackPosition.TOP,
    );
  }

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final User? user = userCredential.user;

        if (user != null) {
          // Check if the user is new (just signed up with Google)
          if (userCredential.additionalUserInfo?.isNewUser == true) {
            // Automatically update user profile with Google data
            await user.updateProfile(
              displayName: user.displayName ?? "New User",
              photoURL: user.photoURL ?? "",
            );

            // Show snackbar for successful registration
            Get.snackbar(
              "Registration Successful",
              "Registration completed successfully.",
              snackPosition: SnackPosition.TOP,
            );
            // Navigate to the home screen after successful sign-up or sign-in
            Get.offAllNamed(Routes.HOME);
          } else {
            // User is not new, show snackbar indicating user needs to sign in
            Get.snackbar(
              "Sign-In Required",
              "You already have an account linked to this email. Please sign in.",
              snackPosition: SnackPosition.TOP,
            );
          }
        }
      }
    } catch (e) {
      // Handle Google Sign-Up error, show a snackbar or error message
      Get.snackbar(
        "Google Sign-Up Error",
        "Failed to sign up with Google.",
        snackPosition: SnackPosition.TOP,
      );
      print("Google Sign-Up Error: $e");
    }
  }

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void increment() => count.value++;
}
