import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> get isConnected async {
    var result = await connectivity.checkConnectivity();
    final isConnected = result != ConnectivityResult.none;
    print('Network status: $result, isConnected: $isConnected');
    return isConnected;
  }
}
