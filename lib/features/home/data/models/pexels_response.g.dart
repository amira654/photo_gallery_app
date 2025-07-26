// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexels_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PexelsResponse _$PexelsResponseFromJson(Map<String, dynamic> json) =>
    PexelsResponse(
      page: (json['page'] as num).toInt(),
      per_page: (json['per_page'] as num).toInt(),
      photos: (json['photos'] as List<dynamic>)
          .map((e) => PhotoModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PexelsResponseToJson(PexelsResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'per_page': instance.per_page,
      'photos': instance.photos,
    };
