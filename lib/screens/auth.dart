import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:liongate_workshop/constant.dart';
import 'package:liongate_workshop/controllers/auth.controller.dart';
import 'package:liongate_workshop/screens/widgets/login.dart';
import 'package:liongate_workshop/screens/widgets/register.dart';

class AuthScreen extends StatelessWidget {
  AuthController _authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AuthController>(
          init: AuthController(),
          builder: (_) {
            return Container(
              width: w,
              height: h,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      'assets/images/bg.gif',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: w,
                      height: 500.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100 -
                        lerpDouble(0, 50, _authController.pageValue)!
                            .toDouble(),
                    left: 0,
                    right: 0,
                    child: Container(
                      width: w,
                      height: h * 0.4,
                      child: Center(
                        child: Text(
                          'Lion Gate',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    width: w,
                    height: h *
                        (0.4 +
                            lerpDouble(0, _authController.pageValue * 0.22, 1)!
                                .toDouble()),
                    // .clamp(0, 0.8),
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _authController.pageController,
                      children: [
                        LoginScreen(authController: _authController),
                        RegisterScreen(authController: _authController),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
