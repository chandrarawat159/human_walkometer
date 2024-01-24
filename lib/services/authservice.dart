import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  static Dio dio= Dio()..options= BaseOptions(
    baseUrl : "http://192.168.1.130:3000/api",

  );
  static dynamic login(email, password) async {
    try {
        final  result = await dio.post(
          '/user/login',//endpoint
          data: {"email":email, "password":password}
         
          );
          print(result);
          return result;

          

    } on DioError catch (e){
      print(e.error);
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