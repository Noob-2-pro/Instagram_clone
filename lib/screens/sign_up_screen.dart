import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/widgets/textfield.dart';

import '../navigation.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _bioController = TextEditingController();
  final _userNameController = TextEditingController();
  bool isObscure = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/Instagram_logo.svg',
                    height: 60,
                    color: Colors.white,
                  ),
                  SizedBox(height: 25),
                  CustomTextFeild(
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      textFieldController: _emailController),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: CustomTextFeild(
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      textFieldController: _passwordController,
                      iconWidget: InkWell(
                          onTap: () {
                            isObscure = !isObscure;
                            setState(() {});
                          },
                          child: isObscure
                              ? Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )),
                      isObscure: isObscure,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(bottom: 15),
                  //   child: CustomTextFeild(
                  //     hintText: "Confirm Password",
                  //     keyboardType: TextInputType.visiblePassword,
                  //     textFieldController: _confirmPasswordController,
                  //     iconWidget: InkWell(
                  //         onTap: () {
                  //           isObscure = !isObscure;
                  //           setState(() {});
                  //         },
                  //         child: isObscure
                  //             ? Icon(
                  //                 Icons.visibility_off_outlined,
                  //                 color: Colors.white,
                  //               )
                  //             : Icon(
                  //                 Icons.visibility,
                  //                 color: Colors.white,
                  //               )),
                  //     isObscure: isObscure,
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextFeild(
                      hintText: "User name",
                      keyboardType: TextInputType.visiblePassword,
                      textFieldController: _userNameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextFeild(
                      hintText: "bio",
                      keyboardType: TextInputType.visiblePassword,
                      textFieldController: _bioController,
                    ),
                  ),

                  ElevatedButton(
                    onPressed: () {
                      print("signUp initiated");
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                      fixedSize: MaterialStateProperty.resolveWith((states) => Size.fromWidth(double.infinity)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: const Text(
                        "Sign Up",
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: plain_then_link_text(
                      plaintext: "Forgot your login details? ",
                      linkText: 'Get help logging in',
                    ),
                  ),
                  // OR divider
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          height: 10,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('OR'),
                      ),
                      Expanded(
                        child: Divider(
                          height: 10,
                          thickness: 2,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.facebook_outlined, color: Colors.blue),
                        SizedBox(width: 5),
                        Text(
                          "Sign Up with Facebook",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            plain_then_link_text(
              plaintext: "Already have an account? ",
              linkText: 'Log In',
              onTap: () {
                Navigator.pushReplacementNamed(context, loginRoute);
              },
            ),
            SizedBox(height: 15),
          ],
        ),
      )),
    );
  }

  Text plain_then_link_text({required String plaintext, required String linkText, Function()? onTap}) {
    return Text.rich(
      TextSpan(text: plaintext, children: [
        TextSpan(
          text: linkText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
          ),
          recognizer: TapGestureRecognizer()..onTap = onTap,
        )
      ]),
    );
  }
}
