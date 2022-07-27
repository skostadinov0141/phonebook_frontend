import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EntryList extends StatefulWidget {
  const EntryList({Key? key}) : super(key: key);

  @override
  State<EntryList> createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 1,
          color: Colors.blueGrey.shade500
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 30,
            color: Colors.blueGrey.shade500,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20,),
                Expanded(child: Text("Name", style: TextStyle(color: Colors.blueGrey.shade100),)),
                Expanded(child: Text("Address", style: TextStyle(color: Colors.blueGrey.shade100),)),
                Expanded(child: Text("Phone number", style: TextStyle(color: Colors.blueGrey.shade100),)),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: getEntries(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if(snapshot.hasData == true){
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    itemBuilder: (context, index) {
                      return EntryListElement(
                        name: snapshot.data![index]["name"], 
                        address: snapshot.data![index]["address"], 
                        phoneNumber: snapshot.data![index]["phoneNumber"]
                      );
                    }, 
                    separatorBuilder: ((context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: 1,
                          color: Colors.blueGrey.shade700,
                        ),
                      );
                    }), 
                    itemCount: getEntryListLength(snapshot.data!),
                  );
                }
                else if(snapshot.hasError){
                  return Text(snapshot.error.toString());
                }else{
                  return Center(
                    child: Container(
                      width: 50,
                      height: 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(child: CircularProgressIndicator()),
                          Container(
                            height: 20,
                            child: Text(
                              "Fetching data...",
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    )
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class EntryListElement extends StatelessWidget {

  final String name;
  final String address;
  final String phoneNumber;

  const EntryListElement({Key? key,
  required this.name,
  required this.address,
  required this.phoneNumber
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20,),
          Expanded(child: Text(name, style: TextStyle(color: Colors.white, fontSize: 20),)),
          Expanded(child: Text(address, style: TextStyle(color: Colors.white, fontSize: 20),)),
          Expanded(child: Text(phoneNumber, style: TextStyle(color: Colors.white, fontSize: 20),)),
        ],
      ),
    );
  }
}

Future<List<dynamic>> getEntries() async {
  http.Response res = await http.get(
    Uri.parse("https://127.0.0.1:8000/get_phonebook_entries"),
    headers: {
      "accept" : "application/json",
    }
  );
  Map<dynamic,dynamic> responseDecoded = jsonDecode(utf8.decode(res.bodyBytes));
  return responseDecoded["data"];
}

int getEntryListLength(List<dynamic> data){
  return data.length;
}