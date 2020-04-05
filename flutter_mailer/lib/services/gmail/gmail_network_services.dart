import '../base_service.dart';
import 'gmail_network_objects/get_gmail_from_id.dart';
import 'gmail_network_objects/get_user_profile.dart';
import 'gmail_network_objects/load_user_message_list.dart';
import 'gmail_network_objects/move_message_to_strash.dart';

class GmailNetworkService extends BaseService {
  dynamic getUserProfile({String uid}) async {
    return execute(GetUserProfileNetworkObject(uid: uid));
  }

  dynamic loadUserMessageList({String uid,
    bool includeSpamTrash,
    int maxResults,
    String pageToken,
    String q}) async {
    return await execute(LoadUserMessageListNetworkObject(
      uid: uid,
      includeSpamTrash: includeSpamTrash,
      maxResults: maxResults,
      pageToken: pageToken,
      q: q,
    ));
  }

  dynamic getGmailResultFromId({
    String uid,
    String id,
    String format,
  }) async {
    return await execute(GetGmailFromIdNetworkObject(
      uid: uid,
      id: id,
      format: format,
    ));
  }

  dynamic moveMessgeToStrash({String gmailId}) async {
    return await execute(MoveMessageToStrashNetworkObject(gmailId: gmailId));
  }
}
