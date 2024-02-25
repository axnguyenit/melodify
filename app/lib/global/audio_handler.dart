import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:core/core.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

@LazySingleton()
class AppAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  late final AudioPlayer _audioPlayer;
  late final AndroidLoudnessEnhancer _loudnessEnhancer;

  late StreamSubscription<PlaybackEvent> _playbackEventSubscription;
  late StreamSubscription<Duration?> _durationSubscription;
  late StreamSubscription<int?> _currentIndexSubscription;
  late StreamSubscription<SequenceState?> _sequenceStateSubscription;

  final _playlist = ConcatenatingAudioSource(children: []);

  final _processingStateMap = {
    ProcessingState.idle: AudioProcessingState.idle,
    ProcessingState.loading: AudioProcessingState.loading,
    ProcessingState.buffering: AudioProcessingState.buffering,
    ProcessingState.ready: AudioProcessingState.ready,
    ProcessingState.completed: AudioProcessingState.completed,
  };
  final _repeatModeMap = {
    LoopMode.off: AudioServiceRepeatMode.none,
    LoopMode.one: AudioServiceRepeatMode.one,
    LoopMode.all: AudioServiceRepeatMode.all,
  };

  Future<void> _initializeAudioPlayer() async {
    try {
      _loudnessEnhancer = AndroidLoudnessEnhancer();
      await _loudnessEnhancer.setEnabled(true);
      await _loudnessEnhancer.setTargetGain(0.5);
      _audioPlayer = AudioPlayer(
        audioPipeline: AudioPipeline(
          androidAudioEffects: [
            _loudnessEnhancer,
          ],
        ),
      );
      await _audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      log.error('Initialize Audio Player Error --> $e');
    }
  }

  void _initializeEventSubscriptions() {
    _playbackEventSubscription =
        _audioPlayer.playbackEventStream.listen(_listenPlaybackEvent);
    _durationSubscription = _audioPlayer.durationStream.listen(_listenDuration);
    _currentIndexSubscription =
        _audioPlayer.currentIndexStream.listen(_listenCurrentIndex);
    _sequenceStateSubscription =
        _audioPlayer.sequenceStateStream.listen(_listenSequenceState);
  }

  void _updatePlaybackState() {
    playbackState.add(
      playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (_audioPlayer.playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
          MediaControl.stop,
        ],
        systemActions: const {
          MediaAction.seek,
          MediaAction.seekForward,
          MediaAction.seekBackward,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: _processingStateMap[_audioPlayer.processingState]!,
        repeatMode: _repeatModeMap[_audioPlayer.loopMode]!,
        shuffleMode: _audioPlayer.shuffleModeEnabled
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        playing: _audioPlayer.playing,
        updatePosition: _audioPlayer.position,
        bufferedPosition: _audioPlayer.bufferedPosition,
        speed: _audioPlayer.speed,
        queueIndex: _audioPlayer.currentIndex ?? 0,
      ),
    );
  }

  Future<void> _initializeAudioSession() async {
    try {
      final session = await AudioSession.instance;
      await session.configure(const AudioSessionConfiguration.music());
      session.interruptionEventStream.listen((event) async {
        if (event.begin) {
          switch (event.type) {
            case AudioInterruptionType.duck:
              await _audioPlayer.setVolume(0.5);
              break;
            case AudioInterruptionType.pause:
            case AudioInterruptionType.unknown:
              await _audioPlayer.pause();
              break;
          }
        } else {
          switch (event.type) {
            case AudioInterruptionType.duck:
              await _audioPlayer.setVolume(1);
              break;
            case AudioInterruptionType.pause:
              await _audioPlayer.play();
              break;
            case AudioInterruptionType.unknown:
              break;
          }
        }
      });
    } catch (e) {
      log.error('Initialize Audio Session Error --> $e');
    }
  }

  Future<void> initialize() async {
    await _initializeAudioPlayer();
    _initializeEventSubscriptions();
    _updatePlaybackState();
    await _initializeAudioSession();

    await AudioService.init(
      builder: () => this,
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.n4.melodify',
        androidNotificationChannelName: 'Melodify',
        // androidNotificationIcon: 'drawable/ic_launcher',
        androidShowNotificationBadge: true,
        androidStopForegroundOnPause: false,
        // notificationColor: Palette.grey500,
      ),
    );
  }

  // TODO(ax): Support check hasNext and hasPervious

  void _listenPlaybackEvent(PlaybackEvent event) {
    try {
      if (event.processingState == ProcessingState.completed &&
          _audioPlayer.playing) {}
      _updatePlaybackState();
    } catch (e) {
      log.error('Listen Playback Event Error --> $e');
    }
  }

  void _listenDuration(Duration? duration) {
    try {
      final index = _audioPlayer.currentIndex;
      if (index == null || queue.value.isEmpty) return;
      final newQueue = List<MediaItem>.from(queue.value);
      final oldMediaItem = newQueue[index];
      final newMediaItem = oldMediaItem.copyWith(duration: duration);
      newQueue[index] = newMediaItem;
      queue.add(newQueue);
      mediaItem.add(newMediaItem);
    } catch (e) {
      log.error('Listen Duration Error --> $e');
    }
  }

  void _listenCurrentIndex(int? index) {
    try {
      if (index == null || queue.value.isEmpty) return;
      mediaItem.add(queue.value[index]);
    } catch (e) {
      log.error('Listen Current Song Index Error --> $e');
    }
  }

  void _listenSequenceState(SequenceState? sequenceState) {
    try {
      final sequence = sequenceState?.effectiveSequence;
      if (sequence == null || sequence.isEmpty) return;
      final items = sequence.map((source) => source.tag as MediaItem).toList();
      queue.add(items);
      // shuffleNotifier.value = sequenceState?.shuffleModeEnabled ?? false;
    } catch (e) {
      log.error('Listen Sequence State Error --> $e');
    }
  }

  Future<void> playMusic(MediaItem mediaItem) async {
    try {
      final audioSource = _mediaItemToAudioSource(mediaItem);
      await _audioPlayer.setAudioSource(audioSource, preload: false);
      await _audioPlayer.play();
    } catch (e) {
      log.error(e);
    }
  }

  Future<void> playPlaylist(List<MediaItem> queue, {int index = 0}) async {
    await updateQueue(queue);
    await setShuffleMode(AudioServiceShuffleMode.none);
    await customAction('skipToMediaItem', {'index': index});
    await play();
  }

  AudioSource _mediaItemToAudioSource(MediaItem mediaItem) {
    return AudioSource.uri(
      Uri.parse(mediaItem.extras!['url']),
      tag: mediaItem,
    );
  }

  List<AudioSource> _mediaItemsToAudioSources(List<MediaItem> mediaItems) {
    // TODO(ax): Config settings quality based on network 96kbps or 320kbps
    return mediaItems
        .map(_mediaItemToAudioSource)
        .whereType<AudioSource>()
        .toList();
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    final audioSource = _mediaItemToAudioSource(mediaItem);
    await _playlist.add(audioSource);
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    await _playlist.addAll(_mediaItemsToAudioSources(mediaItems));
  }

  @override
  Future<void> insertQueueItem(int index, MediaItem mediaItem) async {
    final audioSource = _mediaItemToAudioSource(mediaItem);
    await _playlist.insert(index, audioSource);
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    await _playlist.clear();
    await _playlist.addAll(_mediaItemsToAudioSources(newQueue));
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final shuffleEnabled = shuffleMode == AudioServiceShuffleMode.all;
    if (shuffleEnabled) await _audioPlayer.shuffle();

    //playbackState.add(playbackState.value.copyWith(shuffleMode: shuffleMode));
    await _audioPlayer.setShuffleModeEnabled(shuffleEnabled);
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    // playbackState.add(playbackState.value.copyWith(repeatMode: repeatMode));
    await _audioPlayer.setLoopMode(LoopMode.values[repeatMode.index]);
  }

  @override
  Future<void> click([MediaButton button = MediaButton.media]) async {
    await super.click(button);
    // switch (button) {
    //   case MediaButton.media:
    //   // _handleMediaActionPressed();
    //   case MediaButton.next:
    //     await skipToNext();
    //   case MediaButton.previous:
    //     await skipToPrevious();
    // }
  }

  @override
  Future<void> play() async {
    return _audioPlayer.play();
  }

  @override
  Future<void> pause() async {
    return _audioPlayer.pause();
  }

  @override
  Future<void> seek(Duration position) async {
    return _audioPlayer.seek(position);
  }

  @override
  Future<void> stop() async {
    await _audioPlayer.stop();
    // await playbackState.firstWhere(
    //     (state) => state.processingState == AudioProcessingState.idle);
  }

  @override
  Future<void> onTaskRemoved() async {
    await _audioPlayer.stop();
    await _audioPlayer.dispose();
    await _playbackEventSubscription.cancel();
    await _durationSubscription.cancel();
    await _currentIndexSubscription.cancel();
    await _sequenceStateSubscription.cancel();

    await super.onTaskRemoved();
  }
}
