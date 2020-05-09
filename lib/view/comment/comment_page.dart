import 'package:flutter/material.dart';
import 'package:my_template/my_error/my_state.dart';
import 'package:my_template/my_model/comment.dart';
import 'package:my_template/my_model/response.dart';
import 'package:my_template/my_widget/post_widget.dart';
import 'package:my_template/view/comment/comment_bloc.dart';

class CommentPage extends StatefulWidget {

  Map<String,dynamic> map;

  CommentPage(this.map);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  
  CommentBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc=CommentBloc();
    bloc.getComment(widget.map['id'].toString());
  }
  
  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Comment Page"),),
      body:Column(
        children: <Widget>[
          PostWidget(widget.map),
          StreamBuilder<Response>(
            initialData: Response(myState: MyState.loading,data: null),
            stream: bloc.cmtStream(),
            builder:(BuildContext context,AsyncSnapshot<Response> snapshot){
            Response resp=snapshot.data;
            if(resp.myState == MyState.loading){
             return Center(child: CircularProgressIndicator());
            }
            else if(resp.myState==MyState.data){
              List<Comment> cmts=resp.data;
              return Expanded(
                child: ListView.builder(itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Text(cmts[index].email),
                        Text(cmts[index].name),
                        Text(cmts[index].body)
                      ],
                    ),
                  );
                },itemCount: cmts.length,
                ),
              );
            }else if(resp.myState==MyState.error){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(snapshot.data.data),
                  RaisedButton(
                    child: Text("Try Again"), 
                    onPressed: () {
                      bloc.getComment(widget.map['id'].toString());
                    },
                  )
                ],
              );
            }
          },
          )
        ],
      )
    );
  }
}

// Widget commentWidget(BuildContext context){
//   return
// }