import 'package:fluttermailer/repositories/network_exception.dart';
import 'package:fluttermailer/repositories/repo_result.dart';
import 'package:fluttermailer/services/service_index.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepo {
  UserLocalService _userLocalService = UserLocalService();
  UserNetworkService _userNetworkService = UserNetworkService();

  Future<RepoResult<GoogleSignInAccount>> signInWithGoogle() async {
    final result = await _userNetworkService.signInWithGoogle();
    return RepoResult.from(result);
  }

  Future<RepoResult<String>> checkUserLogin() async {
    String accessToken = await _userLocalService.checkUserLogin();
    if (accessToken != null && accessToken.isNotEmpty) {
      return RepoResult.success(accessToken);
    } else {
      return RepoResult.error(NetworkException(message: "User is not log in"));
    }
  }
}
