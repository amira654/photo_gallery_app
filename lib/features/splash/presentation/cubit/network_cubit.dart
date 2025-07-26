import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

enum NetworkStatus { online, offline }

class NetworkCubit extends Cubit<NetworkStatus> {
  final Connectivity _connectivity = Connectivity();

  NetworkCubit() : super(NetworkStatus.online) {
    _init();
  }
  void _init() {
    _checkConnection();
    _connectivity.onConnectivityChanged.listen((_) {
      _checkConnection();
    });
  }
  Future<void> _checkConnection() async {
    final hasInternet = await InternetConnectionChecker.instance.hasConnection;
    if (hasInternet) {
      emit(NetworkStatus.online);
    } else {
      emit(NetworkStatus.offline);
    }
  }

}
