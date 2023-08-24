import 'package:flutter/material.dart';
import 'package:flutter_app/naviigation_drawer.dart';
import 'package:flutter_app/update.dart';
import 'package:flutter_app/upload.dart';
import 'package:flutter_app/view.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: Builder(
            builder: (context) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(   //Use of SizedBox
                      height: 50,
                    ),


                    RaisedButton(

                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewChallenge1()));
                      },
                      child: Text("VIEW CHALLENGE"),
                    ),
                    const SizedBox(height: 30,),
                    RaisedButton(
                      onPressed: () {
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => NewChallenge()));
                      },
                      child: Text("CREATE CHALLENGE"),
                    ),
                    const SizedBox(height: 30,),

                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NewChallenge()));
                      },
                      child: Text("UPDATE CHALLENGE"),
                    ),
                    const SizedBox(height: 30,),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DietChallenge()));
                      },
                      child: Text("UPLOAD DIET PLAN"),
                    ),

                  ],
                )

              );
            }
        )
    );
  }
}

