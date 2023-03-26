import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/controllers/auth.controller.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
    required AuthController authController,
  })  : _authController = authController,
        super(key: key);

  final AuthController _authController;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          // title
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // email
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Email Address',
                suffixIcon: Icon(Icons.email),
              ),
            ),
          ),

          // password
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: TextFormField(
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Password',
                suffixIcon: Icon(Icons.lock),
              ),
            ),
          ),
          SizedBox(height: 10),

          // button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  _authController.pageController.animateToPage(1,
                      duration: 500.milliseconds, curve: Curves.easeIn);
                },
                child: Container(
                  width: w * 0.5,
                  height: 60,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.circular(w * 0.3),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Create account',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Spacer(),
          // login
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                _authController.pageController.animateToPage(0,
                    duration: 500.milliseconds, curve: Curves.easeIn);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 50),
                child: Text(
                  "Already have an account ?",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
