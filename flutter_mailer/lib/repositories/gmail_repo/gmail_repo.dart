import 'package:fluttermailer/models/gmail_models/gmail_message_result_model.dart';
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

  Future<RepoResult<LoadUserMessageListResultModel>> loadUserMessageList(
      {String uid,
        bool includeSpamTrash: false,
        int maxResults: 5,
        String pageToken: "",
        String q: ""}) async {
    final result = await _gmailNetworkService.loadUserMessageList(
      uid: uid,
      includeSpamTrash: includeSpamTrash,
      maxResults: maxResults,
      pageToken: pageToken,
      q: q,
    );
    return RepoResult.from(result);
  }

  Future<RepoResult<GmailMessageResultModel>> loadGmailResultFromId({
    String uid,
    String id,
    String format: "full",
  }) async {
    final result = await _gmailNetworkService.getGmailResultFromId(
      uid: uid,
      id: id,
      format: format,
    );
    return RepoResult.from(result);
  }

  Future<RepoResult<MoveStrashResultModel>> moveMessageToStrash(
      {String gmailId}) async {
    final result =
    await _gmailNetworkService.moveMessgeToStrash(gmailId: gmailId);
    return RepoResult.from(result);
  }
}
