import 'package:domain/domain.dart';

abstract class YoutubeMusicClient {
  Future<String?> getVisitorId(Map<String, String> headers);

  Future<YTMSearchResult> getSearchResults(SearchResultRequest request);

  Future<MusicCarouselShelf> getMusicCarouselShelf();

  Future<HomeData> getHome({required String localeCode});

  Future<Content> browse(BrowseRequest request);

  Future<VideoDetails> player({required GetPlayerRequest request});
}
