import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../models/pexels_response.dart';

part 'photo_api_service.g.dart';

@RestApi()
abstract class PhotoApiService {
  factory PhotoApiService(Dio dio, {String baseUrl}) = _PhotoApiService;

  @GET('curated')
  Future<PexelsResponse> getPhotos(
      @Query('page') int page,
      @Query('per_page') int perPage,
      );
}
