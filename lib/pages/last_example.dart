import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Models/ProductModel.dart';

class LastExample extends StatefulWidget {
  const LastExample({Key? key}) : super(key: key);

  @override
  _LastExampleState createState() => _LastExampleState();
}

class _LastExampleState extends State<LastExample> {

  List<ProductModel> productList=[];
  Future<List<ProductModel>> getAllProduct() async{
    final response=await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data=jsonDecode(response.body.toString());
    if(response.statusCode==200){
      for(Map i in data){
        productList.add(ProductModel.fromJson(i));
      }
      return productList;
    }
    else {

      return productList;
    }
  }


  @override
  Widget build(BuildContext context) {




    return Scaffold(
      appBar: AppBar(title: Text('Final get Example'),),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder<List<ProductModel>>(
                future: getAllProduct(),
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
                    return Container(
                      height: MediaQuery.of(context).size.height*.25,
                      width: MediaQuery.of(context).size.width*.5,
                      child: ListView.builder(
                        itemCount: productList.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data![index].products![index].images![index].url.toString())
                                )
                              ),
                              child: Column(
                                children: [
                                Text(index.toString())
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }
                },
              ) ),
        ],
      ),
    );
  }
}
