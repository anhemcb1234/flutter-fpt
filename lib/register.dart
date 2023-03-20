import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_app/main.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _fullname = '';
  String _password = '';
  String _address = '';
  var _date = '';
  String _email = '';
  String _phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
                hintText: 'Address',
              ),
            ),
            Column(children: [
              TextField(
                readOnly: true,
                controller: _dateController,
                decoration: InputDecoration(
                  hintText: 'Date $_date',
                ),
              ),
              TextButton(
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime(2018, 3, 5),
                        maxTime: DateTime.now(),
                        theme: const DatePickerTheme(
                            headerColor: Colors.orange,
                            backgroundColor: Colors.blue,
                            itemStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                            doneStyle:
                                TextStyle(color: Colors.white, fontSize: 16)),
                        onChanged: (date) {
                      setState(() {
                        _date = DateFormat('dd-MM-yyyy').format(date);
                      });
                    }, onConfirm: (date) {
                      setState(() {
                        _date = DateFormat('dd-MM-yyyy').format(date);
                      });
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                  child: const Text(
                    'Choose DateTime ',
                    style: TextStyle(color: Colors.blue),
                  )),
            ]),
            TextField(
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              controller: _emailController,
              decoration: const InputDecoration(
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
              decoration: const InputDecoration(
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
    // if (!_userInvalid && !_passInvalid) {
    //   // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => (HomePage())));
    // }
    // });
    var url = Uri.parse('https://mobile-project.herokuapp.com/user/signUp');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      "fullname": _fullname,
      "password": _password,
      "address": _address,
      "dob": _date,
      "email": _email,
      "phone": _phone
    });
    var response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      // Navigator.push(context, MaterialPageRoute(builder: gotoHome));
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => (MyApp())));
    }
  }

  Widget gotoHome(BuildContext context) {
    return MyApp();
  }
}
