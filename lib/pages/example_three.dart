import 'dart:convert';

import 'package:api_practice_flutter/Models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserComplexApi extends StatefulWidget {
  const UserComplexApi({Key? key}) : super(key: key);

  @override
  _UserComplexApiState createState() => _UserComplexApiState();
}

class _UserComplexApiState extends State<UserComplexApi> {
  
  List<UserModel> userList=[];
  Future<List<UserModel>> getUserApi() async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    }
    else {

      return userList;
    }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complex Object'),centerTitle: true,),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<UserModel>>(
            future: getUserApi(),
            builder: (context,snapshot){
              if(!snapshot.hasData){
                return Center(
                  child: Container(
                    height: 100,
                      width: 100,
                      child: const CircularProgressIndicator()),
                );
              }
              else {
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: Column(
                        children: [
                          ReUsableRow(title: 'Name :', value: snapshot.data![index].name.toString()),
                          ReUsableRow(title: 'User Name :', value: snapshot.data![index].username.toString()),
                          ReUsableRow(title: 'Email :', value: snapshot.data![index].email.toString()),
                          ReUsableRow(title: 'City :', value: snapshot.data![index].address!.city.toString()),
                          ReUsableRow(title: 'Address :', value: snapshot.data![index].address!.geo!.lat.toString()+" "+snapshot.data![index].address!.geo!.lng.toString()),
                        ],
                      ),
                    );
                  },
                );
              }
            },
          ) ),
        ],
      ),
    );
  }
}
class ReUsableRow extends StatelessWidget {
  String title,value;
  ReUsableRow({Key? key,required this.title,required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),

        ],
      ),
    );
  }
}

