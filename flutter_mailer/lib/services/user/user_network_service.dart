import 'package:google_sign_in/google_sign_in.dart';

class UserNetworkService {
  Future<GoogleSignInAccount> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }
}
