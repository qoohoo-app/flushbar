import 'dart:math';

import 'package:flushbar/flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
  ));
  runApp(FlushBarApp());
}

class FlushBarApp extends StatelessWidget {
  const FlushBarApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
                statusBarColor: Colors.transparent,
              ),
              title: Text('qoohoo'),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                final isGreen = Random().nextBool();

                final flushBar = FlushBar(
                  title: 'Woah',
                  isDismissible: true,
                  backgroundColor: isGreen ? Colors.red : Colors.green,
                  message: 'World is amazing',
                  actionsArrangement: FlushBarActionsArrangement.vertical,
                  // duration: Duration(seconds: 3),
                  flushBarPosition: FlushBarPosition.top,
                  flushBarStyle: FlushBarStyle.grounded,
                  actions: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: isGreen ? Colors.red.shade200 : Colors.green.shade200,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                100,
                              ),
                            ),
                          ),
                        ),
                        child: Text('Hello World'),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                100,
                              ),
                            ),
                          ),
                        ),
                        child: Text(
                          'Hello World',
                          style: TextStyle(
                            color: isGreen ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                    ],
                  ),
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
