import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int hours = 0, minutes = 0, seconds = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? timer;
  bool started = false;
  List laps = [];

  //stop timer function

  void stop() {
    timer!.cancel();

    setState(() {
      started = false;
    });
  }

  //restart function
  void reset() {
    timer!.cancel();

    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;

      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";

      started = false;
    });
  }

  //add laps
  void addLaps() {
    String lap = "$digitSeconds:$digitMinutes:$digitHours";
    setState(() {
      laps.add(lap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Flutter Stop Watch',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 38, 206),
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const Text(
                    '00:00:00',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade800,
                        borderRadius: BorderRadius.circular(15.0)),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {},
                          shape: const StadiumBorder(
                              side: BorderSide(
                            color: Colors.indigo,
                          )),
                          child: const Text(
                            "Start",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.flag),
                        color: Colors.indigo,
                      ),
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {},
                          fillColor: Colors.indigo,
                          shape: const StadiumBorder(),
                          child: const Text(
                            "Restart",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ]),
          ),
        ));
  }
}
