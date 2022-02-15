import 'dart:convert';

import 'package:api_practice_flutter/Models/PostModels.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModels> postList=[];
  Future<List<PostModels>> getPostApi() async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if(response.statusCode==200){
      postList.clear();
      var data=jsonDecode(response.body.toString());
      for(Map i in data){
        postList.add(PostModels.fromJson(i));
      }
      return postList;
    }
    else {
      return postList;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Course'),

      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
                builder: (context,snapshot){
              if(!snapshot.hasData)
                {
                  return Center(
                    child: Container(height:100,
                        width: 100,
                        child: const CircularProgressIndicator()),
                  );
                }
              else {
                return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context,index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title : ${postList[index].title}'),
                        ],
                      ),
                    ),
                  );
                });
              }
            }),
          )
        ],
      ),
    );
  }
}
