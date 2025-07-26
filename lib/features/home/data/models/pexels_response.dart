import 'package:json_annotation/json_annotation.dart';
import 'photo_model.dart';

part 'pexels_response.g.dart';

@JsonSerializable()
class PexelsResponse {
  final int page;
  final int per_page;
  final List<PhotoModel> photos;

  PexelsResponse({
    required this.page,
    required this.per_page,
    required this.photos,
  });

  factory PexelsResponse.fromJson(Map<String, dynamic> json) =>
      _$PexelsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PexelsResponseToJson(this);
}
