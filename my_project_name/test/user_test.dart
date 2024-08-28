import 'package:test/test.dart';
import 'package:UserDataFetcher/user.dart';

void main() {
  test('User fromJson creates valid instance', () {
    var json = {
      'id': 1,
      'name': 'John Doe',
      'username': 'johndoe',
      'email': 'johndoe@biz'
    };

    var user = User.fromJson(json);
    expect(user.id, 1);
    expect(user.name, 'John Doe');
    expect(user.username, 'johndoe');
    expect(user.email, 'johndoe@biz');
  });

  test('User fromJson throws exception on invalid data', () {
    var json = {
      'id': null,
      'name': 'John Doe',
      'username': 'johndoe',
      'email': 'johndoe@biz'
    };

    expect(() => User.fromJson(json), throwsFormatException);
  });
}
