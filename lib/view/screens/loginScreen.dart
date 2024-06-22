import 'package:flutter/material.dart';
import 'package:onboard/core/constants/AppColors.dart';
import 'package:onboard/model/datasource/authmethods.dart';
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/route/customNavigator.dart';
import 'package:onboard/view/widgets/Textfield.dart';

class loginScreen extends StatefulWidget {
  loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: emailController.text, password: passwordController.text);
    if (res == 'success') {
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
        padding: const EdgeInsets.only(left: 35, right: 35),
        child: Center(
          child: Container(
              height: 380,
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
                      "Welcome Back!",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.Primary),
                    ),
                    const SizedBox(
                      height: 20,
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
                          onPressed: () => loginUser(),
                          child: const Text(
                            "Login",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                            onPressed: () => CustomNavigator.pushReplace(
                                context, AppPages.register),
                            child: const Text(
                              "Register",
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
