import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_template/my_error/my_state.dart';
import 'package:my_template/my_model/response.dart';
import 'package:my_template/utilities/app_environment.dart';
class PostBloc{
  StreamController<Response> postController=StreamController();

  Stream<Response> postStream()=>postController.stream;

  getPost() async {
    Response resp=Response(myState: MyState.loading,data: null);
    postController.sink.add(resp);
    List listdata;
    await http.get(postApi).then((res){
      if(res.statusCode==200){
       listdata=json.decode(res.body);
       resp.myState=MyState.data;
       resp.data=listdata;
       postController.sink.add(resp);
      }else{
        resp.myState=MyState.error;
        resp.data="Data Fetching Error Network Error";
        postController.sink.add(resp);
      }
    }); 
  }
  dispose(){
    postController.close();
  }


}