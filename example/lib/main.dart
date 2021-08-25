import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(FlushbarApp());
}

class FlushbarApp extends StatelessWidget {
  const FlushbarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: Text('qoohoo'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final flushBar = Flushbar(
                  title: 'Woah',
                  isDismissible: true,
                  backgroundColor: Random().nextBool() ? Colors.red : Colors.green,
                  message: 'World is amazing',
                  duration: Duration(seconds: 3),
                  flushbarPosition: FlushbarPosition.TOP,
                  flushbarStyle: FlushbarStyle.GROUNDED,
                );

                flushBar.show(context);
              },
              backgroundColor: Colors.black,
              child: Icon(
                Icons.notifications_on_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
