import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:onboard/core/constants/AppColors.dart';
import 'package:onboard/model/datasource/MapScreen.dart';
import 'package:onboard/model/providers/languageProvider.dart';
import 'package:onboard/view/screens/ChatBot.dart';
import 'package:onboard/model/model/BusStops.dart';
import 'package:provider/provider.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  final TextEditingController SourceController = TextEditingController();
  final TextEditingController DestinationController = TextEditingController();
  late Future<List<BusStops>> _busStopsFuture;
  List<BusStops> _busStops = [];
  List<BusStops> _filteredStops1 = [];
  List<BusStops> _filteredStops2 = [];
  BusStops? sourcestop;
  BusStops? destinationstop;

  Future<List<BusStops>> loadBusStops() async {
    final String response =
        await rootBundle.loadString('assets/images/updated_bus_stops.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => BusStops.fromJson(json)).toList();
  }

  void OnSourceSearch(String query) {
    setState(() {
      _filteredStops1 = _busStops
          .where((busStop) =>
              busStop.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void OnDestinationSearch(String query) {
    setState(() {
      _filteredStops2 = _busStops
          .where((busStop) =>
              busStop.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    _busStopsFuture = loadBusStops();
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
    return FutureBuilder<List<BusStops>>(
        future: _busStopsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading bus stops'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No bus stops available'));
          }

          _busStops = snapshot.data!;

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
                      child: Text(
                        langCode == 0 ? "Where do you want to go?" : langCode==1?"आप कहाँ जाना चाहते हैं?":"तुम्हाला कुठे जायचे आहे?",
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
                            left: 280,
                            top: 50,
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
                            )),
                        Container(
                          child: Column(
                            children: [
                              Container(
                                height: 44,
                                child: TextFormField(
                                  obscureText: false,
                                  controller: SourceController,
                                  keyboardType: TextInputType.text,
                                  onChanged: OnSourceSearch,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      hintText: controlStatement(langCode, "Source", "स्रोत", "स्त्रोत"),
                                      hintStyle:
                                          TextStyle(color: AppColors.black),
                                      focusColor: AppColors.black,
                                      enabledBorder: OutlineInputBorder(
                                          // borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: AppColors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.black))),
                                ),
                              ),
                              if (_filteredStops1.isNotEmpty &&
                                  SourceController.text.isNotEmpty)
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: _filteredStops1.length,
                                    itemBuilder: (context, index) {
                                      final busStop = _filteredStops1[index];
                                      return ListTile(
                                        title: Text(busStop.name),
                                        onTap: () {
                                          setState(() {
                                            SourceController.text =
                                                busStop.name;
                                            sourcestop = busStop;
                                            _filteredStops1.clear();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              Container(
                                height: 44,
                                child: TextFormField(
                                  obscureText: false,
                                  controller: DestinationController,
                                  keyboardType: TextInputType.text,
                                  onChanged: OnDestinationSearch,
                                  decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      hintText: controlStatement(langCode, "Destination", "गंतव्य", "गंतव्यस्थान"),
                                      hintStyle:
                                          TextStyle(color: AppColors.black),
                                      focusColor: AppColors.black,
                                      enabledBorder: OutlineInputBorder(
                                          // borderRadius: BorderRadius.all(Radius.circular(8)),
                                          borderSide: BorderSide(
                                              color: AppColors.black)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: AppColors.black))),
                                ),
                              ),
                              if (_filteredStops2.isNotEmpty &&
                                  DestinationController.text.isNotEmpty)
                                Container(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: _filteredStops2.length,
                                    itemBuilder: (context, index) {
                                      final busStop = _filteredStops2[index];
                                      return ListTile(
                                        title: Text(busStop.name),
                                        onTap: () {
                                          setState(() {
                                            DestinationController.text =
                                                busStop.name;
                                            destinationstop = busStop;
                                            _filteredStops2.clear();
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
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
                          child: Text(
                            controlStatement(langCode, "Let's Go", "चल", "चला"),
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
                                border: Border.all(
                                    color: AppColors.Primary, width: 1),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  controlStatement(langCode,"Optimal Distance","इष्टतम दूरी","इष्टतम अंतर"),
                                  style: TextStyle(color: AppColors.black),
                                ),
                              )),
                          Container(
                              width: 150,
                              height: 75,
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: AppColors.Primary, width: 1),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  controlStatement(langCode,"Total Fare","कुल किराया","एकूण भाडे"),
                                  style: TextStyle(color: AppColors.black),
                                ),
                              )),
                          SizedBox(height: 20),
                          if (sourcestop != null)
                            Text(controlStatement(langCode,'Selected Bus Stop 1: ${sourcestop!.name}, Lat: ${sourcestop!.latitude}, Lng: ${sourcestop!.longitude}',"चयनित बस स्टॉप 1: ${sourcestop!.name}, अक्षांश: ${sourcestop!.latitude}, रेखांश: ${sourcestop!.longitude}","निवडलेला बस स्टॉप १: ${sourcestop!.name}, अक्षांश: ${sourcestop!.latitude}, रेखांश: ${sourcestop!.longitude}")),
                          if (destinationstop != null)
                            Text(controlStatement(langCode,'Selected Bus Stop 1: ${destinationstop!.name}, Lat: ${destinationstop!.latitude}, Lng: ${destinationstop!.longitude}',"चयनित बस स्टॉप 1: ${destinationstop!.name}, अक्षांश: ${destinationstop!.latitude}, रेखांश: ${destinationstop!.longitude}","निवडलेला बस स्टॉप १: ${destinationstop!.name}, अक्षांश: ${destinationstop!.latitude}, रेखांश: ${destinationstop!.longitude}")),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
