import 'package:chat_app/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class Login extends StatefulWidget {
  static const String id='LOGIN';
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email;
  String password;

  final FirebaseAuth _auth =FirebaseAuth.instance;
  Future<void> loginuser ()async {

    User user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password
    )).user;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(user:user)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('My Chat'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'logo',
              child:Container(
                width: 120,
                child:  Image.asset('assets/images/chat2.png'),
              ),
            ),
            SizedBox(height: 50,),
            TextField(
              keyboardType: TextInputType.emailAddress, //بتحدد نوع ال input
              onChanged: (value){
                email=value;
              },
              decoration: InputDecoration(
                  hintText: 'Enter your email....',
                  border: OutlineInputBorder(

                  )
              ),
            ),
            SizedBox(height: 20,),
            TextField(
              autocorrect: false,//  عشان ميدينيش اقتراحات للكلمه اللي هتدخل
              obscureText: true, //متشفر
              onChanged: (value){
                password=value;
              },
              decoration: InputDecoration(
                  hintText: 'Enter password...',
                  border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 40,),
            custom_button('Login',()async{await loginuser();})

          ],
        ),
      ),
    );
  }
}
