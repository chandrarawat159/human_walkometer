import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



// class MyApps extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "Test App",
//         home: exited(),
//     );
//   }
// }

//ignore: camel_case_types
class exited extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Scaffold( 
        appBar: AppBar( 
          title: Text("लग आउट"),
          backgroundColor: Colors.redAccent,
        ),
        body: Container( 
          child:Center( 
            child: ElevatedButton( 
              onPressed: (){
                  SystemNavigator.pop(); //for Android from flutter/services.dart
                  //exit(0) for both Android and iOS
              },
               child: Text("लग आउट"),
            ),
          )
        )
    );
  }
}