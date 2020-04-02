import 'package:fluttermailer/blocs/stream_data.dart';

class BaseBloc {
  /// null means having nothing yet
  StreamData<bool> streamIsLoading = StreamData(null);

  /// Handle loading
  void handleLoading(bool value) {
    streamIsLoading.setData(value);
  }
}
