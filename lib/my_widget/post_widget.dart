import 'package:flutter/material.dart';

class PostWidget extends StatelessWidget {

  Map<String,dynamic>map;
  PostWidget(this.map);


  @override
  Widget build(BuildContext context) {
    return Card(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("User ID" +map['userId'].toString()),
                  Text("Title" + map['title'].toString()),
                  Text( "Body" +map['body'].toString()),
                ],
              ),
            );
  }
}