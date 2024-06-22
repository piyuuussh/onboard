import 'package:flutter/material.dart';
import 'package:onboard/core/constants/AppColors.dart';
import 'package:onboard/model/datasource/authmethods.dart';
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/route/customNavigator.dart';
import 'package:onboard/view/widgets/Textfield.dart';

class signupScreen extends StatefulWidget {
  signupScreen({super.key});

  @override
  State<signupScreen> createState() => _signupScreenState();
}

class _signupScreenState extends State<signupScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  void signUpUser() async {
    String res = await AuthMethods().SignUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // if string returned is sucess, user has been created
    if (res == "success") {
      // navigate to the home screen
      CustomNavigator.pushReplace(context, AppPages.home);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/bgscreen.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        child: Center(
          child: Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Register Now!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.Primary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldController(
                      hinttext: "Enter Full Name",
                      textEditingController: nameController,
                      labeltext: "Full Name",
                      textInputType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                      borderRadius: 10,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldController(
                      hinttext: "Enter Email Address",
                      textEditingController: emailController,
                      labeltext: "Email",
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      borderRadius: 10,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldController(
                      hinttext: "Enter Password",
                      textEditingController: passwordController,
                      labeltext: "Password",
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(Icons.lock),
                      borderRadius: 10,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      height: 44,
                      decoration: BoxDecoration(
                          color: AppColors.Secondary,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                          onPressed: () => signUpUser(),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                            onPressed: () => CustomNavigator.pushReplace(
                                context, AppPages.login),
                            child: const Text(
                              "Sign In",
                              style: TextStyle(color: Colors.blue),
                            ))
                      ],
                    )
                  ],
                ),
              )),
        ),
      ),
    ));
  }
}
