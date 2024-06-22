import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:onboard/core/constants/AppColors.dart';
import 'package:onboard/model/datasource/MapScreen.dart';
import 'package:onboard/model/model/BusStops.dart';

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
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      hintText: "Source",
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
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      hintText: "Destination",
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
                                border: Border.all(
                                    color: AppColors.Primary, width: 1),
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
                                border: Border.all(
                                    color: AppColors.Primary, width: 1),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Total Fare",
                                  style: TextStyle(color: AppColors.black),
                                ),
                              )),
                          SizedBox(height: 20),
                          if (sourcestop != null)
                            Text('Selected Bus Stop 1: ${sourcestop!.name}, '
                                'Lat: ${sourcestop!.latitude}, Lng: ${sourcestop!.longitude}'),
                          if (destinationstop != null)
                            Text(
                                'Selected Bus Stop 2: ${destinationstop!.name}, '
                                'Lat: ${destinationstop!.latitude}, Lng: ${destinationstop!.longitude}'),
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
