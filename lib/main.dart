import 'package:flutter/material.dart';
import 'add_entry.dart';
import 'entry_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Phonebook',
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 14, 36, 46),
                Color.fromARGB(255, 22, 52, 66),
                Color.fromARGB(255, 28, 68, 87),
              ]
            )
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 200,vertical: 100),
            child: InteractiveArea()
          ),
        ),
      ),
    );
  }
}

class InteractiveArea extends StatefulWidget {
  InteractiveArea({Key? key}) : super(key: key);

  @override
  State<InteractiveArea> createState() => _InteractiveAreaState();
}

class _InteractiveAreaState extends State<InteractiveArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 1,
            child: AddEntryField(
              callback: () {
                setState(() {});
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: EntryList(),
          )
        ],
      ),
    );
  }
}