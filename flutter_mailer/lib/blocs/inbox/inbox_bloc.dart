import 'package:fluttermailer/blocs/base_bloc.dart';
import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/repositories/repository_index.dart';
import 'package:get_it/get_it.dart';

class InboxBloc extends BaseBloc {
  GmailRepo _gmailRepo;

  InboxBloc({GmailRepo gmailRepo}) {
    _gmailRepo = gmailRepo ?? GetIt.I<GmailRepo>();
  }

  void loadGmailUserProfile() async {
    handleLoading(true);
    RepoResult<GmailProfileModel> result = await _gmailRepo.getUserProfile(
      uid: "me",
    );
    if (result.isSuccess()) {
      print(result.data);
    }
    handleLoading(false);
  }
}
