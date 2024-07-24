class AllSearchResponse {
  AllSearchResponse({
    required this.resultCount,
    required this.results,
  });

  final int resultCount;
  final List<Result> results;

  factory AllSearchResponse.fromJson(Map<String, dynamic> json) {
    return AllSearchResponse(
      resultCount: json["resultCount"] ?? 0,
      results: json["results"] == null
          ? []
          : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    );
  }
}

class SearchResponse {
  final int resultCount;
  final List<CategoryResult> categoryResults;

  SearchResponse({
    required this.resultCount,
    required this.categoryResults,
  });
}

class CategoryResult {
  final String category;
  final List<Result> results;

  CategoryResult({
    required this.category,
    required this.results,
  });
}

class Result {
  Result({
    required this.wrapperType,
    required this.kind,
    required this.artistId,
    required this.collectionId,
    required this.trackId,
    required this.artistName,
    required this.collectionName,
    required this.trackName,
    required this.collectionCensoredName,
    required this.trackCensoredName,
    required this.artistViewUrl,
    required this.collectionViewUrl,
    required this.trackViewUrl,
    required this.previewUrl,
    required this.artworkUrl30,
    required this.artworkUrl60,
    required this.artworkUrl100,
    required this.collectionPrice,
    required this.trackPrice,
    required this.releaseDate,
    required this.collectionExplicitness,
    required this.trackExplicitness,
    required this.discCount,
    required this.discNumber,
    required this.trackCount,
    required this.trackNumber,
    required this.trackTimeMillis,
    required this.country,
    required this.currency,
    required this.primaryGenreName,
  });

  final String wrapperType;
  final String kind;
  final int artistId;
  final int collectionId;
  final int trackId;
  final String artistName;
  final String collectionName;
  final String trackName;
  final String collectionCensoredName;
  final String trackCensoredName;
  final String artistViewUrl;
  final String collectionViewUrl;
  final String trackViewUrl;
  final String previewUrl;
  final String artworkUrl30;
  final String artworkUrl60;
  final String artworkUrl100;
  final double collectionPrice;
  final double trackPrice;
  final DateTime? releaseDate;
  final String collectionExplicitness;
  final String trackExplicitness;
  final int discCount;
  final int discNumber;
  final int trackCount;
  final int trackNumber;
  final int trackTimeMillis;
  final String country;
  final String currency;
  final String primaryGenreName;

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      wrapperType: json["wrapperType"] ?? "",
      kind: json["kind"] ?? "",
      artistId: json["artistId"] ?? 0,
      collectionId: json["collectionId"] ?? 0,
      trackId: json["trackId"] ?? 0,
      artistName: json["artistName"] ?? "",
      collectionName: json["collectionName"] ?? "",
      trackName: json["trackName"] ?? "",
      collectionCensoredName: json["collectionCensoredName"] ?? "",
      trackCensoredName: json["trackCensoredName"] ?? "",
      artistViewUrl: json["artistViewUrl"] ?? "",
      collectionViewUrl: json["collectionViewUrl"] ?? "",
      trackViewUrl: json["trackViewUrl"] ?? "",
      previewUrl: json["previewUrl"] ?? "",
      artworkUrl30: json["artworkUrl30"] ?? "",
      artworkUrl60: json["artworkUrl60"] ?? "",
      artworkUrl100: json["artworkUrl100"] ?? "",
      collectionPrice: json["collectionPrice"] ?? 0.0,
      trackPrice: json["trackPrice"] ?? 0.0,
      releaseDate: DateTime.tryParse(json["releaseDate"] ?? ""),
      collectionExplicitness: json["collectionExplicitness"] ?? "",
      trackExplicitness: json["trackExplicitness"] ?? "",
      discCount: json["discCount"] ?? 0,
      discNumber: json["discNumber"] ?? 0,
      trackCount: json["trackCount"] ?? 0,
      trackNumber: json["trackNumber"] ?? 0,
      trackTimeMillis: json["trackTimeMillis"] ?? 0,
      country: json["country"] ?? "",
      currency: json["currency"] ?? "",
      primaryGenreName: json["primaryGenreName"] ?? "",
    );
  }
}
