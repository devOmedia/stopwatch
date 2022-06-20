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
    String lap = "$digitHours:$digitMinutes:$digitSeconds";
    print(lap);
    setState(() {
      laps.add(lap);
    });
  }

  //remove laps
  void removeLap(index) {
    setState(() {
      laps.removeAt(index);
    });
  }

  // start timer function

  void start() {
    started = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localSecond = seconds + 1;
      int localMinute = minutes;
      int localHour = hours;

      if (localSecond > 59) {
        if (localMinute > 59) {
          localHour++;
          localSecond = 0;
        } else {
          localMinute++;
          localSecond = 0;
        }
      }

      setState(() {
        seconds = localSecond;
        minutes = localMinute;
        hours = localHour;

        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHours = (hours >= 10) ? "$hours" : "0$hours";
      });
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
                      color: Color.fromARGB(255, 89, 106, 236),
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  Text(
                    '$digitHours:$digitMinutes:$digitSeconds',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 80.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                        color: Colors.indigo.shade600,
                        borderRadius: BorderRadius.circular(15.0)),
                    child: ListView.builder(
                      itemCount: laps.length,
                      itemBuilder: (context, index) {
                        return DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Lap ${index + 1}: "),
                                  Text(laps[index]),
                                  IconButton(
                                    onPressed: () {
                                      removeLap(index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {
                            (!started) ? start() : stop();
                          },
                          shape: const StadiumBorder(
                              side: BorderSide(
                            color: Colors.indigo,
                          )),
                          child: Text(
                            (!started) ? "Start" : "Pause",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          addLaps();
                        },
                        icon: const Icon(Icons.flag),
                        color: Colors.indigo,
                      ),
                      Expanded(
                        child: RawMaterialButton(
                          onPressed: () {
                            reset();
                          },
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
