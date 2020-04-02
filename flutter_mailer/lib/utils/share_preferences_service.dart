import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

const ACCESS_TOKEN = "accsessToken";
const ID_TOKEN = "idToken";

class SharePreferenceService {
  SharedPreferences pref;

  SharePreferenceService({@required this.pref});

  Future<bool> saveUser({String accessToken, String idToken}) async {
    pref.setString(ACCESS_TOKEN, accessToken);
    pref.setString(ID_TOKEN, idToken);
    return true;
  }

  Future<String> getUser() async {
    String accessToken = pref.getString(ACCESS_TOKEN);
    return accessToken;
  }
}
