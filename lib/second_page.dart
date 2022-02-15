import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class PhotosApi extends StatefulWidget {


  @override
  _PhotosApiState createState() => _PhotosApiState();
}

class _PhotosApiState extends State<PhotosApi> {
  List<Photos> photoList=[];
  Future<List<Photos>> getPhotoApi() async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data)
      {
        Photos photos=Photos(title: i['title'], url: i['url']);
        photoList.add(photos);

      }
      return photoList;
    }
    else {
      return photoList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photos Api'),
      centerTitle: true,),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Photos>>(
                future: getPhotoApi(),
                builder: (context, snapshot){
              return ListView.builder(
                  itemCount: photoList.length,
                  itemBuilder: (context,index){
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  title: Text(snapshot.data![index].title.toString()),
                );
              });
            }),
          )
        ],
      ),
    );
  }

  
}

class Photos{
  String title,url;
  Photos({
    required this.title,
    required this.url
});
}
