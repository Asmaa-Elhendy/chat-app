import 'package:chat_app/chat.dart';
import 'package:chat_app/login.dart';
import 'package:chat_app/registeration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return FutureBuilder( //important
      future: Firebase.initializeApp(),//firebase app
      builder:(context,snapshot)=>MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),

       initialRoute: MyHomePage.id,// بتاخد text
        routes: {
          MyHomePage.id: (context) => MyHomePage(),
          Registration.id:(context)=>Registration(),
          Login.id:(context)=>Login(),
          Chat.id:(context)=>Chat()
        }
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static const String id='Home';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Hero(
              tag: 'logo',
              child: Container(
                width: 100,
                child: Image.asset('assets/images/chat2.png'),
              ),
      ),
             Text('My Chat',style: TextStyle(fontSize: 40),)
        ],
      ),
            SizedBox(height: 50),
            custom_button('Login',(){Navigator.of(context).pushNamed(Login.id);}),
            SizedBox(height: 10,),
            custom_button('Register',(){
              Navigator.of(context).pushNamed(Registration.id);
            })
        ],

      ),
    );
  }

}
class custom_button extends StatelessWidget{
  final VoidCallback callback;
  final String text;

  custom_button(this.text,this.callback);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8),
      child:Material(
        color: Colors.blueGrey,
       elevation: 8,
       borderRadius: BorderRadius.circular(40),
       child: MaterialButton(
         minWidth: 200,
         height: 45,
         onPressed: callback,
         child: Text(text),
       ),
      )
    );
  }
}