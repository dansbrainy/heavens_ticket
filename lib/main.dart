import 'dart:core';
import 'dart:html';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

import 'package:flutter/material.dart';
import 'package:heavens_ticket/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class Ticket {
  const Ticket({this.name, this.description, this.price, this.imageUrl});

  final String name;
  final String description;
  final double price;
  final String imageUrl;
}

final List<Ticket> _tickets = <Ticket>[
  Ticket(
      name: 'Mars Ride',
      description: 'Ride for 140 days on Mars',
      price: 28000,
      imageUrl:
          'https://photojournal.jpl.nasa.gov/jpegMod/PIA24266_modest.jpg'),
  Ticket(
      name: 'Venus Ride',
      description: 'Ride for 180 days on Venus',
      price: 38000,
      imageUrl:
          'https://solarsystem.nasa.gov/system/resources/detail_files/775_PIA00271_detail.jpg'),
];

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.lightBlue,
          buttonColor: Colors.lightBlue,
          buttonTheme: const ButtonThemeData(
              textTheme: ButtonTextTheme.primary, padding: EdgeInsets.all(20))),
      // theme: ThemeData(
      //     primarySwatch: Colors.purple, accentColor: Colors.blueAccent),
      // home: Splash(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Ticket ticket;
  var totalCost = 0;

  // void changeVariableOnUI() {
  //   setState(() => totalCost = 22);
  // }

  Widget _dialogBuilder(BuildContext context, Ticket ticket) {
    ThemeData localTheme = Theme.of(context);

    return SimpleDialog(contentPadding: EdgeInsets.zero, children: [
      Image.network(
        ticket.imageUrl,
        fit: BoxFit.fill,
      ),
      Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              ticket.name,
              style: localTheme.textTheme.headline4,
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              'R ${ticket.price} all the way!',
              style: localTheme.textTheme.subtitle1.copyWith(
                fontStyle: FontStyle.normal,
              ),
            ),
            SizedBox(
              height: 18.0,
            ),
            Text(
              ticket.description,
              style: localTheme.textTheme.bodyText1,
            ),
            SizedBox(
              height: 18.0,
            ),
            // TextField(
            //   autofocus: true,
            //   textCapitalization: TextCapitalization.words,
            //   decoration: InputDecoration(
            //     hintText: 'Enter The No of People',
            //   ),
            //   onChanged: (text) {
            //     // changeVariableOnUI();
            //     totalCost = (int.parse(text) + ticket.price) as int;
            //     setState(
            //         () => totalCost = (int.parse(text) + ticket.price) as int);
            //     print(totalCost);
            //   },
            // ),
            // SizedBox(
            //   height: 18.0,
            // ),
            Text('Your Total Cost is: $totalCost'),
            SizedBox(
              height: 18.0,
            ),
            Align(
              alignment: Alignment.center,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  TextButton(
                    autofocus: true,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('CANCEL'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('BUY TICKET'),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    ]);
  }

  Widget _listItemBuilder(BuildContext context, int index) {
    // final Color? hoverColor;

    return new GestureDetector(
        onTap: () => showDialog(
            context: context,
            builder: (context) => _dialogBuilder(context, _tickets[index])),
        child: Container(
            padding: const EdgeInsets.all(18.0),
            alignment: Alignment.center,
            child: Text(_tickets[index].name,
                style: Theme.of(context).textTheme.headline4)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Heaven's Ticket"),
        foregroundColor: Colors.black,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        // color: Color(0xff258DED),
        // alignment: Alignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30.0,
                    ),
                    Text(
                        // ticket.name,
                        // style: localTheme.textTheme.headline4,
                        "Enter The Number of People"),
                    SizedBox(
                      height: 18.0,
                    ),
                    TextField(
                      autofocus: true,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                        hintText: 'No of People',
                      ),
                      onChanged: (text) {
                        // changeVariableOnUI();
                        totalCost = (int.parse(text) + ticket.price) as int;
                        setState(() => totalCost =
                            (int.parse(text) + ticket.price) as int);
                        print(totalCost);
                      },
                    ),
                    SizedBox(
                      height: 48.0,
                    ),
                    Text('Select a Ticket'),
                    SizedBox(
                      height: 8.0,
                    ),
                  ])),
          ListView.builder(
            itemCount: _tickets.length,
            itemExtent: 80.0,
            itemBuilder: _listItemBuilder,
            shrinkWrap: true,
          )
          //all the children widgets that you need
        ],
      ),
    );
  }
}
