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
    String? wrapperType,
    String? kind,
    int? artistId,
    int? collectionId,
    int? trackId,
    String? artistName,
    String? collectionName,
    String? trackName,
    String? collectionCensoredName,
    String? trackCensoredName,
    String? artistViewUrl,
    String? collectionViewUrl,
    String? trackViewUrl,
    String? previewUrl,
    String? artworkUrl30,
    String? artworkUrl60,
    String? artworkUrl100,
    double? collectionPrice,
    double? trackPrice,
    String? releaseDate,
    String? collectionExplicitness,
    String? trackExplicitness,
    int? discCount,
    int? discNumber,
    int? trackCount,
    int? trackNumber,
    int? trackTimeMillis,
    String? country,
    String? currency,
    String? primaryGenreName,
    bool? isStreamable,
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
