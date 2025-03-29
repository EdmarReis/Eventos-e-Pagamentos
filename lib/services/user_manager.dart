class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  String? user;

  void setUser(String userName) {
    user = userName;
  }

  String? getUser() {
    return user;
  }
}
