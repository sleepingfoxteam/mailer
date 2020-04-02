class UserInfoProvider {
  // Singleton
  UserInfoProvider._();

  static UserInfoProvider _userInfoProvider = UserInfoProvider._();

  factory UserInfoProvider() {
    return _userInfoProvider;
  }
}
