import 'package:fluttermailer/blocs/base_bloc.dart';
import 'package:fluttermailer/blocs/stream_data.dart';
import 'package:fluttermailer/models/gmail_models/gmail_message_result_model.dart';
import 'package:fluttermailer/models/model_index.dart';
import 'package:fluttermailer/providers/provider_index.dart';
import 'package:fluttermailer/repositories/repository_index.dart';
import 'package:get_it/get_it.dart';

class InboxBloc extends BaseBloc {
  GmailRepo _gmailRepo;
  GmailProvider _gmailProvider;

  // null means having nothing yet
  StreamData<LoadUserMessageListResultModel> streamUserMessages =
  StreamData(null);

  // 0.0 means not loading
  StreamData<double> streamLoadingPercent = StreamData(0.0);

  InboxBloc({GmailRepo gmailRepo, GmailProvider gmailProvider}) {
    _gmailRepo = gmailRepo ?? GetIt.I<GmailRepo>();
    _gmailProvider = gmailProvider ?? GetIt.I<GmailProvider>();
  }

  void loadUserMessageList({String uid,
    bool includeSpamTrash: false,
    int maxResults: 5,
    String pageToken: "",
    String q: ""}) async {
    handleLoading(true);
    final result = await _gmailRepo.loadUserMessageList(
      uid: uid,
      includeSpamTrash: includeSpamTrash,
      maxResults: maxResults,
      pageToken: pageToken,
      q: q,
    );
    if (result.isSuccess()) {
      LoadUserMessageListResultModel resultModel =
      await loadUserMessageListResultModelFull(result.data);
      streamUserMessages.setData(resultModel);
      _gmailProvider.loadUserMessageListResultModel = resultModel;
    }
    handleLoading(false);
  }

  Future<LoadUserMessageListResultModel> loadUserMessageListResultModelFull(
      LoadUserMessageListResultModel data) async {
    List<GmailMessageResultModel> gmails = List();
    for (int i = 0; i < data.messages.length; i++) {
      GmailMessageResultModel gmail = data.messages[i];
      final result = await _gmailRepo.loadGmailResultFromId(
          uid: "me", id: gmail.id, format: "full");
      if (result.isSuccess()) {
        gmail = result.data;
        streamLoadingPercent.setData((i + 1) / 5);
      }
      gmails.add(gmail);
    }
    data.messages = gmails;
    return data;
  }

  void getGmailMessageProvider() {
    handleLoading(true);
    streamUserMessages.setData(_gmailProvider.loadUserMessageListResultModel);
    handleLoading(false);
  }
}
