import 'package:injectable/injectable.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/repositories/photo_repository.dart';
import '../data_sources/remote/photo_api_service.dart';
import '../data_sources/local/photo_local_data_source.dart';
import '../models/photo_model.dart';

@LazySingleton(as: PhotoRepository)
class PhotoRepositoryImpl implements PhotoRepository {
  final PhotoApiService apiService;
  final PhotoLocalDataSource localDataSource;

  PhotoRepositoryImpl(this.apiService, this.localDataSource);

  @override
  Future<List<PhotoEntity>> getPhotos(int page) async {
    try {
      final response = await apiService.getPhotos(page, 20);
      if (page == 1) {
        await localDataSource.cachePhotos(response.photos);
      }
      return response.photos;
    } catch (e) {
      if (page == 1) {
        final cachedPhotos = await localDataSource.getCachedPhotos();
        if (cachedPhotos.isNotEmpty) {
          return cachedPhotos;
        }
      }
      rethrow;
    }
  }

}
