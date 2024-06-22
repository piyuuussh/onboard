import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onboard/core/constants/AppColors.dart';
import 'package:onboard/model/datasource/MapScreen.dart';
import 'package:onboard/model/providers/languageProvider.dart';
import 'package:onboard/view/screens/ChatBot.dart';
import 'package:onboard/view/widgets/Textfield.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController SourceController = TextEditingController();
  final TextEditingController DestinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var langCode = Provider.of<LanguageProvider>(context).langCode;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage("assets/icons/logo.png"),
            ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ChatBot()),
          );
        },
        child: const Icon(Icons.chat_bubble_outline_outlined),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200,
                child: const Text(
                  "Where do you want to go?",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Stack(
                fit: StackFit.loose,
                children: <Widget>[
                  Positioned(
                      child: Container(
                        child: Icon(
                          Icons.swap_vert,
                          size: 30,
                          color: AppColors.white,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.Primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      left: 280,
                      top: 50),
                  Container(
                    child: Column(
                      children: [
                        TextFieldController(
                            textEditingController: SourceController,
                            textInputType: TextInputType.text,
                            obscureText: false,
                            hinttext: "Departure"),
                        TextFieldController(
                            textEditingController: DestinationController,
                            textInputType: TextInputType.url,
                            obscureText: false,
                            hinttext: "Destination"),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                    color: AppColors.Secondary,
                    borderRadius: BorderRadius.circular(10)),
                child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Lets Go",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 320,
                  width: 320,
                  child: GoogleMapScreen(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 150,
                        height: 75,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.Primary, width: 1),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Optimal Distance",
                            style: TextStyle(color: AppColors.black),
                          ),
                        )),
                    Container(
                        width: 150,
                        height: 75,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: AppColors.Primary, width: 1),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Total Fare",
                            style: TextStyle(color: AppColors.black),
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
