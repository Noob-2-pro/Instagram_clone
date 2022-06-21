import 'dart:typed_data';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/resources/auth.methods.dart';
import 'package:instagram_clone/utils/utils.dart';
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
  final _formKeySignUp = GlobalKey<FormState>();
  bool isObscure = true;
  bool isError = true;
  bool _isLoading = false;
  String errorText = "";
  Uint8List? image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _userNameController.dispose();
  }

  Future signUpUser() async {
    if (_formKeySignUp.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await AuthMethods()
          .signupUser(
        email: _emailController.text,
        username: _userNameController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        file: image,
      )
          .onError(
        (error, stackTrace) {
          errorText = error.toString();
          isError = true;
          setState(() {});
        },
      ).then((value) {
        if (value == true) {
          print('Sign up done');
          isError = false;
          setState(() {});
          Navigator.pop(context);
          Navigator.pushReplacementNamed(context, responsiveLayout);
        }
      });
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: _formKeySignUp,
        child: SingleChildScrollView(
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
                    Stack(
                      children: [
                        image == null
                            ? CircleAvatar(
                                radius: 45,
                                backgroundImage: const AssetImage("assets/dp_placeholder.png"),
                              )
                            : CircleAvatar(
                                radius: 45,
                                backgroundImage: MemoryImage(image!),
                              ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: InkWell(
                              onTap: () async {
                                image = await UtilsMethods().imagePicker() as Uint8List?;
                                setState(() {});
                              },
                              child: Icon(Icons.add_a_photo)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CustomTextFeild(
                        hintText: "User name",
                        textFieldController: _userNameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CustomTextFeild(
                        hintText: "bio",
                        textFieldController: _bioController,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await signUpUser();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith((states) => Colors.blue),
                        fixedSize: MaterialStateProperty.resolveWith((states) => const Size.fromWidth(double.infinity)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: _isLoading
                            ? SizedBox(
                                height: 12,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                "Sign Up",
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
                      child: plain_then_link_text(
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
                            "Sign Up with Facebook",
                            style: TextStyle(color: Colors.blue),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              plain_then_link_text(
                plaintext: "Already have an account? ",
                linkText: 'Log In',
                onTap: () {
                  Navigator.pushReplacementNamed(context, loginRoute);
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
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
