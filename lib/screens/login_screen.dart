import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth.methods.dart';
import 'package:instagram_clone/widgets/textfield.dart';

import '../navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isError = false;
  String errorText = "";

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/Instagram_logo.svg',
                    height: 60,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 25),
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
                              ? const Icon(
                                  Icons.visibility_off_outlined,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                )),
                      isObscure: isObscure,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await AuthMethods()
                            .loginUser(email: _emailController.text, password: _passwordController.text)
                            .then((value) {
                          if (value == true) {
                            isError = false;
                            setState(() {});
                            Navigator.pushReplacementNamed(context, responsiveLayout);
                          }
                        }).onError((error, stackTrace) {
                          errorText = error.toString();
                          isError = true;
                          setState(() {});
                        });
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                      fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromWidth(double.infinity)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text(
                        "Log In",
                      ),
                    ),
                  ),
                  if (isError)
                    Text(
                      errorText,
                      style: const TextStyle(color: Colors.red),
                    ),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: plainThenLinkText(
                      plaintext: "Forgot your login details? ",
                      linkText: 'Get help logging in',
                    ),
                  ),
                  // OR divider
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          height: 10,
                          thickness: 2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
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
                          "Log in with Facebook",
                          style: TextStyle(color: Colors.blue),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            plainThenLinkText(
              plaintext: "Don't have an account? ",
              linkText: 'Sign up',
              onTap: () {
                Navigator.pushNamed(context, signUpRoute);
              },
            ),
            const SizedBox(height: 15),
          ],
        ),
      )),
    );
  }

  Text plainThenLinkText({required String plaintext, required String linkText, Function()? onTap}) {
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
