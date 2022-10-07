// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'dart:developer';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../services/auth.dart';
// class AuthProvider extends InheritedWidget {
//   AuthProvider({required this.auth, required this.child}); //TODO: fix
//   final AuthBase auth;
//   final Widget child;
//   @override
//   bool updateShouldNotify(covariant InheritedWidget oldWidget)  => false;
//
//   static AuthBase of(BuildContext context){
//     AuthProvider provider = context.inherit; //TODO: fix
//     return provider.auth;
//
//   }
// }