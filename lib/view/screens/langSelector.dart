import 'package:flutter/material.dart';
import 'package:onboard/model/providers/languageProvider.dart';
import 'package:onboard/view/route/appPages.dart';
import 'package:onboard/view/route/customNavigator.dart';
import 'package:provider/provider.dart';
class langSelector extends StatefulWidget {
  const langSelector({super.key});

  @override
  State<langSelector> createState() => _langSelectorState();
}

class _langSelectorState extends State<langSelector> {
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLangCode(0);
                    CustomNavigator.pushReplace(context, AppPages.login);
                  },
                  child: const Text('English'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLangCode(1);
                    CustomNavigator.pushReplace(context, AppPages.login);
                  },
                  child: const Text('Hindi'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLangCode(2);
                    CustomNavigator.pushReplace(context, AppPages.login);
                  },
                  child: const Text('Marathi'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}