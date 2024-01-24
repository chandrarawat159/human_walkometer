import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:humanwalkometer_app/screens/screens.dart';
import 'package:humanwalkometer_app/services/authservice.dart';
import '../pallete.dart';
import '../widgets/widgets.dart';
import 'package:dio/dio.dart';


class Home extends StatelessWidget {
  Dio dio = Dio();
String baseUrl = 'http://192.168.2.162:3000/api/user/login';

  set token(token) {}


  
  @override
  Widget build(BuildContext context) {
    String _email = "", _password = "";
    return Stack(
      children: [
        BackgroundImage(
          image: 'assets/images/login_bg.jpg',
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    'Human Walkometer',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                   style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                   
                   decoration: const InputDecoration(labelText: 'ईमेल ',
                   icon: Icon(Icons.email,
                   color: Colors.white,),
                   labelStyle: TextStyle(color:Colors.white) ,
                   hintText: 'आफ्नो सत्य ईमेल दिनुहोस्'
                   ,
                   hintStyle: TextStyle(
                  color: Colors.white,
                  
                ),
                    fillColor: Colors.grey,
                    focusColor: Colors.black,
                    border: OutlineInputBorder(),
                    isDense: true, 
                    contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                    
                    
                    
                    
                    
                        
                        
              
                    ),
                    
                   
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter your email address';
                          }
                          // Check if the entered email has the right format
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          // Return null if the entered email is valid
                          return null;
                        },
                        onChanged: (value) => _email = value,
                    // onChanged: (value) => _email = value;
                  ),
                  Divider(),
                  TextFormField(
                    style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    decoration:
                      const InputDecoration(labelText: 'पासवोर्ड् ',
                      icon: Icon(Icons.key,
                      color: Colors.white,),
                      labelStyle: TextStyle(color:Colors.white) ,
                      hintText: 'आफ्नो सत्य पासवोर्ड् दिनुहोस्',
                       hintStyle: TextStyle(
                  color: Colors.white,
                  
                ),
                   
                      
                      fillColor: Colors.white,
                      focusColor: Colors.grey,
                      isDense: true, 
                    contentPadding: EdgeInsets.fromLTRB(20, 30, 20, 15),
                      border: OutlineInputBorder(),),
                      obscureText: true,
                      
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.trim().length < 8) {
                          return 'Password must be at least 8 characters in length';
                        }
                        // Return null if the entered password is valid
                        return null;
                      },
                      onChanged: (value) => _password = value,
                      
                  ),
                  const SizedBox(
                height: 30,
                width: 20,
              ),
              
                  // PasswordInput(
                    
                  //   // icon: FontAwesomeIcons.lock,
                  //   // hint: 'Password',
                  //   // inputAction: TextInputAction.done,
                  // ),
                  // GestureDetector(
                  //   onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                  //   child: Text(
                  //     'Forgot Password',
                  //     style: kBodyText,
                  //   ),
                  // ),
                  SizedBox(
                    height: 25,
                  ),
                  RoundedButton(
                    buttonName: 'Login',
                    onClick: () => AuthService.login(_email, _password).then((val){
                      
                      print("Email:  $_email");
                      
                      print("Password:  $_password");
                      if(val == null){
                        Fluttertoast.showToast(
                          msg: 'आफ्नो सही ईमेल या पासवोड् दिनुहोस्!!',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.redAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                        );
                        return;
                      }
                      Map res = val.data["response"];
                      print("Res Map:  $res");
                      if( res.isNotEmpty){
                        Fluttertoast.showToast(
                          msg: 'हार्दिक स्वोगतम छ ',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.blueAccent,
                          textColor: Colors.white,
                          fontSize: 16.0
                        );
                        Navigator.of(context).push(
                        MaterialPageRoute(builder: (contect)=> NavBar()),);
                      }
                    }),
                  ),
                  
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'CreateNewAccount'),
                child: Container(
                  child: Text(
                    'Create New Account',
                    style: kBodyText,
                  ),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(width: 1, color: kWhite))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}
