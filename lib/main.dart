import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: jsonProve()
    );
  }
  
}

class Users{
  String first_name;
  String last_name;
  String email;
  String photo_url;

  Users(this.first_name, this.last_name, this.email, this.photo_url);


}

Future<List<Users>> _getUsers() async{
  var data= await http.get("http://www.json-generator.com/api/json/get/ceoNKhgIlK?indent=2");
  var JsonData= json.decode(data.body);
List<Users> usertemp= [];


for(var u in JsonData){
  Users users=  Users(u["first_name"], u["last_name"], u["email"], u["photo_url"]);
usertemp.add(users);

}
return usertemp;
  

}

class jsonProve extends StatefulWidget {
  @override
  _jsonProveState createState() => _jsonProveState();
}

class _jsonProveState extends State<jsonProve> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder(
          future: _getUsers(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Loading......"),
                ),
              );
            }else{
              return ListView.builder(
                itemCount: snapshot.data.length,
                  itemBuilder:(BuildContext context,int index){
                    return ListTile(
                      leading: CircleAvatar(
 backgroundImage: NetworkImage(snapshot.data[index].photo_url),
                      ),
                      title: Text(snapshot.data[index].first_name+ " "+ snapshot.data[index].last_name),
                      subtitle: Text(snapshot.data[index].email),
                    );
                  }


              );
            }
          },
        ),
      ),
    );
  }
}





