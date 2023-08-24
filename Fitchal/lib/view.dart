import 'dart:async';
import 'dart:typed_data';
//import 'dart:io';
//import 'dart:js';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:azblob/azblob.dart';
import 'package:http/http.dart'as http ;
import 'dart:convert';

class NewChallenge1 extends StatefulWidget{
  @override
  _ViewState createState() => _ViewState();
}

class Challenge {
  final String name;
  final String startdate;
  final String enddate;
  final String guide;
  final String description;
  final String participant;

  const Challenge({
    required this.name,
    required this.startdate,
    required this.enddate,
    required this.guide,
    required this.description,
    required this.participant,
  });

  factory Challenge.fromJson( Map<String, dynamic> json) {
    print('converting to json');
    return Challenge(
        name: json['name'],
        startdate: json['start_date'],
        enddate: json['end_date'],
        guide: json['guide'],
        description: json['description'],
        participant: json['part']
    );
  }
}




class _ViewState extends State<NewChallenge1> {
  // get futureChallenge => null;

  late Future<List<Challenge>> futureChallenge;

  @override
  void initState() {
    super.initState();
    // List <String > chalList1=fetchChallenge();
    futureChallenge = fetchChallenge();
    print(futureChallenge);
  }



  //final formKey = GlobalKey<FormState>(); //key for form

  Future<List <Challenge>> fetchChallenge() async {
    print('called futureChallenge');
    final response = await http
        .get(Uri.parse('https://getchallenge.azurewebsites.net/api/chal/list'));
    print('testing');
    if (response.statusCode == 200) {
      //  List <String > jsonfirst=jsonDecode(response.body);
      // print(jsonfirst[0]);
      // print(jsonDecode(response.body));
      // If the server did return a 200 OK response,
      // then parse the JSON.
      // var chalsFromJsonp = fromJson[response.body];
      final jsonresponse = json.decode(response.body) as List<dynamic>;
      //Map<String , dynamic> chalsList = new Map< String ,dynamic>.from(chalsFromJson);
      // Map<String, dynamic> m1=json.(response.body);
      print(jsonresponse);
      return  jsonresponse.map((e) => Challenge.fromJson(e)).toList();
      //Challenge.fromJson(jsonresponse);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }






  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIEW CHALLENGES',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('VIEW CHALLENGES'),
        ),
        body: Center(
          child: FutureBuilder<List<Challenge>>(
            future: futureChallenge,

            builder: (context, snapshot) {
              print(snapshot.toString());
              print('testing3');
              if (snapshot.hasData) {
                var items = snapshot.data as List<Challenge>;
                print('testing4');
                //return Text(snapshot.data.toString());
                return ListView.builder(
                    itemCount: items == null? 0: items.length,
                    itemBuilder: (context,index){
                      return Card(
                        elevation: 5,
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 50,
                                height: 50,
                                //   child: Image(image: NetworkImage(items[index].guide.toString()),fit: BoxFit.fill,),
                              ),
                              Expanded(child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].name.toString(),style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                    ),),),

                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].startdate.toString()),),
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].enddate.toString()),),
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].guide.toString()),),
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8),child: Text(items[index].description.toString()),),
                                    Padding(padding: EdgeInsets.only(left: 8,right: 8), child: Text(items[index].participant.toString()),),

                                    RaisedButton(
                                      onPressed: () {
                                        //Navigator.push(context, MaterialPageRoute(builder: (context) => NewChallenge()));
                                        ScaffoldMessenger.of(context).showSnackBar(

                                          const SnackBar(content: Text('Challenge Has Been Accepted')),
                                        );
                                      },
                                      child: Text("ACCEPT CHALLENGE"),
                                    ),




                                  ],

                                ),


                              ))

                            ],

                          ),

                        ),

                      );
                    }
                );
              } else if (snapshot.hasError) {
                print('testing5');
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }




}
