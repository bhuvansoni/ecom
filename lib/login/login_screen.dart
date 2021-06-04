import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: Get.mediaQuery.size.height * 0.5,
            color: Colors.grey,
          ),
          Text('Welcome to Groczz'),
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
            ),
          ),
          Container(
            height: 50,
            decoration: BoxDecoration(
                // color: Get.
                ),
            child: Text('Get OTP'),
          ),
          Text('Log In'),
        ],
      ),
    );
  }
}
