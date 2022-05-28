import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_mid/resources/auth_methods.dart';
import 'package:instagram_mid/responsive/mobile_screen_layout.dart';
import 'package:instagram_mid/responsive/responsive_layout_sreen.dart';
import 'package:instagram_mid/screens/signup_screen.dart';
import 'package:instagram_mid/utils/colors.dart';
import 'package:instagram_mid/utils/global_variable.dart';
import 'package:instagram_mid/utils/utils.dart';
import 'package:instagram_mid/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passController.text);

    if (res == "Success") {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const ReponsiveLayout(mobileScreenLayout: MobileScreenLayout())));
    } else {
      // {
      setState(() {
        _isLoading = false;
      });
      showSnackBar(context, res);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(child: Container(), flex: 2),
              //image svg
              SvgPicture.asset(
                'assets/ic_instagram.svg',
                color: primaryColor,
                height: 64,
              ),
              const SizedBox(height: 64),
              //text input email
              TextFieldInput(
                textEditingController: _emailController,
                hintText: 'Enter your email or phone',
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              //text input pass
              TextFieldInput(
                textEditingController: _passController,
                hintText: 'Enter your Password',
                textInputType: TextInputType.text,
                isPass: true,
              ),
              const SizedBox(height: 24),
              InkWell(
                  onTap: loginUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: primaryColor,
                          ))
                        : const Text('Log in'),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                        color: Colors.blue),
                  )),
              const SizedBox(height: 12),
              Flexible(child: Container(), flex: 2),
              //bt login
              //trans to register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Don't have an Account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToSignUp,
                    child: Container(
                      child: const Text("Sign up.",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
