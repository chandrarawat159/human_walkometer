import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegService {
  static Dio dio= Dio()..options= BaseOptions(
    baseUrl : "http://192.168.1.130:3000/api",

  );
  static dynamic register(fullName, email, password, confirmPassword) async {
    try {
        final  result = await dio.post(
          '/user/register',//endpoint
          data: { "fullName":fullName, "email":email, "password":password, "confirmPassword":confirmPassword}
         
          );
          print(result);
          return result;

          

    } on DioError catch (e){
      print(e.response);
      // Fluttertoast.showToast(
      //   msg: e.message,
      //   toastLength: Toast.LENGTH_SHORT,
      //   gravity: ToastGravity.BOTTOM,
      //   backgroundColor: Colors.red,
      //   textColor: Colors.white,
      //   fontSize: 16.0
      // );
    }
  }
}