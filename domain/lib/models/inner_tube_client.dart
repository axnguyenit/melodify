class InnerTubeClient {
  final String hl;
  final String gl;
  final String remoteHost;
  final String deviceMake;
  final String deviceModel;
  final String visitorData;
  final String userAgent;
  final String clientName;
  final String clientVersion;
  final String osName;
  final String osVersion;
  final String originalUrl;
  final String platform;
  final String clientFormFactor;
  final Map<String, String> configInfo;
  final String browserName;
  final String browserVersion;
  final String deviceExperimentId;

  InnerTubeClient({
    required this.hl,
    required this.gl,
    required this.remoteHost,
    this.deviceMake = '',
    this.deviceModel = '',
    required this.visitorData,
    required this.userAgent,
    required this.clientName,
    required this.clientVersion,
    required this.osName,
    required this.osVersion,
    required this.originalUrl,
    required this.platform,
    required this.clientFormFactor,
    required this.configInfo,
    required this.browserName,
    required this.browserVersion,
    required this.deviceExperimentId,
  });

  factory InnerTubeClient.fromJson(Map<String, dynamic> json) {
    return InnerTubeClient(
      hl: json['hl'],
      gl: json['gl'],
      remoteHost: json['remoteHost'],
      deviceMake: json['deviceMake'] ?? '',
      deviceModel: json['deviceModel'] ?? '',
      visitorData: json['visitorData'],
      userAgent: json['userAgent'],
      clientName: json['clientName'],
      clientVersion: json['clientVersion'],
      osName: json['osName'],
      osVersion: json['osVersion'],
      originalUrl: json['originalUrl'],
      platform: json['platform'],
      clientFormFactor: json['clientFormFactor'],
      configInfo: Map<String, String>.from(json['configInfo']),
      browserName: json['browserName'],
      browserVersion: json['browserVersion'],
      deviceExperimentId: json['deviceExperimentId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hl': hl,
      'gl': gl,
      'remoteHost': remoteHost,
      'deviceMake': deviceMake,
      'deviceModel': deviceModel,
      'visitorData': visitorData,
      'userAgent': userAgent,
      'clientName': clientName,
      'clientVersion': clientVersion,
      'osName': osName,
      'osVersion': osVersion,
      'originalUrl': originalUrl,
      'platform': platform,
      'clientFormFactor': clientFormFactor,
      'configInfo': configInfo,
      'browserName': browserName,
      'browserVersion': browserVersion,
      'deviceExperimentId': deviceExperimentId,
    };
  }
}
