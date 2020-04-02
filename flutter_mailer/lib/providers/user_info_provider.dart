import 'package:google_sign_in/google_sign_in.dart';

class UserInfoProvider {
  // Singleton
  UserInfoProvider._();

  static UserInfoProvider _userInfoProvider = UserInfoProvider._();

  factory UserInfoProvider() {
    return _userInfoProvider;
  }

  GoogleSignInAccount googleSignInAccount;
  String accessToken;
  String idToken;

  void saveUser({
    GoogleSignInAccount account,
    GoogleSignInAuthentication authentication,
  }) {
    googleSignInAccount = account;
    accessToken = authentication.accessToken;
    idToken = authentication.idToken;
  }
}
