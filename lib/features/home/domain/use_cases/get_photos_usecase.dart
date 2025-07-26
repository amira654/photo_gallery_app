import 'package:injectable/injectable.dart';

import '../entities/photo_entity.dart';
import '../repositories/photo_repository.dart';

@lazySingleton
class GetPhotosUseCase {
  final PhotoRepository repository;

  GetPhotosUseCase(this.repository);

  Future<List<PhotoEntity>> call(int page) async {
    return await repository.getPhotos(page);
  }
}
