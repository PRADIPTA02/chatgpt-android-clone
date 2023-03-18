import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';

class InterNetConnectionCheck extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  Future<void> startMonitoring() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    _updateConnectionStatus(connectivityResult);

    _connectivity.onConnectivityChanged.listen((connectivityResult) {
      _updateConnectionStatus(connectivityResult);
    });
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    bool isOnline = (connectivityResult == ConnectivityResult.wifi ||
        connectivityResult == ConnectivityResult.mobile);
    if (_isOnline != isOnline) {
      _isOnline = isOnline;
      notifyListeners();
    }
  }
}
