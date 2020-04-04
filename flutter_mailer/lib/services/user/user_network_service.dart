import 'package:google_sign_in/google_sign_in.dart';

const GMAIL_SCOPES = [
  "https://www.googleapis.com/auth/gmail.settings.sharing",
  "https://www.googleapis.com/auth/gmail.settings.basic",
  "https://www.googleapis.com/auth/gmail.metadata",
  "https://www.googleapis.com/auth/gmail.modify",
  "https://www.googleapis.com/auth/gmail.compose",
  "https://www.googleapis.com/auth/gmail.insert",
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
