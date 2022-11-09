import 'package:flutter_test/flutter_test.dart';
import 'package:kindermanager/application/sign_in/validators.dart';


void main() {
  /// -------------------------------------     STRING VALIDATOR TESTS IS BELOW THIS LINE ------------------
  test('non empty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('test'), true);
  });

  test('empty string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(''), false);
  });

  test('space as string', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid(' '), false);
  });

  test('string with special symbols', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('@@£@'), true);
  });

  test('string with nordic letters', () {
    final validator = NonEmptyStringValidator();
    expect(validator.isValid('ÆØÅ'), true);
  });
/// -------------------------------------     EMAIL VALIDATOR TESTS IS BELOW THIS LINE ------------------
  test('empty email', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid(' '), false);
  });
  test('testing nordic letters', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid(' ØÆÅØ'), false);
  });

  test('missing @ in email', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('testtest.no'), false);
  });

  test('missing string in front of @ in email', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('@test.no'), false);
  });

  test('missing string after @ in email', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test'), false);
  });

  test('missing .no or similar at end of email', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test@test'), false);
  });

  test('check valid email', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test.test@test.no'), true);
  });

  test('check valid emai2l', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test+test@test.no'), true);
  });

  test('check valid email3', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test@test.com'), true);
  });

  test('check valid email4', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test@test.no.ui'), true);
  });

  test('check valid email5', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('.no @.no .no'), false);
  });
  test('check valid email6', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('hesten.er.best@@hest.no.no'), false);
  });
  test('check valid email7', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test.test.no'), false);
  });
  test('check valid email8', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('asd@@@@asd.no'), false);
  });
  test('check valid email9', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('asd@asd.ui.op.co.no'), true);
  });
  test('check valid email10', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test1.test2.test3.test4@test1.test2.test3.test4.test5.test6.no'), true);
  });
  test('check valid email11', () {
    final validator = NonEmptyEmailValidator();
    expect(validator.isValid('test1.test2.test3.test4@test.no.uk'), true);
  });

}