import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kindermanager/services/auth.dart';
import 'package:kindermanager/services/firebase_database.dart';
import 'package:mockito/mockito.dart';

class MockAuth extends Mock implements Auth {}
class MockDatabase extends Mock implements FirebaseDatabase {}
class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class MockUser extends Mock implements User {
  MockUser();
  factory MockUser.uid(String uid) {
    final user = MockUser();
    when(user.uid).thenReturn(uid);
    return user;
  }
}