import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/validators.dart';
import 'package:kindermanager/model/child.dart';

/// Test class to check that the validators class acts like it should.
/// The Positive Tests can only be passed if the variable is accepted and is valid.
/// The Negative Tests can only be passed if the variable is NOT accepted and is NOT valid.
void main() {
  /// -------------------------------------     STRING VALIDATOR TESTS IS BELOW THIS LINE ------------------

  /// POSITIVE TEST
  test('non empty string', () {
    final validator = ValidStringValidator();
    expect(validator.isValid('test'), true);
  });

  /// NEGATIVE TEST
  test('empty string', () {
    final validator = ValidStringValidator();
    expect(validator.isValid(''), false);
  });

  /// NEGATIVE TEST
  test('space as string', () {
    final validator = ValidStringValidator();
    expect(validator.isValid(' '), false);
  });

  /// POSITIVE TEST
  test('string with special symbols', () {
    final validator = ValidStringValidator();
    expect(validator.isValid('@@£@'), true);
  });

  /// POSITIVE TEST
  test('string with nordic letters', () {
    final validator = ValidStringValidator();
    expect(validator.isValid('ÆØÅ'), true);
  });

  /// -------------------------------------     EMAIL VALIDATOR TESTS IS BELOW THIS LINE ------------------

  /// NEGATIVE TEST
  test('empty email', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid(' '), false);
  });

  /// NEGATIVE TEST
  test('testing nordic letters', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid(' ØÆÅØ'), false);
  });

  /// NEGATIVE TEST
  test('missing @ in email', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('testtest.no'), false);
  });

  /// NEGATIVE TEST
  test('missing string in front of @ in email', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('@test.no'), false);
  });

  /// NEGATIVE TEST
  test('missing string after @ in email', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test'), false);
  });

  /// NEGATIVE TEST
  test('missing .no or similar at end of email', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test@test'), false);
  });

  /// POSITIVE TEST
  test('check valid email', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test.test@test.no'), true);
  });

  /// POSITIVE TEST
  test('check valid emai2l', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test+test@test.no'), true);
  });

  /// POSITIVE TEST
  test('check valid email3', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test@test.com'), true);
  });

  /// POSITIVE TEST
  test('check valid email4', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test@test.no.ui'), true);
  });

  /// NEGATIVE TEST
  test('check valid email5', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('.no @.no .no'), false);
  });

  /// NEGATIVE TEST
  test('check valid email6', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('hesten.er.best@@hest.no.no'), false);
  });

  /// NEGATIVE TEST
  test('check valid email7', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test.test.no'), false);
  });

  /// NEGATIVE TEST
  test('check valid email8', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('asd@@@@asd.no'), false);
  });
  /// POSITIVE TEST
  test('check valid email9', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('asd@asd.ui.op.co.no'), true);
  });
  /// POSITIVE TEST
  test('check valid email10', () {
    final validator = ValidEmailValidator();
    expect(
        validator.isValid(
            'test1.test2.test3.test4@test1.test2.test3.test4.test5.test6.no'),
        true);
  });
  /// POSITIVE TEST
  test('check valid email11', () {
    final validator = ValidEmailValidator();
    expect(validator.isValid('test1.test2.test3.test4@test.no.uk'), true);
  });

  /// -------------------------------------    NAME VALIDATOR TESTS IS BELOW THIS LINE ------------------

  /// POSITIVE TEST
  test('check valid name', () {
    final validator = ValidNameValidator();
    expect(validator.isValid('æøå'), true);
  });

  /// POSITIVE TEST
  test('check valid name', () {
    final validator = ValidNameValidator();
    expect(validator.isValid('per'), true);
  });

  /// POSITIVE TEST
  test('check valid name', () {
    final validator = ValidNameValidator();
    expect(validator.isValid('per askeladden hanskerom pedersen'), true);
  });

  /// NEGATIVE TEST
  test('check valid name', () {
    final validator = ValidNameValidator();
    expect(validator.isValid('yy'), false);
  });

  /// NEGATIVE TEST
  test('check valid name', () {
    final validator = ValidNameValidator();
    expect(validator.isValid('æ'), false);
  });

  /// NEGATIVE TEST
  test('check valid name', () {
    final validator = ValidNameValidator();
    expect(validator.isValid(' '), false);
  });

  /// -------------------------------------     ID VALIDATOR TESTS IS BELOW THIS LINE ------------------
  /// ALL ID IS VALID BETWEEN 1 and 1 000 000.

  /// POSITIVE TEST
  test('check valid id', () {
    final validator = ValidIdValidator();
    expect(validator.isValid('1'), true);
  });

  /// POSITIVE TEST
  test('check valid id', () {
    final validator = ValidIdValidator();
    expect(validator.isValid('1000000'), true);
  });

  /// NEGATIVE TEST
  test('check valid id', () {
    final validator = ValidIdValidator();
    expect(validator.isValid('0'), false);
  });

  /// NEGATIVE TEST
  test('check valid id', () {
    final validator = ValidIdValidator();
    expect(validator.isValid('-1'), false);
  });

  /// NEGATIVE TEST
  test('check valid id', () {
    final validator = ValidIdValidator();
    expect(validator.isValid('1000000000'), false);
  });

  /// -------------------------------------     STATUS VALIDATOR TESTS IS BELOW THIS LINE ------------------
  /// Cant do any negative tests here as the validator says there is an error
  /// due to two of the same classes with same name is used.
  /// only the correct one can be tested.

  /// POSITIVE TEST - THIS TEST SHALL PASS!
  /// This test will PASS if the validator says that the entered param is valid.
  test('check valid status', () {
    Status status = Status.START;
    final validator = ValidStatusValidator();
    expect(validator.isValid(status), true);
  });

  /// POSITIVE TEST - THIS TEST SHALL PASS!
  /// This test will PASS if the validator says that the entered param is valid.
  test('check valid status', () {
    Status status = Status.ARRIVED;
    final validator = ValidStatusValidator();
    expect(validator.isValid(status), true);
  });

  /// POSITIVE TEST - THIS TEST SHALL PASS!
  /// This test will PASS if the validator says that the entered param is valid.
  test('check valid status', () {
    Status status = Status.PICKED;
    final validator = ValidStatusValidator();
    expect(validator.isValid(status), true);
  });

  /// POSITIVE TEST - THIS TEST SHALL PASS!
  /// This test will PASS if the validator says that the entered param is valid.
  test('check valid status', () {
    Status status = Status.ABSENT;
    final validator = ValidStatusValidator();
    expect(validator.isValid(status), true);
  });
}
