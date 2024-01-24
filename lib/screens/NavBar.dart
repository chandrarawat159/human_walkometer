import 'package:flutter/material.dart';
import 'package:humanwalkometer_app/screens/exit.dart';
import 'package:humanwalkometer_app/screens/gpslocation.dart';
//import 'package:humanwalkometer_app/main.dart';

//import 'package:humanwalkometer_app/screens/screens.dart';
import 'package:humanwalkometer_app/screens/compass.dart';



class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Hari bdr'),
            accountEmail: Text('hari@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/navbar.jpg',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                      'assets/images/navbar.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('हाम्रो बारेमा '),
            
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('जीपीएस नक्सा'),
            onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (contect)=> MyApp(),),),
          ),
          
          ListTile(
            leading: Icon(Icons.directions),
            title: Text('कमपास'),
            onTap:()=> Navigator.of(context).push(
                      MaterialPageRoute(builder: (contect)=> Compass(),),),
            
            
            //onTap: () => null,
          ),
          
          // Divider(),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => null,
          // ),
          
          Divider(),
          ListTile(
            title: Text('लग आउट '),
            leading: Icon(Icons.exit_to_app),
            onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (contect)=> exited(),),),
          ),
        ],
      ),
    );
  }
}