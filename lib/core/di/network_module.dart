import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../features/home/data/data_sources/local/photo_local_data_source.dart';
import '../../features/home/data/data_sources/remote/photo_api_service.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final dio = Dio();
    dio.options.headers['Authorization'] = 'VJZauwRFzDmIB10RBGWckStCCmOx9koVUgUw0uAmHSbi2Qc32sD1MqHA';
    dio.options.baseUrl = 'https://api.pexels.com/v1/';
    return dio;
  }

  @lazySingleton
  PhotoApiService photoApiService(Dio dio) => PhotoApiService(dio);

  @lazySingleton
  PhotoLocalDataSource photoLocalDataSource() => PhotoLocalDataSourceImpl();

}
