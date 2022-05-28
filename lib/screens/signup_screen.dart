import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_mid/resources/auth_methods.dart';
import 'package:instagram_mid/responsive/mobile_screen_layout.dart';
import 'package:instagram_mid/responsive/responsive_layout_sreen.dart';
import 'package:instagram_mid/screens/login_screen.dart';
import 'package:instagram_mid/utils/utils.dart';
import '../utils/colors.dart';
import '../widgets/text_field_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);

    setState(() {
      _isLoading = false;
    });

    if (res == 'success') {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const ReponsiveLayout(mobileScreenLayout: MobileScreenLayout())));
    }
  }

  void navigateToLogin() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
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
              //cicular wiget to accept and show our selected file
              Stack(children: [
                _image != null
                    ? CircleAvatar(
                        radius: 64,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : const CircleAvatar(
                        radius: 64,
                        backgroundImage: NetworkImage(
                            'https://minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg')),
                Positioned(
                    bottom: -10,
                    left: 80,
                    child: IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        )))
              ]),
              const SizedBox(height: 24),
              //text input username
              TextFieldInput(
                textEditingController: _usernameController,
                hintText: 'Enter your User Name',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
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
              //text input username
              TextFieldInput(
                textEditingController: _bioController,
                hintText: 'Enter your Bio',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 24),
              //button login
              InkWell(
                  onTap: signUpUser,
                  child: Container(
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: primaryColor,
                          ))
                        : const Text('Sign Up'),
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
              //trans to register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text("Do you have an Account? "),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  GestureDetector(
                    onTap: navigateToLogin,
                    child: Container(
                      child: const Text("Login.",
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
