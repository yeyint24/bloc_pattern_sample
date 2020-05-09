import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_template/my_error/my_state.dart';
import 'package:my_template/my_model/comment.dart';
import 'package:my_template/my_model/response.dart';
import 'package:my_template/utilities/app_environment.dart';

class CommentBloc{
  
  StreamController<Response> commentController=StreamController();

  Stream<Response> cmtStream()=>commentController.stream;


  getComment(String id)async{
    Response resp=Response(myState: MyState.loading,data:null);
    List listdata;
    await http.get(commentApi + id).then((res){
       if(res.statusCode==200){
        List<Comment> listdata=[];
        List<dynamic> list=json.decode(res.body);
        
        //Looping Data Inser In MOdel Comment
        listdata=list.map((d){
          return Comment.fromMap(d);
        }).toList();
        resp.myState=MyState.data;
        resp.data=listdata;
        commentController.sink.add(resp);
       }else{
        resp.myState=MyState.error;
        resp.data="Data Fetching Error";
        commentController.sink.add(resp);
       }
    }).catchError((e){
      resp.myState=MyState.error;
      resp.data="Data Fetching Error";
      commentController.sink.add(resp);
    });
  }

   dispose(){
    commentController.close();
  }



}