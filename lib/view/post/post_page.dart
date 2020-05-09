import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_template/my_error/my_state.dart';
import 'package:my_template/my_model/response.dart';
import 'package:my_template/my_widget/post_widget.dart';
import 'package:my_template/utilities/app_environment.dart';
import 'package:http/http.dart' as http;
import 'package:my_template/view/comment/comment_page.dart';
import 'package:my_template/view/post/post_bloc.dart';
class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  
  List listdata;
  bool check=true;
  PostBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc=PostBloc();
    bloc.getPost();
   
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Page"),),
      body:StreamBuilder<Response>(
        stream:bloc.postStream(),
        initialData:Response(myState: MyState.loading,data: null),
        builder: (context, snapshot) {
          if(snapshot.data.myState==MyState.loading){
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.data.myState==MyState.data){    
          return ListView.builder(itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){
                  return CommentPage(snapshot.data.data[index]);
                }));
              },
              child: PostWidget(snapshot.data.data[index]));
          },itemCount: snapshot.data.data.length,
          );
          }else if(snapshot.data.myState==MyState.error){
            return Center(child: Text(snapshot.data.data));
          }
        }
      )
      
    );
  }
}