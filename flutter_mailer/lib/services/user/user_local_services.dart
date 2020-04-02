import 'package:fluttermailer/utils/share_preferences_service.dart';
import 'package:get_it/get_it.dart';

class UserLocalService {
  final _sharePreferencesService = GetIt.I<SharePreferenceService>();

  Future<String> checkUserLogin() async {
    String accessToken = await _sharePreferencesService.getUser();
    return accessToken;
  }
}
