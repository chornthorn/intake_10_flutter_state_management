import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<bool> login({String? username, String? password}) async {
    try {
      final respose = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos/1'),
      );

      if (respose.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  // logout
  void logout() {}
}
