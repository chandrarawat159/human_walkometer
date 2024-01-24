import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:humanwalkometer_app/home.dart';
import '../pallete.dart';
import '../services/register.dart';
import '../widgets/widgets.dart';
import 'package:dio/dio.dart';

class CreateNewAccount extends StatelessWidget {
  Dio dio = Dio();
  String baseUrl = 'http://192.168.2.162:3000/api/user/login';

  set token(token) {}
  String _email = "";
  String _password = "";
  String _fullName = "";
  String _confirmPassword ="";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: 'assets/images/register_bg.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.width * 0.1,
                ),
                Stack(
                  children: [
                    Center(
                      child: ClipOval(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                          child: CircleAvatar(
                            radius: size.width * 0.14,
                            backgroundColor: Colors.grey[400]!.withOpacity(
                              0.4,
                            ),
                            child: Icon(
                              FontAwesomeIcons.user,
                              color: kWhite,
                              size: size.width * 0.1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: size.height * 0.08,
                      left: size.width * 0.56,
                      child: Container(
                        height: size.width * 0.1,
                        width: size.width * 0.1,
                        decoration: BoxDecoration(
                          color: kBlue,
                          shape: BoxShape.circle,
                          border: Border.all(color: kWhite, width: 2),
                        ),
                        child: Icon(
                          FontAwesomeIcons.arrowUp,
                          color: kWhite,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: size.width * 0.1,
                ),
                Column(
                  children: [
                    // TextInputField(
                    //   icon: FontAwesomeIcons.user,
                    //   hint: 'Full-Name',
                    //   inputType: TextInputType.name,
                    //   inputAction: TextInputAction.next,
                    // ),
                    // TextInputField(
                    //   icon: FontAwesomeIcons.envelope,
                    //   hint: 'Email',
                    //   inputType: TextInputType.emailAddress,
                    //   inputAction: TextInputAction.next,
                    // ),
                    TextFormField(
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'पुरा नाम ',
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'आफ्नो सत्य नाम दिनुहोस्',
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
                          return 'Please enter your new Name';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a new name';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                      onChanged: (value) => { 
                        _fullName = value,
                        print("Fname Value: $value")
                      },
                    ),
                    const SizedBox(
                      height: 30,
                      width: 20,
                    ),
                    TextFormField(
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'ईमेल ',
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'आफ्नो नाया ईमेल बनाउनुहोस् ',
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        fillColor: Colors.grey,
                        focusColor: Colors.black,
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 25, 20, 15),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your new email address';
                        }
                        // Check if the entered email has the right format
                        if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          return 'Please enter a new email address';
                        }
                        // Return null if the entered email is valid
                        return null;
                      },
                      onChanged: (value) =>  { 
                        _email = value,
                        print("Email Value: $value")
                      },
                    ),
                    Divider(),
                    TextFormField(
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'पासवोर्ड्',
                        icon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'पासवोर्ड् बनाउदा कम्तिमा सात वटा अक्ष्यर दिनुहोला  ',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        focusColor: Colors.grey,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 25, 20, 15),
                        border: OutlineInputBorder(),
                      ),
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
                      onChanged: (value) =>  { 
                        _password = value,
                        print("password Value: $value")
                      },
                    ),
                    const SizedBox(
                      height: 30,
                      width: 20,
                    ),
                    TextFormField(
                      style: new TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'कनफिर्म पासवोर्ड्',
                        icon: Icon(
                          Icons.key,
                          color: Colors.white,
                        ),
                        labelStyle: TextStyle(color: Colors.white),
                        hintText: 'आफ्नो उस्तै पासवोर्ड् बनाउनुहोस् ',
                        hintStyle: TextStyle(color: Colors.white),
                        fillColor: Colors.white,
                        focusColor: Colors.grey,
                        isDense: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 25, 20, 15),
                        border: OutlineInputBorder(),
                      ),
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
                      onChanged: (value) =>  { 
                        _confirmPassword = value,
                        print("password Value: $value")
                      },
                    ),
                    // PasswordInput(
                    //   icon: FontAwesomeIcons.lock,
                    //   hint: 'Confirm Password',
                    //   inputAction: TextInputAction.done,
                    // ),
                    SizedBox(
                      height: 25,
                    ),
                    RoundedButton(
                      buttonName: 'Register',
                      onClick: () =>
                        RegService.register(_fullName, _email, _password, _confirmPassword).then((val) {
                          print("Fullname:  $_fullName");
                          print("Email:  $_email");
                          print("Password:  $_password");
                          print("confirmPassword:  $_confirmPassword");
                          if (val == null) {
                            Fluttertoast.showToast(
                              msg: 'आफ्नो सही ईमेल या पासवोड् दिनुहोस्!!',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                            return;
                          }
                          Map res = val.data["response"];
                          print("Res Map:  $res");
                        if (res.isNotEmpty) {
                          Fluttertoast.showToast(
                              msg: 'तपाईंको नयाँ अकाउन्ट बनेको छ  ',
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.blueAccent,
                              textColor: Colors.white,
                              fontSize: 16.0);
                          //  Navigator.of(context).push(
                          // MaterialPageRoute(builder: (contect)=> Home()),);
                        }
                      }),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: kBodyText,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: Text(
                            'Login',
                            style: kBodyText.copyWith(
                                color: kBlue, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
