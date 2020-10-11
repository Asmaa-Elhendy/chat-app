import 'package:chat_app/chat.dart';
import 'package:chat_app/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  static const String id='Registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  String email;
  String password;
  final FirebaseAuth _auth =FirebaseAuth.instance;
  Future<void> registeruser ()async {
//User
    User user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password
    )).user;
    Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(user: user,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,

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
                hintText: 'Enter email....',
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
                hintText: 'Enter password at least 6 char...',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 40,),
            custom_button('Registeration',()async{await registeruser();})

          ],
        ),
      ),
    );
  }
}
