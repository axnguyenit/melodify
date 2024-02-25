class GetPlayerRequest {
  final String? videoId;
  final String? playlistId;

  GetPlayerRequest({
    required this.videoId,
    required this.playlistId,
  });

  // TODO(ax): Update hl, gl payload data
  Map<String, dynamic> toPayload() {
    return {
      if (videoId != null) 'videoId': videoId,
      if (playlistId != null) 'playlistId': playlistId,
      'context': {
        'client': {
          'clientName': 'ANDROID_TESTSUITE',
          'clientVersion': '1.9',
          'androidSdkVersion': 30,
          'hl': 'en',
          'gl': 'US',
          'utcOffsetMinutes': 0,
        },
      },
    };
  }
}
