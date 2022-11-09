import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/model/child.dart';


void main() {
  test('check if child can be created successfully', () {
    String name = 'test';
    String id = '1';
    Child child1 = Child(name: name, id: id);
    expect(child1, isA<Child>());
  });

  test('check if child can be created successfully', () {
    String name = ' ';
    String id = '1';
    Child child1 = Child(name: name, id: id);
    expect(child1, isA<Child>());
  });

  test('check if child can be created successfully', () {
    String name = ' a';
    String id = ' ';
    Child child1 = Child(name: name, id: id);
    expect(child1, isA<Child>());
  });
}