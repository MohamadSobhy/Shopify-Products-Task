import 'dart:developer';
import 'dart:io';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('google.com');

      if (result.isNotEmpty && result.first.rawAddress.isNotEmpty) {
        //! Device is connected to internet
        return true;
      }
    } on SocketException catch (err) {
      //! Device is not connected to internet
      log(err.message, name: 'NETWORK_INFO');
    }

    return false;
  }
}
