import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailcontroler=TextEditingController();
  TextEditingController passcontroler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Api'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Email'
              ),
              controller: emailcontroler,
            ),
            SizedBox(height: 20,),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Password'
              ),
              controller: passcontroler,
            ),
            SizedBox(height: 50,),

            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Center(
                    child: Text('Sign Up'),
                  ),
                ),
              ),
              onTap: (){
                login(emailcontroler.text.toString(),passcontroler.text.toString());
              },
            )
          ],
        ),
      ),
    );
  }

  void login(String email, String pass) async {
    try{
      Response response=await post(
        Uri.parse('https://reqres.in/api/login'),
        body: {
          'email' :email,
          'password' :pass,
        }
      );

       if(response.statusCode==200){
        var data=jsonDecode(response.body.toString());
        print(data);
        print('Login Succesful');
      }
      else {
        print('Failed');
      }
    }
    catch(e){
      print(e.toString());
    }
  }
}
