import 'package:melodify/blocs/blocs.dart';
import 'package:melodify/di/di.dart';
import 'package:domain/domain.dart';

mixin VideoDetailsData {
  VideoDetailsState get _state => di.get<VideoDetailsBloc>().state;

  VideoDetails? get videoDetails => _state.videoDetails;
}
