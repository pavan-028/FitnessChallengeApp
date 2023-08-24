import 'dart:async';
import 'dart:typed_data';
import 'dart:io';
//import 'dart:js';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:open_file/open_file.dart';
import 'package:flutter/material.dart';
import 'package:azblob/azblob.dart';
import 'package:http/http.dart'as http ;
import 'dart:convert';
//import 'package:image_picker/image_picker.dart';
//import 'package:mime/mime.dart';



class DietChallenge extends StatefulWidget{
  @override
  _DietState createState() => _DietState();
}


class _DietState extends State<DietChallenge> {



  final TextEditingController dietuploadcnt = TextEditingController();
  final TextEditingController participantcnt = TextEditingController();
  final TextEditingController guidecnt = TextEditingController();


  Future<http.Response> createChallenge(String upload,String participant,String guide ) {
    print("submit button click");
    var uridata= 'https://subchallenge.azurewebsites.net/api/chal/create/'+ Uri.encodeComponent(upload)+'/'+Uri.encodeComponent(participant)+'/'+Uri.encodeComponent(guide)+'?code=Fc97yJT41E8ylnEUSWU%2Fz0QY3g3nKE2k1fUarBea7xn5aNyXQEtaZg%3D%3D';
    print(uridata);
    return http.post(

      Uri.parse(uridata),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'upload': upload,

      }),

    );

  }


  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("DIET PLAN"),
        ),
        body: Container(
          constraints: BoxConstraints(maxWidth: 600),
          padding: EdgeInsets.all(32),
          alignment: Alignment.topCenter,
          child:SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(   //Use of SizedBox
                  height: 20,
                ),

                ElevatedButton(child: Text('Upload Diet Plan'),
                  onPressed: () async {
                    final result = await FilePicker.platform.pickFiles();
                    if (result == null) return;
                    final file = result.files.first;
                    String? filepath=file.path;
                    if(filepath!=null) {

                      File toUpload = File(filepath);
                      print(toUpload.readAsBytesSync());
                      try {
                        //String fileName = basename(_imageFile.path);
                        // read file as Uint8List
                        Uint8List? contentWithNull = toUpload.readAsBytesSync();
                        if (contentWithNull != null) {
                          Uint8List content = contentWithNull;


                          print(contentWithNull);
                          var storage = AzureStorage.parse(
                              'DefaultEndpointsProtocol=https;AccountName=fitchalstorage;AccountKey=6WMDi4S1jT6waaBITqE04NP2sJxx2iMEZKo1Elbj8dlmmE6hFzIRIThldEPJLEm63AvHU3TwDjH9+ASt1nR+PQ==;EndpointSuffix=core.windows.net');
                          String container = "image";
                          // get the mine type of the file
                          //String contentType= lookupMimeType(fileName);
                          await storage.putBlob(
                              '/dietplans/two', bodyBytes: content,
                              contentType: 'image/png');
                          print("done");
                        }
                      }
                      on AzureStorageException catch (ex) {
                        print(ex.message);
                      } catch (err) {
                        print(err);
                      }


                    }
                    openFile(file);

                   // filesave(file);


                  },



                ),



                SizedBox(   //Use of SizedBox
                  height: 100,
                ),


                //(Dietcontroller.value.text.isEmpty) ? Text("Please Enter Participants") : Text("submit: ${Dietcontroller.value.text}"),
                Padding(padding: const EdgeInsets.all(10.0),

                  child: TextField(
                   // controller: participantcnt,

                    keyboardType: TextInputType.multiline,

                    decoration: InputDecoration(

                        hintText: 'Enter Participants',
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )

                    ),
                    maxLines: null,
                  ),

                ),

                Padding(padding: const EdgeInsets.all(10.0),

                  child: TextField(
                    //controller: guidecnt,

                    keyboardType: TextInputType.multiline,

                    decoration: InputDecoration(

                        hintText: 'Enter guide',
                        hintStyle: TextStyle(
                            color: Colors.grey
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        )
                    ),



                    maxLines: null,

                  ),

                ),

                ElevatedButton(onPressed: (){
                 // dietuploadcnt.notifyListeners();
                  ScaffoldMessenger.of(context).showSnackBar(

                    const SnackBar(content: Text('Challenge Has Been Accepted')),
                  );
                }, child: Text("Submit"),
                )


              ],


            ),
          ),
        ),


      ),
    );
  }

  /*
  void filesave(var file) async {
    print('enter file ');
    print(file);
   // Uint8List bytes = file.readAsBytesSync();
    var storage = AzureStorage.parse(
        'DefaultEndpointsProtocol=https;AccountName=fitchalstorage;AccountKey=6WMDi4S1jT6waaBITqE04NP2sJxx2iMEZKo1Elbj8dlmmE6hFzIRIThldEPJLEm63AvHU3TwDjH9+ASt1nR+PQ==;EndpointSuffix=core.windows.net');


   await storage.putBlob(dietplans/,

      body: file.path,
      contentType: 'image/png',);



  }

   */

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);

  }
}

