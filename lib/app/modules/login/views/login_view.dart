import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import GoogleSignIn
import 'package:mytsel/app/modules/home/views/home_view.dart';
import 'package:mytsel/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn =
      GoogleSignIn(); // Create an instance of GoogleSignIn

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Handle successful login, e.g., navigate to the next screen

      // Example navigation to a home page
      Get.to(HomeView());
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

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

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
        Get.to(HomeView());
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

  Future<void> _signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

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
          } else {
            // User is not new, show snackbar indicating user needs to sign in
            Get.snackbar(
              "Sign-In Required",
              "You don't have an account linked to this email. Please sign in.",
              snackPosition: SnackPosition.TOP,
            );
          }

          // Navigate to the home screen after successful sign-up or sign-in
          Get.to(HomeView());
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Image.asset("assets/logo/logo-login.png"),
        Text("Silahkan masuk dengan email kamu"),
        Text("Email"),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(hintText: "Cth. email@domain.com"),
        ),
        Text("Password"),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: InputDecoration(hintText: "Password"),
        ),
        ElevatedButton(
          onPressed: () => _signInWithEmailAndPassword(context),
          child: Text("Login"),
        ),
        ElevatedButton(
          onPressed: _signInWithGoogle, // Call the Google Sign-In function
          child: Text("Sign In with Google"),
        ),
        ElevatedButton(
          onPressed: () => _signUpWithGoogle(),
          child: Text("Sign Up with Google"),
        ),
      ]),
    );
  }
}
