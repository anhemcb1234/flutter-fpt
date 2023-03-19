import 'package:flutter/material.dart';
import 'package:project_app/home.dart';
import 'package:project_app/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Metropolis',
      ),
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final storage = new FlutterSecureStorage();
  bool _showPass = false;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final _userNameError = "Tai khoan khong hop le";
  final _passError = "Mat khau phai tren 6 ky tu";
  final _userInvalid = false;
  final _passInvalid = false;
  String _email = '';
  String _password = '';
  String cookie = '';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
            constraints: BoxConstraints.expand(),
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Container(
                        width: 70,
                        height: 70,
                        padding: const EdgeInsets.all(15),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffd8d8d8)),
                        child: const FlutterLogo()),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 60),
                    child: Text("Hello\nWelcome Back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                      controller: _userController,
                      decoration: InputDecoration(
                          labelText: "USERNAME",
                          errorText: _userInvalid ? _userNameError : null,
                          labelStyle: const TextStyle(
                              color: Color(0xff888888), fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                    child: Stack(
                        alignment: AlignmentDirectional.centerEnd,
                        children: <Widget>[
                          TextField(
                            onChanged: (value) {
                              setState(() {
                                _password = value;
                              });
                            },
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                            controller: _passController,
                            obscureText: !_showPass,
                            decoration: InputDecoration(
                                labelText: "PASSWORD",
                                errorText: _passInvalid ? _passError : null,
                                labelStyle: const TextStyle(
                                    color: Color(0xff888888), fontSize: 15)),
                          ),
                          GestureDetector(
                            onTap: onToggleShowPass,
                            child: Text(_showPass ? "HIDE" : "SHOW",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold)),
                          )
                        ]),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: onSignInClicked,
                      child: const Text('SIGN IN'),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    onPressed: onClickRegister,
                    child: const Text('Register ?'),
                  ),
                ],
              ),
            )));
  }

  void onToggleShowPass() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void onClickRegister() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => (RegisterPage())));
  }

  Future onSignInClicked() async {
    // final storage = new FlutterSecureStorage();
    final url = Uri.parse('https://mobile-project.herokuapp.com/user/login');
    var headers = {'Content-Type': 'application/json; charset=UTF-8'};
    var body = jsonEncode({
      "email": _email,
      "password": _password,
    });
    var response = await http.post(url, headers: headers, body: body);
    print(response.headers);
    // await storage.write(key: 'token', value: response.body);
    // final cookies = jsonEncode({response.headers.map['set-cookie']});
    // var session = response.headers['set-cookie'];
    if (response.statusCode == 200) {
      // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (HomePage())));
    }
    // ignore: unused_element
  }

  Widget gotoHome(BuildContext context) {
    return HomePage();
  }

  Widget gotoRegister(BuildContext context) {
    return RegisterPage();
  }
}
