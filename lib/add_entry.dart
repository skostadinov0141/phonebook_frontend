import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEntryField extends StatefulWidget {

  VoidCallback callback;

  AddEntryField({Key? key,
  required this.callback
  }) : super(key: key);

  @override
  State<AddEntryField> createState() => _AddEntryFieldState();
}

class _AddEntryFieldState extends State<AddEntryField> {
  @override
  Widget build(BuildContext context) {

    String nameInput = "";
    String addressInput = "";
    String phoneNumberInput = "";

    TextEditingController controller1 = TextEditingController();
    TextEditingController controller2 = TextEditingController();
    TextEditingController controller3 = TextEditingController();

    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller1,
              onChanged: (value) => nameInput = value,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                label: Text(
                  'Name',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueGrey.shade300
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blueGrey.shade500
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            )
          ),
          SizedBox(width: 20,),
          Expanded(
            child: TextField(
              controller: controller2,
              onChanged: (value) => addressInput = value,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                label: Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueGrey.shade300
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blueGrey.shade500
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            )
          ),
          SizedBox(width: 20,),
          Expanded(
            child: TextField(
              controller: controller3,
              onChanged: (value) => phoneNumberInput = value,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
              ),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(20),
                label: Text(
                  'Phone number',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.blueGrey.shade300
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.blueGrey.shade500
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                )
              ),
            )
          ),
          SizedBox(width: 20,),
          Expanded(
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                  )
                ),
                overlayColor: MaterialStateProperty.all(Colors.white30)
              ),
              onPressed: () {
                AddEntry(nameInput, addressInput, phoneNumberInput);
                controller1.clear();
                controller2.clear();
                controller3.clear();
                widget.callback();
              }, 
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Add to Database',
                  style: TextStyle(
                    fontSize: 25
                  ),
                ),
              )
            ),
          )
        ],
      ),
    );
  }
}

void AddEntry(String name, String address, String phoneNumber){
  http.post(
    Uri.parse('https://127.0.0.1:8000/create_phonebook_entry'),
    headers: {
      "accept" : "application/json",
      "Content-Type" : "application/json"
    },
    body: jsonEncode({
      "name" : name,
      "address" : address,
      "phoneNumber" : phoneNumber
    })
  );
}