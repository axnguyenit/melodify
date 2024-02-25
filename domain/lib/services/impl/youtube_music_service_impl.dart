import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: YoutubeMusicService)
class YoutubeMusicServiceImpl implements YoutubeMusicService {
  final YoutubeMusicRepository _ytmRepository;

  YoutubeMusicServiceImpl(this._ytmRepository);

  @override
  Future<YTMSearchResult> getSearchResults(SearchResultRequest request) {
    return _ytmRepository.getSearchResults(request);
  }

  @override
  Future<MusicCarouselShelf> getMusicCarouselShelf() {
    return _ytmRepository.getMusicCarouselShelf();
  }

  @override
  Future<HomeData> getHome({required String localeCode}) {
    return _ytmRepository.getHome(localeCode: localeCode);
  }

  @override
  Future<Content> browse(BrowseRequest request) {
    return _ytmRepository.browse(request);
  }

  @override
  Future<VideoDetails> player({required GetPlayerRequest request}) {
    return _ytmRepository.player(request: request);
  }
}
