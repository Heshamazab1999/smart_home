import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  // final imgPath;
  // late Map<String, dynamic> dht11;
  // late Map<String, dynamic> smoke;
  DetailPage({
    Key? key,
  }) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool tempValue = false;
  DatabaseReference dht11tRef = FirebaseDatabase.instance.ref('DHT11/current');
  DatabaseReference lightRef = FirebaseDatabase.instance.ref('Light/current');
  DatabaseReference intrusionRef =
      FirebaseDatabase.instance.ref('intrusion/current');
  DatabaseReference smokeRef = FirebaseDatabase.instance.ref('smoke/current');

  Map<String, dynamic> _light = <String, dynamic>{};
  Map<String, dynamic> _dht11 = <String, dynamic>{};
  Map<String, dynamic> _intrusion = <String, dynamic>{};
  Map<String, dynamic> _smoke = <String, dynamic>{};
  late StreamSubscription<DatabaseEvent> _dht11Subscription;
  late StreamSubscription<DatabaseEvent> _lightSubscription;
  late StreamSubscription<DatabaseEvent> _intrusionSubscription;
  late StreamSubscription<DatabaseEvent> _smokeSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> init() async {
    _dht11Subscription = dht11tRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        final data = event.snapshot.value;
        Map<String, dynamic> dht11 = Map<String, dynamic>.from(data as Map);
        _dht11 = dht11;
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        //_error = error;
      });
    });
    _lightSubscription = lightRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        final data = event.snapshot.value;
        Map<String, dynamic> light = Map<String, dynamic>.from(data as Map);
        print(light);
        _light = light;
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        //_error = error;
      });
    });
    _intrusionSubscription = intrusionRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        final data = event.snapshot.value;
        Map<String, dynamic> intrusion = Map<String, dynamic>.from(data as Map);
        _intrusion = intrusion;
        _checkIfIntrusion(_intrusion["intrusion_alert"]);
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        //_error = error;
      });
    });
    _smokeSubscription = smokeRef.onValue.listen((DatabaseEvent event) {
      setState(() {
        final data = event.snapshot.value;
        Map<String, dynamic> smoke = Map<String, dynamic>.from(data as Map);

        _smoke = smoke;
      });
    }, onError: (Object o) {
      final error = o as FirebaseException;
      setState(() {
        //_error = error;
      });
    });
  }

  _checkIfIntrusion(var value) async {
    // the method below returns a Future
    if (value == 1) {
      _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    // set up the buttons
    Widget remindButton = TextButton(
      child: const Text("Ignore"),
      onPressed: () {},
    );
    Widget cancelButton = TextButton(
      child: const Text("Security Alert"),
      onPressed: () {},
    );
    Widget launchButton = const TextButton(
      child: Text("Launch missile"),
      onPressed: null,
    );
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Column(
                children: const [
                  Icon(
                    Icons.dangerous,
                    size: 100,
                    color: Colors.red,
                  ),
                  Text("Intrusion Detected"),
                ],
              ),
              content: const Text("Individual nonnative entered the house."),
              actions: [
                remindButton,
                cancelButton,
                launchButton,
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/living.webp"),
                    fit: BoxFit.cover)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const Spacer(),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/image.jpg'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 15)
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 340,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Color.fromRGBO(32, 90, 217, 1.0),
                ),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        listItemStats(
                            'assets/images/creative.png', "6 Lights", true),
                        listItemStats('assets/images/air-conditioner.png',
                            "Air Conditioner", false),
                        listItemStats('assets/images/washing-machine.png',
                            "Washing Machine", false)
                      ],
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                        child: Divider(
                          color: Colors.white,
                        )),
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Temperature",
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            _dht11["Temperature"].toString() + " °C",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Humidity",
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            _dht11["Humidity"].toString() + "%",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Smoke Level",
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          Text(
                            _smoke["Smoke"].toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                        child: Divider(
                          color: Colors.white,
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 10),
                      child: Row(
                        children: <Widget>[
                          const Text(
                            "Day Schedule",
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          Switch(
                            value: tempValue,
                            onChanged: (newVal) {
                              setState(() {
                                tempValue = newVal;
                                print(newVal);
                              });
                            },
                            activeColor: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Widget listItemStats(String imgpath, String name, bool value) {
    return Container(
      width: 110,
      height: 150,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: value == true
              ? Colors.white
              : const Color.fromRGBO(20, 135, 186, 1.0)),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20),
          Image(
              image: AssetImage(imgpath),
              width: 45,
              height: 45,
              color: value == true ? Colors.black : Colors.white),
          const SizedBox(height: 15),
          Text(name,
              style: TextStyle(
                  fontSize: 13,
                  color: value == true ? Colors.black : Colors.white)),
          const SizedBox(height: 5),
          Switch(
            value: value,
            onChanged: (newVal) {
              setState(() {
                value = newVal;
                print(newVal);
              });
            },
            activeColor: Colors.blue,
          )
        ],
      ),
    );
  }
}
