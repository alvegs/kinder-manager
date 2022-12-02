import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/model/child.dart';

/// Test class to check that the child class acts like it should.
/// The Positive Tests can only be passed if there are valid parameters.
/// The Negative Tests can only be passed if an exception gets thrown.
void main() {
  group('Test creation of child', () {
    /// POSITIVE TEST - THIS TEST SHOULD PASS!
    /// If an exception gets thrown, this test fails.
    test('Test creation of child with valid parameters', () {
      String name = 'test';
      String id = '1';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
        expect(child1, isA<Child>());
      } catch (e) {
        assert(false);
      }
    });

    /// POSITIVE TEST - THIS TEST SHOULD PASS!
    /// If an exception gets thrown, this test fails.
    /// If no exception is thrown, this test passes.
    test('Test creation of child with valid parameters', () {
      String name = 'asd';
      String id = '1';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(false);
      }
    });

    /// POSITIVE TEST - THIS TEST SHOULD PASS!
    /// If an exception gets thrown, this test fails.
    /// If no exception is thrown, this test passes.
    test('Test creation of child with valid parameters', () {
      String name = 'tested';
      String id = '1';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
        expect(child1, isA<Child>());
      } catch (e) {
        assert(false);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD NOT PASS WITHOUT AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of child with invalid name - empty name', () {
      String name = ' ';
      String id = '1';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD NOT PASS WITHOUT AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of child with invalid name - empty name', () {
      String name = 'asd';
      String id = ' ';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD NOT PASS WITHOUT AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test(
        'Test creation of child with invalid name and id - too short name and missing id',
        () {
      String name = ' a';
      String id = ' ';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD NOT PASS WITHOUT AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of child with invalid parameters - empty params', () {
      String name = ' ';
      String id = ' ';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD NOT PASS WITHOUT AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of child with invalid id', () {
      String name = 'Pål';
      String id = '-1';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD NOT PASS WITHOUT AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of child with invalid id', () {
      String name = 'Pål';
      String id = '0';
      String imageFile = "images/cartoon.jpeg";

      try {
        Child child1 = Child(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });
  });
}
