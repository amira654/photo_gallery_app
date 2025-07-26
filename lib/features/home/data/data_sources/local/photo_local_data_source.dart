import 'package:hive/hive.dart';
import '../../models/photo_model.dart';

abstract class PhotoLocalDataSource {
  Future<void> cachePhotos(List<PhotoModel> photos);
  Future<List<PhotoModel>> getCachedPhotos();
}

class PhotoLocalDataSourceImpl implements PhotoLocalDataSource {
  static const String boxName = 'photosBox';

  @override
  Future<void> cachePhotos(List<PhotoModel> photos) async {
    final box = await Hive.openBox<PhotoModel>(boxName);
    await box.clear();
    await box.addAll(photos);
  }
  @override
  Future<List<PhotoModel>> getCachedPhotos() async {
    final box = await Hive.openBox<PhotoModel>(boxName);
    return box.values.toList();
}
}
