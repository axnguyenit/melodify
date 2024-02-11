import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class Content extends Model {
  final List<MusicCarouselShelf> musicCarouselShelfList;
  final Continuation? continuation;

  Content({
    required this.musicCarouselShelfList,
    required this.continuation,
  });

  factory Content.fromJson(
    Map<String, dynamic> json, {
    bool firstBrowse = false,
  }) {
    try {
      List contents = [];
      Map<String, dynamic>? continuationMap;

      if (firstBrowse) {
        contents = getValue<List>(json, [
          'contents',
          'singleColumnBrowseResultsRenderer',
          'tabs',
          0,
          'tabRenderer',
          'content',
          'sectionListRenderer',
          'contents',
        ], []);

        continuationMap = getValue<Map<String, dynamic>?>(json, [
          'contents',
          'singleColumnBrowseResultsRenderer',
          'tabs',
          0,
          'tabRenderer',
          'content',
          'sectionListRenderer',
          'continuations',
          0,
        ]);
      } else {
        contents = getValue<List>(json, [
          'continuationContents',
          'sectionListContinuation',
          'contents',
        ], []);

        continuationMap = getValue<Map<String, dynamic>?>(json, [
          'continuationContents',
          'sectionListContinuation',
          'continuations',
          0,
        ]);
      }

      final filteredContents = contents.where(
        (content) {
          return content.containsKey('musicCarouselShelfRenderer');
        },
      );
      final continuation = continuationMap == null
          ? null
          : Continuation.fromJson(continuationMap);

      return Content(
        musicCarouselShelfList: List.from(
          filteredContents.map((e) {
            return MusicCarouselShelf.fromJson(e);
          }),
        ),
        continuation: continuation,
      );
    } catch (e) {
      log.error('Parse Content Error --> $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [];
}
