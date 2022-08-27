import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

abstract class Pagination<T> {
  int get resultCount;
  List<T> get results;
}

@freezed
class SearchResult with _$SearchResult {
  const SearchResult._();
  const factory SearchResult({
    required String wrapperType,
    required String kind,
    required int artistId,
    required int collectionId,
    required int trackId,
    required String artistName,
    required String collectionName,
    required String trackName,
    required String collectionCensoredName,
    required String trackCensoredName,
    required String artistViewUrl,
    required String collectionViewUrl,
    required String trackViewUrl,
    required String previewUrl,
    required String artworkUrl30,
    required String artworkUrl60,
    required String artworkUrl100,
    required double collectionPrice,
    required double trackPrice,
    required String releaseDate,
    required String collectionExplicitness,
    required String trackExplicitness,
    required int discCount,
    required int discNumber,
    required int trackCount,
    required int trackNumber,
    required int trackTimeMillis,
    required String country,
    required String currency,
    required String primaryGenreName,
    required bool isStreamable,
  }) = _SearchResult;

  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);
}

@freezed
class PaginatedSearchResult with _$PaginatedSearchResult {
  const PaginatedSearchResult._();

  @Implements<Pagination<SearchResult>>()
  const factory PaginatedSearchResult({
    required int resultCount,
    required List<SearchResult> results,
  }) = _PaginatedSearchResult;

  factory PaginatedSearchResult.fromJson(Map<String, dynamic> json) =>
      _$PaginatedSearchResultFromJson(json);
}
