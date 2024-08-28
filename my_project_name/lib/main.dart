import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'user.dart';

final Logger logger = Logger('UserAPI');

void setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

Future<List<User>> fetchUsers() async {
  setupLogging();
  try {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((user) => User.fromJson(user)).toList();
    } else {
      logger.severe('Failed to load users: ${response.reasonPhrase}');
      throw HttpException('Failed to load users: ${response.reasonPhrase}');
    }
  } catch (e) {
    logger.severe('Error occurred: $e');
    rethrow;
  }
}

void printUsersWithLongUsernames(List<User> users) {
  StringBuffer output = StringBuffer();
  users.where((user) => user.username.length > 6).forEach((user) {
    output.writeln('User: ${user.username}, Name: ${user.name}');
  });
  print(output.toString());
}

void countUsersWithBizDomain(List<User> users) {
  int count = users.where((user) => user.email.endsWith('.biz')).length;
  print('Number of users with email domain "biz": $count');
}

void main() async {
  List<User> users = await fetchUsers();

  var longUsernameUsers =
      users.where((user) => user.username.length > 6).toList();
  printUsersWithLongUsernames(longUsernameUsers);

  var bizDomainUsers =
      users.where((user) => user.email.endsWith('.biz')).toList();
  countUsersWithBizDomain(bizDomainUsers);
}
