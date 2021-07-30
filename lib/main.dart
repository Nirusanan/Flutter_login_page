import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Coflutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String uname = '';
  String pwd = '';
  bool visible = false;
  
  
void login() async {
  String email = emailController.text;
  String password = passwordController.text;

  // SERVER LOGIN API URL
    var url = 'http://192.168.1.6/login';

    // Store all data with Param Name.
    var data = {'email': email, 'password': password};

    // // Starting Web API Call.
     var response = await http.post(url, body: json.encode(data));

    var message = jsonDecode(response.body);
    print(message);

  

}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter - Login page'),
          ),
          body: Center(
              child: Column(children: <Widget>[
            Container(
                margin: EdgeInsets.all(30),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'User Name',
                  ),
                  onChanged: (text) {
                    setState(() {
                      uname = text;
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.all(30),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Passsword',
                  ),
                  onChanged: (text) {
                    setState(() {
                      pwd = text;
                    });
                  },
                )),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.blue,
                  child: Text('Login'),
                  onPressed: login,
                )),
            Container(
                height: 50,
                padding: EdgeInsets.fromLTRB(10, 25, 10, 0),
                child: Text("If you don`t have an Account SignUp below")),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: FlatButton(
                onPressed: () {
                  // Navigator.push(
                  //     context, MaterialPageRoute(builder: (context) => SignupPage()));
                  // print("singup page opening");
                },
                child: new Text("SignUp"),
              ),
            ),
            Visibility(
                visible: visible,
                child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator())),
          ]))),
    );
  }
}
