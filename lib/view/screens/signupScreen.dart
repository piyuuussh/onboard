import 'package:flutter/material.dart';
import 'package:onboard/core/constants/AppColors.dart';
import 'package:onboard/model/datasource/authmethods.dart';
import 'package:onboard/model/providers/languageProvider.dart';
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/route/customNavigator.dart';
import 'package:onboard/view/widgets/Textfield.dart';
import 'package:provider/provider.dart';

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
  String controlStatement(var langCode,String eng,String hindi,String marathi){
    if(langCode==0){
      return eng;
    }
    else if(langCode==1){
      return hindi;
    }
    else{
      return marathi;
    }

  }
  @override
  Widget build(BuildContext context) {
    var langCode = Provider.of<LanguageProvider>(context).langCode;
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
                     Text(
                      controlStatement(langCode,"Register Now","अब रजिस्टर करें","आता नोंदणी करा"),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: AppColors.Primary),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFieldController(
                      hinttext: controlStatement(langCode,"Enter Full Name","पूरा नाम दर्ज करें","पूर्ण नाव दर्ज करा "),
                      textEditingController: nameController,
                      labeltext: controlStatement(langCode, "Enter Full Name","पूरा नाम दर्ज करें","पूर्ण नाव दर्ज करा "),
                      textInputType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person),
                      borderRadius: 10,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldController(
                      hinttext: controlStatement(langCode, "Email Address","ईमेल पता दर्ज करें","ईमेल पत्ता प्रविष्ट करा"),
                      textEditingController: emailController,
                      labeltext: controlStatement(langCode,"Email","ईमेल","ईमेल"),
                      textInputType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email),
                      borderRadius: 10,
                      obscureText: false,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldController(
                      hinttext: controlStatement(langCode,"Enter Password","पासवर्ड दर्ज करें","संकेतशब्द प्रविष्ट करा"),
                      textEditingController: passwordController,
                      labeltext: controlStatement(langCode,"Password","पासवर्ड","संकेतशब्द"),
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
                          child: Text(
                            controlStatement(langCode,"Sign Up","साइन अप करें","साइन अप करा"),
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(controlStatement(langCode,"Already have an account?","पहले से ही खाता है?","आधीच खाते आहेत?")),
                        TextButton(
                            onPressed: () => CustomNavigator.pushReplace(
                                context, AppPages.login),
                            child: Text(
                              controlStatement(langCode,"Login","लॉग इन करें","लॉग इन करा"),
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
