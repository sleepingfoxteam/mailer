import 'package:google_sign_in/google_sign_in.dart';

const GMAIL_SCOPES = [
  "https://mail.google.com/",
];

class UserNetworkService {
  Future<GoogleSignInAccount> signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: GMAIL_SCOPES,
    );
    GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    return googleSignInAccount;
  }
}
