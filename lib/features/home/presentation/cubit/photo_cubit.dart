import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/photo_entity.dart';
import '../../domain/use_cases/get_photos_usecase.dart';
import 'photo_state.dart';

@injectable
class PhotoCubit extends Cubit<PhotoState> {
  final GetPhotosUseCase getPhotosUseCase;

  PhotoCubit(this.getPhotosUseCase) : super(PhotoInitial());

  int _currentPage = 1;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  final List<PhotoEntity> _photos = [];

  Future<void> fetchPhotos({bool loadMore = false}) async {
    if (loadMore) {
      if (_isLoadingMore || !_hasMore) return;
      _isLoadingMore = true;
      _currentPage++;
    } else {
      emit(PhotoLoading());
      _currentPage = 1;
      _photos.clear();
      _hasMore = true;
    }

    try {
      final newPhotos = await getPhotosUseCase(_currentPage);

      if (newPhotos.isEmpty) {
        _hasMore = false;
      } else {
        _photos.addAll(newPhotos);
      }

      emit(PhotoLoaded(List.from(_photos)));
    } catch (e) {
      emit(PhotoError(e.toString()));
    } finally {
      _isLoadingMore = false;
    }
  }
}
