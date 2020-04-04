import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/services/gmail/gmail_network_services.dart';
import 'package:get_it/get_it.dart';

import '../repo_result.dart';

class GmailRepo {
  GmailNetworkService _gmailNetworkService;

  GmailRepo({GmailNetworkService gmailNetworkService}) {
    _gmailNetworkService =
        gmailNetworkService ?? GetIt.I<GmailNetworkService>();
  }

  Future<RepoResult<GmailProfileModel>> getUserProfile({String uid}) async {
    dynamic response = await _gmailNetworkService.getUserProfile(uid: uid);
    return RepoResult.from(response);
  }
}
