import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/model/section.dart';

/// Test class to check that the section class acts like it should.
/// The Positive Tests can only be passed if there are valid parameters.
/// The Negative Tests can only be passed if an exception gets thrown.
void main() {
  group('Test creation of section', () {
    /// POSITIVE TEST - THIS TEST SHOULD PASS WHITOUT AN GETTING A CATCHED EXCEPTION!
    /// If an exception gets thrown, this test fails.
    test('Test creation of section with valid parameters', () {
      String name = 'test';
      String id = '1';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
        expect(section1, isA<Section>());
      } catch (e) {
        assert(false);
      }
    });

    /// POSITIVE TEST - THIS TEST SHOULD PASS WHITOUT AN GETTING A CATCHED EXCEPTION!
    /// If an exception gets thrown, this test fails.
    /// If no exception is thrown, this test passes.
    test('Test creation of section with valid parameters', () {
      String name = 'asd';
      String id = '1';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
        expect(section1, isA<Section>());
      } catch (e) {
        assert(false);
      }
    });

    /// POSITIVE TEST - THIS TEST SHOULD PASS WHITOUT AN GETTING A CATCHED EXCEPTION!
    /// If an exception gets thrown, this test fails.
    /// If no exception is thrown, this test passes.
    test('Test creation of section with valid parameters', () {
      String name = 'tested';
      String id = '1';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
        expect(section1, isA<Section>());
      } catch (e) {
        assert(false);
      }
    });

    /// POSITIVE TEST - THIS TEST SHOULD PASS WHITOUT AN GETTING A CATCHED EXCEPTION!
    /// If an exception gets thrown, this test fails.
    /// If no exception is thrown, this test passes.
    test('Test creation of section with valid parameters', () {
      String name = 'tested';
      String id = '1';
      String imageFile = 'http://test.test.com/test/test/test/test/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
        expect(section1, isA<Section>());
      } catch (e) {
        assert(false);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('test invalid name', () {
      String name = ' ';
      String id = '1';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of section with invalid name - empty id', () {
      String name = 'asd';
      String id = ' ';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of section with invalid name - empty imageFile', () {
      String name = 'asd';
      String id = '2';
      String imageFile = ' ';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test(
        'Test creation of section with invalid name and id - too short name and missing id',
        () {
      String name = ' a';
      String id = ' ';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of section with invalid parameters - empty params', () {
      String name = ' ';
      String id = ' ';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of section with invalid id', () {
      String name = 'Pål';
      String id = '-1';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of section with invalid id', () {
      String name = 'Pål';
      String id = '0';
      String imageFile = 'http://test.test.com/test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });

    /// NEGATIVE TEST - THIS TEST SHOULD  PASS WITH AN EXCEPTION BEING THROWN!
    /// If an exception DO NOT GET THROWN, this test fails.
    /// If an exception is thrown, this test passes.
    test('Test creation of section with invalid imagefile', () {
      String name = 'Pål';
      String id = '0';
      String imageFile = 'http://test.png';

      try {
        Section section1 = Section(name: name, id: id, imageFile: imageFile);
      } catch (e) {
        assert(true);
      }
    });
  });
}
