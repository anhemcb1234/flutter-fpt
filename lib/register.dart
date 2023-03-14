import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _fullname = '';
  String _password = '';
  String _address = '';
  String _dob = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _fullname = value;
                });
              },
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
              controller: _passwordController,
              obscureText: true,
              decoration:const InputDecoration(
                hintText: 'Password',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _address = value;
                });
              },
              controller: _addressController,
              decoration:const InputDecoration(
                hintText: 'Address',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _dob = value;
                });
              },
              controller: _dobController,
              decoration:const InputDecoration(
                hintText: 'Dob',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              controller: _emailController,
              decoration:const InputDecoration(
                hintText: 'Email',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  _phone = value;
                });
              },
              controller: _phoneController,
              decoration:const InputDecoration(
                hintText: 'Phone',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: onSignInClicked,
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onSignInClicked() async {
    // debugPrint('movieTitle $_email');
    //     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    //   if (response.statusCode == 200) {
    //     print(response.body);
    //   } else {
    //     print('Request failed with status: ${response.statusCode}.');
    //   }
    // setState(() {
    // if (_userController.text.length < 6 ||
    //     !_userController.text.contains("@")) {
    //   _userInvalid = true;
    // } else {
    //   _userInvalid = false;
    // }

    // if (_passController.text.length < 6) {
    //   _passInvalid = true;
    // } else {
    //   _passInvalid = false;
    // }

    // if (!_userInvalid && !_passInvalid) {
    //   // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => (HomePage())));
    // }
    // });
    debugPrint('movieTitle $_email');
    var url = Uri.parse('https://mobile-project.herokuapp.com/user/signUp');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "fullname": _fullname,
      "password": _password,
      "address": _address,
      "dob": _dob,
      "email": _email,
      "phone": _phone
    });
    var response = await http.post(url, headers: headers, body: body);
    
    debugPrint('Response status: ${response.statusCode}');
    debugPrint('Response body: ${response.body}');
    debugPrint('Response: ${response}');
  }
}
