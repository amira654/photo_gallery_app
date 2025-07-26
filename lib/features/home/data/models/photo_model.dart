import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/photo_entity.dart';
part 'photo_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class PhotoModel extends PhotoEntity {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String photographer;

  @HiveField(2)
  final String url;

  @HiveField(3)
  final String imageUrl;

  const PhotoModel({
    required this.id,
    required this.photographer,
    required this.url,
    required this.imageUrl,
  }) : super(
    id: id,
    photographer: photographer,
    url: url,
    imageUrl: imageUrl,
  );

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    final src = json['src'] as Map<String, dynamic>?;

    return PhotoModel(
      id: json['id'] as int,
      photographer: json['photographer'] as String? ?? 'Unknown',
      url: json['url'] as String? ?? '',
      imageUrl: src?['medium'] as String? ?? src?['original'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);
}
