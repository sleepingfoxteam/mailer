import '../base_service.dart';
import 'gmail_network_objects/get_user_profile.dart';

class GmailNetworkService extends BaseService {
  dynamic getUserProfile({String uid}) async {
    return execute(GetUserProfileNetworkObject(uid: uid));
  }
}
