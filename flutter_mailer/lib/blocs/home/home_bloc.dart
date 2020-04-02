import 'package:flutter_fimber/flutter_fimber.dart';
import 'package:fluttermailer/blocs/base_bloc.dart';
import 'package:fluttermailer/providers/user_info_provider.dart';
import 'package:fluttermailer/repositories/repository_index.dart';
import 'package:fluttermailer/screens/inbox/inbox.dart';
import 'package:fluttermailer/utils/utils_index.dart';
import 'package:get_it/get_it.dart';

class HomeBloc extends BaseBloc {
  UserRepo _userRepo = UserRepo();
  final _userInfoProvider = GetIt.I<UserInfoProvider>();
  final _navigator = GetIt.I<MailerNavigator>();

  void doGoogleSignIn() async {
    final result = await _userRepo.signInWithGoogle();
    Fimber.d("doGoogleSignIn: $result");
    if (result.isSuccess()) {
      _userInfoProvider.googleSignInAccount = result.data;
      _navigator.openScreen(Inbox());
    }
  }
}
