// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchResult _$$_SearchResultFromJson(Map<String, dynamic> json) =>
    _$_SearchResult(
      wrapperType: json['wrapperType'] as String,
      kind: json['kind'] as String,
      artistId: json['artistId'] as int,
      collectionId: json['collectionId'] as int,
      trackId: json['trackId'] as int,
      artistName: json['artistName'] as String,
      collectionName: json['collectionName'] as String,
      trackName: json['trackName'] as String,
      collectionCensoredName: json['collectionCensoredName'] as String,
      trackCensoredName: json['trackCensoredName'] as String,
      artistViewUrl: json['artistViewUrl'] as String,
      collectionViewUrl: json['collectionViewUrl'] as String,
      trackViewUrl: json['trackViewUrl'] as String,
      previewUrl: json['previewUrl'] as String,
      artworkUrl30: json['artworkUrl30'] as String,
      artworkUrl60: json['artworkUrl60'] as String,
      artworkUrl100: json['artworkUrl100'] as String,
      collectionPrice: (json['collectionPrice'] as num).toDouble(),
      trackPrice: (json['trackPrice'] as num).toDouble(),
      releaseDate: json['releaseDate'] as String,
      collectionExplicitness: json['collectionExplicitness'] as String,
      trackExplicitness: json['trackExplicitness'] as String,
      discCount: json['discCount'] as int,
      discNumber: json['discNumber'] as int,
      trackCount: json['trackCount'] as int,
      trackNumber: json['trackNumber'] as int,
      trackTimeMillis: json['trackTimeMillis'] as int,
      country: json['country'] as String,
      currency: json['currency'] as String,
      primaryGenreName: json['primaryGenreName'] as String,
      isStreamable: json['isStreamable'] as bool,
    );

Map<String, dynamic> _$$_SearchResultToJson(_$_SearchResult instance) =>
    <String, dynamic>{
      'wrapperType': instance.wrapperType,
      'kind': instance.kind,
      'artistId': instance.artistId,
      'collectionId': instance.collectionId,
      'trackId': instance.trackId,
      'artistName': instance.artistName,
      'collectionName': instance.collectionName,
      'trackName': instance.trackName,
      'collectionCensoredName': instance.collectionCensoredName,
      'trackCensoredName': instance.trackCensoredName,
      'artistViewUrl': instance.artistViewUrl,
      'collectionViewUrl': instance.collectionViewUrl,
      'trackViewUrl': instance.trackViewUrl,
      'previewUrl': instance.previewUrl,
      'artworkUrl30': instance.artworkUrl30,
      'artworkUrl60': instance.artworkUrl60,
      'artworkUrl100': instance.artworkUrl100,
      'collectionPrice': instance.collectionPrice,
      'trackPrice': instance.trackPrice,
      'releaseDate': instance.releaseDate,
      'collectionExplicitness': instance.collectionExplicitness,
      'trackExplicitness': instance.trackExplicitness,
      'discCount': instance.discCount,
      'discNumber': instance.discNumber,
      'trackCount': instance.trackCount,
      'trackNumber': instance.trackNumber,
      'trackTimeMillis': instance.trackTimeMillis,
      'country': instance.country,
      'currency': instance.currency,
      'primaryGenreName': instance.primaryGenreName,
      'isStreamable': instance.isStreamable,
    };

_$_PaginatedSearchResult _$$_PaginatedSearchResultFromJson(
        Map<String, dynamic> json) =>
    _$_PaginatedSearchResult(
      resultCount: json['resultCount'] as int,
      results: (json['results'] as List<dynamic>)
          .map((e) => SearchResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PaginatedSearchResultToJson(
        _$_PaginatedSearchResult instance) =>
    <String, dynamic>{
      'resultCount': instance.resultCount,
      'results': instance.results,
    };
