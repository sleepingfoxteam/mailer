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
}
