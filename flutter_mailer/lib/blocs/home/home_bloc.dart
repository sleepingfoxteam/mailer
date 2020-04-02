import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:fluttermailer/blocs/stream_data.dart';
import 'package:fluttermailer/providers/provider_index.dart';
import 'package:fluttermailer/repositories/repository_index.dart';
import 'package:fluttermailer/screens/inbox/inbox.dart';
import 'package:fluttermailer/utils/ui/mailer_navigator.dart';
import 'package:fluttermailer/utils/utils_index.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../base_bloc.dart';

class HomeBloc extends BaseBloc {
  UserRepo _userRepo = UserRepo();
  final _userInfoProvider = GetIt.I<UserInfoProvider>();
  final _navigator = GetIt.I<MailerNavigator>();
  final _sharePreferences = GetIt.I<SharePreferenceService>();

  /// null means having nothing yet
  StreamData<String> streamAccessToken = StreamData(null);

  void doGoogleSignIn() async {
    final result = await _userRepo.signInWithGoogle();
    Fimber.d("doGoogleSignIn: $result");
    if (result.isSuccess()) {
      GoogleSignInAuthentication auth = await result.data.authentication;
      _userInfoProvider.saveUser(
        account: result.data,
        authentication: auth,
      );
      _sharePreferences.saveUser(
        accessToken: auth.accessToken,
        idToken: auth.idToken,
      );
      _navigator.openScreenAndRemoveOthers(Inbox());
    }
  }

  void checkUserLogin() async {
    handleLoading(true);
    final result = await _userRepo.checkUserLogin();
    if (result.isSuccess()) {
      _navigator.openScreenAndRemoveOthers(Inbox());
    }
    handleLoading(false);
  }
}
