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
    expect(validator.isValid('ÆØÅ'), false);
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
    expect(validator.isValid('test@test.no'), true);
  });

}