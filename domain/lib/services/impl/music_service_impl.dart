import 'package:domain/domain.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MusicService)
class MusicServiceImpl implements MusicService {
  MusicServiceImpl();
}
