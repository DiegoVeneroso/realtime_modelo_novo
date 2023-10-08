import 'package:flutter/material.dart';

class CustomAppbar extends AppBar {
  CustomAppbar({
    Key? key,
    double elevation = 2,
  }) : super(
          key: key,
          backgroundColor: Colors.white,
          elevation: elevation,
          centerTitle: true,
          title: Row(
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 80,
                ),
              ),
              Text('fdas'
                  // style: const TextStyle(color: Colors.black, fontSize: 10),
                  ),
              // TextButton(
              //   onPressed: () {
              //     // Get.find<AuthService>().logout();
              //   },
              //   child: Text('Sair'),
              // ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        );
}
