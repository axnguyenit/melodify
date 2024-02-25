import 'package:data/client/client.dart';
import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: YoutubeMusicRepository)
class YoutubeMusicRepositoryImpl implements YoutubeMusicRepository {
  final YoutubeMusicClient _youtubeMusicClient;

  YoutubeMusicRepositoryImpl(this._youtubeMusicClient);

  @override
  Future<YTMSearchResult> getSearchResults(SearchResultRequest request) {
    return _youtubeMusicClient.getSearchResults(request);
  }

  @override
  Future<MusicCarouselShelf> getMusicCarouselShelf() {
    return _youtubeMusicClient.getMusicCarouselShelf();
  }

  @override
  Future<HomeData> getHome({required String localeCode}) {
    return _youtubeMusicClient.getHome(localeCode: localeCode);
  }

  @override
  Future<Content> browse(BrowseRequest request) {
    return _youtubeMusicClient.browse(request);
  }

  @override
  Future<VideoDetails> player({required GetPlayerRequest request}) {
    return _youtubeMusicClient.player(request: request);
  }
}
