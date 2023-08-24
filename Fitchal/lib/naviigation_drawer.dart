import 'package:flutter/material.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/contacts.dart';
import 'package:flutter_app/dashboard.dart';
import 'package:flutter_app/events.dart';
import 'package:flutter_app/logout.dart';
import 'package:flutter_app/notes.dart';
import 'package:flutter_app/notifications.dart';
import 'package:flutter_app/privacy_policy.dart';
import 'package:flutter_app/send_feedback.dart';
import 'package:flutter_app/settings.dart';
//import 'package:flutter_app/dashboard.dart';
import 'drawer_item.dart';
import 'naviigation_drawer.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 80, 24, 0),
    child:SingleChildScrollView(
          child: Column(
            children: [
              headerWidget(),
              const SizedBox(height: 40,),
              const Divider(thickness: 1, height: 10, color: Colors.grey,),
              const SizedBox(height: 40,),
              DrawerItem(
                name: 'Dashboard',
                icon: Icons.dashboard_outlined,
                onPressed: ()=> onItemPressed(context, index: 0),
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Login',
                  icon: Icons.login_outlined,
                  onPressed: ()=> onItemPressed(context, index: 1)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Contacts',
                  icon: Icons.people_alt_outlined,
                  onPressed: ()=> onItemPressed(context, index: 2)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Events',
                  icon: Icons.event_busy_outlined,
                  onPressed: ()=> onItemPressed(context, index: 3)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Notes',
                  icon: Icons.notes,
                  onPressed: ()=> onItemPressed(context, index: 4)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Notifications',
                  icon: Icons.notifications_outlined,
                  onPressed: ()=> onItemPressed(context, index: 5)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Privacy Policy',
                  icon: Icons.privacy_tip_outlined,
                  onPressed: ()=> onItemPressed(context, index: 6)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Send Feedback',
                  icon: Icons.feedback_outlined,
                  onPressed: ()=> onItemPressed(context, index: 7)
              ),
              const SizedBox(height: 30,),
              const Divider(thickness: 1, height: 10, color: Colors.grey,),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Setting',
                  icon: Icons.settings,
                  onPressed: ()=> onItemPressed(context, index: 8)
              ),
              const SizedBox(height: 30,),
              DrawerItem(
                  name: 'Log out',
                  icon: Icons.logout,
                  onPressed: ()=> onItemPressed(context, index: 9)
              ),

            ],
          ),
    ),
        ),
      ),
    );
  }

  void onItemPressed(BuildContext context, {required int index}){
    Navigator.pop(context);

    switch(index){
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  DashboardPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: '',)));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  ContactsPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  EventsPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotesPage()));
        break;
      case 5:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  NotificationsPage()));
        break;
      case 6:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  PrivacyPolicyPage()));
        break;
      case 7:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  SendFeedbackPage()));
        break;
      case 8:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  SettingsPage()));
        break;
      case 9:
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  LogoutPage()));
        break;



    }
  }

  Widget headerWidget() {
    const url = 'https://unsplash.com/s/photos/gym';
    return Row(
      children: [
        const CircleAvatar(
          radius: 40,
          backgroundImage: NetworkImage(url),
        ),
        const SizedBox(width: 20,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Fitness Challenge', style: TextStyle(fontSize: 14, color: Colors.white)),
            SizedBox(height: 10,),
            Text('fitgymchal@email.com', style: TextStyle(fontSize: 14, color: Colors.white))
          ],
        )
      ],
    );

  }
}




