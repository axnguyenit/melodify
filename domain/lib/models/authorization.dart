import 'package:domain/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'authorization.g.dart';

@JsonSerializable()
class Authorization extends Model {
  final String accessToken;
  final String? profileToken;

  Authorization({
    this.profileToken,
    required this.accessToken,
  });

  factory Authorization.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationFromJson(json);

  Authorization copyWith({String? accessToken, String? profileToken}) {
    return Authorization(
      accessToken: accessToken ?? this.accessToken,
      profileToken: profileToken ?? this.profileToken,
    );
  }

  @override
  List<Object> get props => [accessToken];

  @override
  Map<String, dynamic> toJson() => _$AuthorizationToJson(this);
}
