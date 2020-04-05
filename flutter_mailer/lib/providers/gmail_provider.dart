import 'package:fluttermailer/models/gmail_models/load_user_message_list_result_model.dart';

class GmailProvider {
  GmailProvider._();

  static GmailProvider _gmailProvider = GmailProvider._();

  factory GmailProvider() {
    return _gmailProvider;
  }

  @override
  String toString() {
    return 'GmailProvider{loadUserMessageListResultModel: $loadUserMessageListResultModel}';
  }

  LoadUserMessageListResultModel loadUserMessageListResultModel;
}
