import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import GoogleSignIn
import 'package:mytsel/app/modules/home/views/home_view.dart';
import 'package:mytsel/app/routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(padding: EdgeInsets.all(25), children: [
        Container(
            alignment: Alignment.centerLeft,
            height: 250,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/logo/logo-login.png"),
                SizedBox(width: 10),
                languageChooser()
              ],
            )),
        Text(
          'login-title'.tr,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller.emailController,
          decoration: InputDecoration(
              hintText: 'login-email_placeholder'.tr,
              border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 10,
        ),
        Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
        TextField(
          controller: controller.passwordController,
          obscureText: true,
          decoration: InputDecoration(
              hintText: "Password", border: OutlineInputBorder()),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Obx(
              () => Checkbox(
                activeColor: Colors.red,
                value: controller.checkC.value,
                onChanged: (value) => controller.checkC.toggle(),
              ),
            ),
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: "login-checkbox1".tr,
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Klik syarat");
                            },
                          text: "login-checkbox2".tr,
                          style: TextStyle(color: Colors.red)),
                      TextSpan(
                          text: ", ", style: TextStyle(color: Colors.black)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Klik ketentuan");
                            },
                          text: "login-checkbox3".tr,
                          style: TextStyle(color: Colors.red)),
                      TextSpan(
                          text: "login-checkbox4".tr,
                          style: TextStyle(color: Colors.black)),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              print("Klik privasi");
                            },
                          text: "login-checkbox5".tr,
                          style: TextStyle(color: Colors.red)),
                      TextSpan(
                          text: "login-checkbox6".tr,
                          style: TextStyle(color: Colors.black)),
                    ]),
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Obx(
          () => ElevatedButton(
            onPressed: controller.checkC.value
                ? () => controller.signInWithEmailAndPassword(context)
                : () => controller.accept_eula(),
            child: Text(
              "login-button_text".tr,
              style: TextStyle(
                  color: controller.checkC.value
                      ? Colors.white
                      : Color(0xFF747D8C)),
            ),
            style: ElevatedButton.styleFrom(
                backgroundColor:
                    controller.checkC.value ? Colors.red : Colors.grey[300]),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text('login-alternative_login'.tr),
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => OutlinedButton(
                  onPressed: controller.checkC.value
                      ? () => controller.signInWithGoogle()
                      : () => controller.accept_eula(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/logo/google.png"),
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Google",
                        style: TextStyle(fontSize: 16, color: Colors.grey[850]),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(150, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.grey)))),
            ),
            Obx(
              () => OutlinedButton(
                  onPressed: controller.checkC.value
                      ? () => controller.signInWithGoogle()
                      : () => controller.accept_eula(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/logo/facebook.png"),
                        width: 18,
                        height: 18,
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Text(
                        "Facebook",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFF3B5998)),
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(150, 50)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0))),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Color(0xFF3B5998))))),
            ),
          ],
        )
      ]),
    );
  }

  Container languageChooser() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFE5E5E5),
        border: Border.all(color: Colors.grey), // Add border styling
        borderRadius: BorderRadius.circular(8), // Add border radius if needed
      ),
      padding: EdgeInsets.fromLTRB(9, 4, 9, 4),
      width: 110, // Set the desired width for the Container
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text('Please choose a language'),
          value: controller.selectedLanguage?.value,
          onChanged: (languageCode) {
            controller.changeLanguage = languageCode!;
          },
          items: [
            DropdownMenuItem<String>(
              value: 'id',
              child: Row(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/elements/id_flag.svg', // Replace with the actual path to your SVG flag image
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'ID',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DropdownMenuItem<String>(
              value: 'en_US',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/elements/us_flag.svg', // Replace with the actual path to your SVG flag image
                        width: 24,
                        height: 24,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'EN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
