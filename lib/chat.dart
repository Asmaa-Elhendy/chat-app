import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final User user;    //User:instead of FirebaseUser
  Chat({this.user});
  static const String id='CHAT';
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  FirebaseAuth _auth =FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  TextEditingController message_controller=TextEditingController();
  ScrollController _scrollController =ScrollController();

  Future<void> callback()async{
    if(message_controller.text.length>0){
         await _firestore.collection("messages").add({
           'from': widget.user.email,
           'text': message_controller.text,
           'date':DateTime.now().toIso8601String().toString()
         });

        message_controller.clear();
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 3000), curve: Curves.easeOut);
  }}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Hero(
        tag: 'logo',
        child:Container(
          height: 40,
        child: Image.asset('assets/images/chat2.png',)
        ),  
        ),
        title: Text('My Chat Room'),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: (){
              _auth.signOut();
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          )
        ],
      ),
     body: SafeArea(
       child: Column(

         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
            Expanded(
              child: StreamBuilder< QuerySnapshot >(
                stream: _firestore.collection('messages').orderBy('date').snapshots(), //بخزن في collection اسمه messages
               builder: (context,snapshot){
                  if(! snapshot.hasData){
                    return Center(
                      child:CircularProgressIndicator() ,
                    );
                   }
                  List<DocumentSnapshot> docs=snapshot.data.docs;
                  List<Widget> messages = docs.map((doc) => Message(
                      from: doc.data()['from'],
                      text: doc.data()["text"],
                      me: widget.user.email == doc.data()["from"]
                  )).toList();

                  return ListView(

                    controller: _scrollController,
                    children: [
                      ...messages, //... عشان بضيف list inside list (multiple elements in collection)

                    ],
                  );


               },
              ),
            ),
           Container(
             child: Row(
               children: [
                 Expanded(
                   child: TextField(
                     controller: message_controller,
                     decoration: InputDecoration(
                       hintText: 'type a message....',
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(40)
                       )
                     ),
                 )),
                 IconButton(
                   icon: Icon(Icons.send),
                   onPressed: callback,
                 )
               ],
             ),
           ),
           SizedBox(
             height: 4,
           )
         ],

       ),
     ),
    );
  }

}
class Message extends StatelessWidget {
  final String from;
  final String text;
  final bool me;
  Message({this.from,this.text,this.me});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: me?CrossAxisAlignment.end:CrossAxisAlignment.start,
      children: [
        Text(from),
        Material(
          borderRadius: BorderRadius.circular(10),
          color: me?Colors.teal:Colors.redAccent,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child:  Text(text),
          ),
        )
      ],

    );
  }
}
