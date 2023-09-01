// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mytsel/app/modules/login/controllers/loginService.dart';
import '../../../../const/storage_key.dart';
import '../../../models/LoginPayload.dart';
import '../../../models/LoginResponse.dart';
import '../../../models/user.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var checkC = false.obs;
  var selectedLanguage = Get.locale?.languageCode.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginService _loginService = GetInstance().find<LoginService>();

  set changeLanguage(String? lang) {
    if (lang != null) {
      Locale locale = Locale(lang);
      Get.updateLocale(locale);
      selectedLanguage?.value = lang;
    }
  }

  Future<void> performLogin() async {
    String email = emailController.text;
    String password = passwordController.text;
    print("halo");
    if (email.isEmpty || password.isEmpty) {
      // Display an error message using Get.snackbar
      Get.snackbar('Error', 'Please fill in both email and password.');
      return;
    }

    LoginPayload payload = LoginPayload(email: email, password: password);
    print(payload.email);
    try {
      var response = await _loginService.Login(payload);
      if (response.statusCode == 200) {
        // Successful login, navigate to the next screen using Get.to
        GetStorage().write(StorageKey.jwt, response.body['token']);
        // Handle successful Google Sign-In, e.g., navigate to the next screen
        Get.offAllNamed(Routes.HOME);
      } else {
        // Handle unsuccessful login using Get.snackbar
        Get.snackbar('Error', 'Login failed. Please check your credentials.');
      }
    } catch (error) {
      // Handle any exceptions that occurred during the login process
      print('Login Error: $error');
      Get.snackbar('Error', 'An error occurred during login.');
    }
  }

  // final GoogleSignIn googleSignIn =
  //     GoogleSignIn(); // Create an instance of GoogleSignIn
  //
  // Future<void> signInWithEmailAndPassword(BuildContext context) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: emailController.text,
  //       password: passwordController.text,
  //     );
  //     // Handle successful login, e.g., navigate to the next screen
  //
  //     // Example navigation to a home page
  //     Get.offAllNamed(Routes.HOME);
  //   } on FirebaseAuthException catch (e) {
  //     // Handle login error, show a snackbar or error message
  //     Get.snackbar(
  //       "Login Error",
  //       e.message!,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     print("Error: ${e.message}");
  //   }
  // }
  //
  // Future<void> signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuth =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuth.accessToken,
  //         idToken: googleSignInAuth.idToken,
  //       );
  //       print(googleSignInAuth.idToken);
  //       print(credential);
  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //       print(userCredential);
  //       Get.put<UserCredential>(userCredential);
  //       // Handle successful Google Sign-In, e.g., navigate to the next screen
  //       Get.offAllNamed(Routes.HOME);
  //     } else {
  //       // User canceled Google Sign-In or didn't choose an account
  //       print("User canceled Google Sign-In or didn't choose an account.");
  //     }
  //   } catch (e) {
  //     // Handle Google Sign-In error, show a snackbar or error message
  //     Get.snackbar(
  //       "Google Sign-In Error",
  //       "Failed to sign in with Google.",
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     print("Google Sign-In Error: $e");
  //   }
  // }

  void accept_eula() {
    Get.snackbar(
      "Anda belum menyetujui syarat, ketentuan, dan privasi Telkomsel",
      "Silahkan membaca dan menyetujui syarat, ketentuan dan privasi Telkomsel",
      snackPosition: SnackPosition.TOP,
    );
  }

  // Future<void> signUpWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount =
  //         await googleSignIn.signIn();
  //
  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuth =
  //           await googleSignInAccount.authentication;
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuth.accessToken,
  //         idToken: googleSignInAuth.idToken,
  //       );
  //
  //       final UserCredential userCredential =
  //           await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //       final User? user = userCredential.user;
  //
  //       if (user != null) {
  //         // Check if the user is new (just signed up with Google)
  //         if (userCredential.additionalUserInfo?.isNewUser == true) {
  //           // Automatically update user profile with Google data
  //           await user.updateProfile(
  //             displayName: user.displayName ?? "New User",
  //             photoURL: user.photoURL ?? "",
  //           );
  //
  //           // Show snackbar for successful registration
  //           Get.snackbar(
  //             "Registration Successful",
  //             "Registration completed successfully.",
  //             snackPosition: SnackPosition.TOP,
  //           );
  //           // Navigate to the home screen after successful sign-up or sign-in
  //           Get.offAllNamed(Routes.HOME);
  //         } else {
  //           // User is not new, show snackbar indicating user needs to sign in
  //           Get.snackbar(
  //             "Sign-In Required",
  //             "You already have an account linked to this email. Please sign in.",
  //             snackPosition: SnackPosition.TOP,
  //           );
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     // Handle Google Sign-Up error, show a snackbar or error message
  //     Get.snackbar(
  //       "Google Sign-Up Error",
  //       "Failed to sign up with Google.",
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     print("Google Sign-Up Error: $e");
  //   }
  // }

  Future<User> fetchUserData(String email) async {
    User userData = User(id: -1);
    try {
      var response = await _loginService.getUserData(email);
      if (response.status.hasError) {
        print("Error: ${response.statusText}");
      } else {
        userData = User.fromJson(response.body as Map<String, dynamic>);
        print("success");
        return userData;
      }
    } catch (e) {
      print("Exception: $e");
    }
    return userData;
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
