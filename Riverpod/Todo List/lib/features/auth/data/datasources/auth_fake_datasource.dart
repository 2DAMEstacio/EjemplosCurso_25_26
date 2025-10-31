import 'package:flutter_todo_list_riverpod/features/auth/data/models/user.dart';
import 'package:flutter_todo_list_riverpod/features/auth/domain/entities/logged_user.dart';

const String kSecretPin = '4242';

class AuthFakeDatasource {
  User? _loggedUser;
  Future<User?> login(String pin) async {
    if (pin == kSecretPin) {
      _loggedUser = User(name: "SuperUser", email: "email@gmail.com", age: 15);
      return _loggedUser;
    } else {
      return null;
    }
  }

  void logout() {
    _loggedUser = null;
  }

  Future<LoggedUser?> getLoggedUser() async {
    return _loggedUser;
  }
}
