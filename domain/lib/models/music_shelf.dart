import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class MusicShelf extends Model {
  final MusicShelfHeader header;
  final List<YTMSectionItem> contents;
  final int numItemsPerColumn;

  MusicShelf({
    required this.header,
    required this.contents,
    required this.numItemsPerColumn,
  });

  factory MusicShelf.fromJson(Map<String, dynamic> json) {
    log
      ..trace('Parsing MusicShelf')
      ..trace(json);
    try {
      final renderer = json['musicShelfRenderer'];
      return MusicShelf(
        header: MusicShelfHeader.fromJson(renderer['header']),
        contents: getValue<List>(
          renderer,
          ['contents'],
          [],
        ).map((content) {
          return YTMSectionItem.fromJson(content);
        }).toList(),
        numItemsPerColumn: int.parse(
          getValue<String>(
            renderer,
            ['numItemsPerColumn'],
            '1',
          ),
        ),
      );
    } catch (e) {
      log.error('Parse MusicShelf error --> $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() => {};

  @override
  List<Object> get props => [];
}

// ════════════════════════════════════════════
class MusicShelfHeader {
  final String? title;
  final String? strapline;
  final String? label;
  final MoreContentButton? moreContentButton;

  MusicShelfHeader({
    this.title,
    this.strapline,
    this.label,
    this.moreContentButton,
  });

  factory MusicShelfHeader.fromJson(Map<String, dynamic> json) {
    try {
      log
        ..trace('Parsing MusicShelfHeader')
        ..trace(json);
      final renderer = json['musicShelfBasicHeaderRenderer'];

      return MusicShelfHeader(
        title: getRunsText(renderer, key: 'title'),
        label: getValue<String>(
          renderer,
          ['accessibilityData', 'accessibilityData', 'label'],
          '',
        ),
        strapline: getRunsText(renderer, key: 'strapline'),
        moreContentButton: renderer['moreContentButton'] == null
            ? null
            : MoreContentButton.fromJson(renderer['moreContentButton']),
      );
    } catch (e) {
      log.error('Parse MusicShelfHeader error --> $e');
      rethrow;
    }
  }
}
