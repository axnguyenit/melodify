import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:domain/domain.dart';

mixin YoutubeData {
  YoutubeState get _state => di.get<YoutubeBloc>().state;

  YTConfig get ytConfig => _state.ytConfig!;
}
