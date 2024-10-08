import 'package:domain/domain.dart';

abstract class YoutubeMusicService {
  Future<YTMSearchResult> getSearchResults(SearchResultRequest request);

  Future<MusicCarouselShelf> getMusicCarouselShelf();

  Future<HomeData> getHome({required String localeCode});

  Future<Content> browse(BrowseRequest request);

  Future<VideoDetails> player({required GetPlayerRequest request});
}
