import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

var intryId = -1;
var temp;
var hum;
var colevel;

void main() {
  runApp(MinorApp());
}

class MinorApp extends StatefulWidget {
  @override
  _MinorAppState createState() => _MinorAppState();
}

class _MinorAppState extends State<MinorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueGrey[200],
        appBar: AppBar(
          title: Text("Minor Project"),
          backgroundColor: Colors.blueGrey[700],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Text(
                "Weather Monitoring System",
                style: TextStyle(fontSize: 40.0),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
              child: Text(
                "CURRENT DATA",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.wb_sunny,
                        size: 60.0,
                        color: Colors.yellow,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Temperature",
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Text(
                            "$temp°",
                            style: TextStyle(fontSize: 50.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.opacity,
                        size: 60.0,
                        color: Colors.blue,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Humidity",
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Text(
                            "$hum%",
                            style: TextStyle(fontSize: 50.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.cloud,
                        size: 60.0,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "CO Level",
                            style: TextStyle(fontSize: 30.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: <Widget>[
                              Text(
                                "$colevel",
                                style: TextStyle(fontSize: 50.0),
                              ),
                              Text(
                                "PPM",
                                style: TextStyle(fontSize: 20.0),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            FlatButton(
              padding: EdgeInsets.only(left: 0.0),
              onPressed: () {
                if (intryId <= 12) {
                  intryId++;
                  setState(() {
                    getData();
                  });
                } else {
                  intryId = 0;
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 75.0),
                color: Colors.blueGrey,
                width: double.infinity,
                height: 80.0,
                child: Center(
                  child: Text(
                    "UPDATE NOW",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void getData() async {
  Response response = await get(
      "http://api.thingspeak.com/channels/920193/feed.json?api_key=BJQWU3KUQAT7C8Q9");
  //print(response.body.[channel]);
  String data = response.body;
  var decodedData = jsonDecode(data);
  var temper = decodedData["feeds"][intryId]["field1"];
  var humid = decodedData["feeds"][intryId]["field2"];
  var colevelty =
      decodedData["feeds"][intryId]["field3"].replaceAll("\r\n", "");
  temp = temper;
  hum = humid;
  colevel = colevelty;
}
