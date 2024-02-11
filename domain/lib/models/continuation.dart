import 'package:core/core.dart';
import 'package:domain/domain.dart';
import 'package:domain/models/helpers.dart';

class Continuation extends Model {
  final String itct; // clickTrackingParams
  final String continuation;

  Continuation({
    required this.itct,
    required this.continuation,
  });

  factory Continuation.fromJson(Map<String, dynamic> json) {
    try {
      final data = getValue(json, ['nextContinuationData'], {});

      return Continuation(
        continuation: getValue<String>(data, ['continuation'], ''),
        itct: getValue<String>(
          data,
          ['clickTrackingParams'],
          '',
        ),
      );
    } catch (e) {
      log.error('Parse Continuation Error --> $e');
      rethrow;
    }
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'itct': itct,
      'continuation': continuation,
    };
  }

  @override
  List<Object> get props => [];
}
