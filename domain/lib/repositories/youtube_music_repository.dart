import 'package:domain/domain.dart';

abstract class YoutubeMusicRepository {
  Future<YTMSearchResult> getSearchResults(SearchResultRequest request);

  Future<MusicCarouselShelf> getMusicCarouselShelf();

  Future<HomeData> getHome({required String localeCode});

  Future<Content> browse(BrowseRequest request);
}
