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


class NewChallenge extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<NewChallenge> {
  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now() ;
  final formKey = GlobalKey<FormState>(); //key for form
  String name="";
  TextEditingController challNameCnt = new TextEditingController();
  TextEditingController challDesCnt = new TextEditingController();
  TextEditingController challPartCnt = new TextEditingController();
  TextEditingController challGuideCnt = new TextEditingController();
  //TextEditingController challStartCnt = new TextEditingController();
  //TextEditingController challEndCnt = new TextEditingController();



  Future<http.Response> createChallenge(String name,String desc,String guide,String part,DateTime start,DateTime end ) {
    print("submit button click");
    var uridata= 'https://subchallenge.azurewebsites.net/api/chal/create/'+ Uri.encodeComponent(name)+'/'+Uri.encodeComponent(desc)+'/'+Uri.encodeComponent(guide)+'/'+Uri.encodeComponent(part)+'/'+Uri.encodeComponent(start.toString())+'/'+Uri.encodeComponent(end.toString())+'?code=Fc97yJT41E8ylnEUSWU%2Fz0QY3g3nKE2k1fUarBea7xn5aNyXQEtaZg%3D%3D';
    print(uridata);
    return http.post(

      Uri.parse(uridata),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,

      }),

    );

  }


  @override
  Widget build(BuildContext context) {
    final double height= MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return  Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, //key for form
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height:height*0.04),
                  Text("NEW CHALLENGE", style: TextStyle(fontSize: 50, color:Color(0xFF363f93)),),
                  // Text("Welcomed !", style: TextStyle(fontSize: 30, color:Color(0xFF363f93)),),





                  SizedBox(height: height*0.05,),
                  TextFormField(
                    controller: challNameCnt,
                    decoration: InputDecoration(
                        labelText: "Challenge Name"
                    ),
                    validator: (value){
                      if(value!.isEmpty || !RegExp(r"^[a-z A-Z 0-9 \ ]+$").hasMatch(value!)){
                        //|| !RegExp(r'^[A-Z]+$').hasMatch(value!)
                        return "Enter Correct Challenge Name";
                      }
                      else{
                        return null;
                      }
                    },
                  ),

                  SizedBox(height: height*0.05,),
                  TextFormField(
                    controller: challDesCnt,
                    decoration: InputDecoration(
                        labelText: "Challenge Description"
                    ),
                    validator: (value){
                      if(value!.isEmpty|| !RegExp(r'^[a-z A-Z 0-9 \ ]+$').hasMatch(value!) ){
                        //|| !RegExp(r'^[A-Z]+$').hasMatch(value!)
                        return "Enter Correct Description";
                      }
                      else{
                        return null;
                      }
                    },
                  ),



                  SizedBox(height: height*0.05,),
                  TextFormField(
                    controller: challPartCnt,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        labelText: "Challenge Participants"
                    ),
                    validator: (value){
                      if(value!.isEmpty|| !RegExp(r'^[a-z A-Z 0-9 \ ]+$').hasMatch(value!) ){
                        //|| !RegExp(r'^[A-Z]+$').hasMatch(value!)
                        return "Enter Correct Participants";
                      }
                      else{
                        return null;
                      }
                    },
                    maxLines: null,
                  ),






                  SizedBox(height: height*0.05,),
                  TextFormField(
                    controller: challGuideCnt,
                    decoration: InputDecoration(
                        labelText: "Challenge Guide"
                    ),
                    validator: (value){
                      if(value!.isEmpty|| !RegExp(r'^[a-z A-Z 0-9 \ ]+$').hasMatch(value!) ){
                        //|| !RegExp(r'^[A-Z]+$').hasMatch(value!)
                        return "Enter Correct Guide";
                      }
                      else{
                        return null;
                      }
                    },
                  ),



                  SizedBox(height: height*0.05,),

                  Text(

                    '${date.day}/${date.month}/${date.year}',
                    style : TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height : 16),

                  ElevatedButton(

                    child: Text('Start Date'),
                    onPressed: () async {
                      DateTime? startDate = await showDatePicker(context: context,
                        initialDate: date,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      //  controller: challStartCnt;
                      if(startDate == null) return;

                      setState(() => date = startDate);
                    },

                  ),

                  SizedBox(height: height*0.05,),
                  Text(
                    '${date1.day}/${date1.month}/${date1.year}',
                    style : TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height : 16),
                  ElevatedButton(
                    child: Text('End Date'),
                    onPressed: () async {
                      DateTime? newDate = await showDatePicker(context: context,
                        initialDate: date1,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100),
                      );
                      if(newDate == null) return;

                      setState(() => date1 = newDate);
                    },
                  ),



                  SizedBox(height: height*0.05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        print("submit button click");

                        // var res = createChallenge(challNameCnt.text,challDesCnt.text,challGuideCnt.text,challPartCnt.text,date,date1);


                        // print(res);
                        // createChallenge(challDesCnt.text);

                        if (formKey.currentState!.validate()) {
                          var res = createChallenge(challNameCnt.text,challDesCnt.text,challGuideCnt.text,challPartCnt.text,date,date1);
                          ScaffoldMessenger.of(context).showSnackBar(

                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),

                  SizedBox(height: height*0.05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back To Home'),
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }


}