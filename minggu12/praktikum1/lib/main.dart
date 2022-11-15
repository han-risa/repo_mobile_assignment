// ignore_for_file: unused_field, prefer_final_fields, unused_element, avoid_unnecessary_containers, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _inputuser = 0;
  double _kevin = 0;
  double _reamur = 0;
  final inputController = TextEditingController();
  String newValue = "Kelvin";
  double _result = 0;
  String changeValue = "";
  double _value = 1;
  int _currentSliderValue = 1;
  TextEditingController sliderController = TextEditingController();

  List<String> listViewItem = <String>[];

  var listItem = [
    "Kelvin",
    "Reamur",
  ];
  void perhitunganSuhu() {
    String satuan, hasil;
    setState(() {
      _inputuser = _value;
      if (newValue == "Kelvin") {
        _result = _inputuser + 273;
        satuan = "Kelvin";
      } else {
        _result = (4 / 5) * _inputuser;
        satuan = "Reamur";
      }
    });
    hasil = (newValue + " : " + _result.toString());
    listViewItem.add(hasil);
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Input(
              myController: sliderController,
            ),
            Container(
              child: Slider(
                  value: _value.round().toDouble(),
                  min: 1.0,
                  max: 100.0,
                  divisions: 100,
                  activeColor: Colors.blue,
                  inactiveColor: Colors.black,
                  label: _value.round().toString(),
                  onChanged: (double newValue) {
                    setState(() {
                      _value = newValue;
                      sliderController.text = _value.round().toString();
                      print(_value);
                    });
                    perhitunganSuhu();
                  }),
            ),
            Container(
              child: DropdownButton<String>(
                  items: listItem.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),

                  /*
                [
                DropdownMenuItem(
                  value: "Kelvin" , child: Container(child: Text("Kelvin"),),),
                DropdownMenuItem(
                  value: "Reamur", child: Container(child: Text("Reamur"),),)
              ],
              */
                  value: newValue,
                  onChanged: (String? changeValue) {
                    setState(() {
                      newValue = changeValue!;
                      perhitunganSuhu();
                    });
                  }),
            ),
            Result(
              result: _result,
            ),
            SizedBox(
              child: Container(
                  child: Convert(
                konvertHandler: perhitunganSuhu,
              )),
            ),
            Container(child: Text("Riwayat Konversi")),
            Expanded(
                child: ListView(
              children: listViewItem.map((String value) {
                return Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 15),
                    ));
              }).toList(),
            )),
            //
          ],
        ),
      ),
    );
  }
}

class Convert extends StatelessWidget {
  const Convert({
    Key? key,
    required this.konvertHandler,
  }) : super(key: key);

  final Function konvertHandler;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
      onPressed: () {
        konvertHandler();
      },
      child: Text(
        "Konversi Suhu",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class Input extends StatelessWidget {
  const Input({
    Key? key,
    required this.myController,
  }) : super(key: key);

  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      decoration: InputDecoration(hintText: "Masukkan Nilai "),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly,
      ],
      keyboardType: TextInputType.number,
    );
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.result,
  }) : super(key: key);

  final double result;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "Hasil",
            style: TextStyle(fontSize: 20),
          ),
          Text(
            result.toStringAsFixed(1),
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
